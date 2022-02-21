//
//  GuestTableViewController.swift
//  ST
//
//  Created by Tuyen Tran on 11/12/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit
import RealmSwift

class GuestTableViewController: UIViewController
{
    var firstName = String()
    var lastName = String()
    var index = Int()
    var checkIfItIsTheSame = false
    var i = 0
    var MaxSizeOfThisScreen = 30.0
    //
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var TableNumberLabel: UILabel!
    @IBOutlet weak var GuestsLabel: UILabel!
    @IBOutlet weak var SectionLabel: UILabel!
    @IBOutlet weak var TableNumber: UILabel!
    @IBOutlet weak var Guests: UILabel!
    @IBOutlet weak var Section: UILabel!
    @IBOutlet weak var InMyTableLabel: UILabel!
    @IBOutlet weak var GuestInMyTable: UITableView!
    @IBOutlet weak var DoneBtn: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadCurrentEvent()
        print(index)
    }
    @IBAction func goBack(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadCurrentEvent()
    {
        
        let realm = try! Realm()
        let data = realm.objects(GuestTemplate.self).filter("FirstName = %@ AND LastName = %@",firstName,lastName)[index]
        self.NameLabel.text = String("\(data.LastName!), \(data.FirstName!)")
        let event = realm.objects(EventTemplate.self)[0]
        var size = Float(event.FontSize!)
        self.NameLabel.font = UIFont(name: event.FontName!, size: CGFloat(size!))
        self.NameLabel.textColor = UIColor.init(ciColor: CIColor.init(string: event.FontColor!))
        if (size! > Float(MaxSizeOfThisScreen))
        {
            size = Float(MaxSizeOfThisScreen)
        }
        self.TableNumberLabel.font = UIFont(name: event.FontName!, size: CGFloat(size!))
        self.GuestsLabel.font = TableNumberLabel.font
        self.SectionLabel.font = TableNumberLabel.font
        self.InMyTableLabel.font = TableNumberLabel.font
        self.TableNumber.text = data.Table!
        self.Guests.text = data.Guests!
        self.Section.text = data.Section!
    }
}

extension GuestTableViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let realm = try! Realm()
        let record = realm.objects(GuestTemplate.self).filter("Table = %@ AND Section = %@", self.TableNumber.text!, self.Section.text!)
            return record.count - 1

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let realm = try! Realm()
        let record = realm.objects(GuestTemplate.self).filter("Table = %@ AND Section = %@", self.TableNumber.text!, self.Section.text!)
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestInMyTableCell", for: indexPath) as! GuestInMyTableCell
        if record[indexPath.row].FirstName == firstName && record[indexPath.row].LastName == lastName
        {
            i = i + 1
        }
        
        if i > index
        {
            let idxPath = indexPath.row + 1
            let data = record[idxPath]
            cell.GuestNames.text = String("\(data.LastName!), \(data.FirstName!)")
            cell.Guests.text = data.Guests
            return cell
        }
        else
        {
        //
            let data = record[indexPath.row]
            cell.GuestNames.text = String("\(data.LastName!), \(data.FirstName!)")
            cell.Guests.text = data.Guests
            return cell
        }
    }
}
