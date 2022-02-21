//
//  GuestNameViewController.swift
//  ST
//
//  Created by Tuyen Tran on 11/12/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit
import RealmSwift

class GuestNameViewController: UIViewController
{
    @IBOutlet weak var GuestNameTable: UITableView!
    @IBOutlet weak var HomeBtn: UIButton!
    @IBOutlet weak var Label: UILabel!
    var char = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadCurrentEvent()
        //GuestNameTable.reloadData()
    }
    
    

    @IBAction func goBack(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadCurrentEvent()
    {
        let realm = try! Realm()
        let data = realm.objects(EventTemplate.self)[0]
        let size = Float(data.FontSize!)
        self.Label.font = UIFont(name: data.FontName!, size: CGFloat(size!))
        self.Label.textColor = UIColor.init(ciColor: CIColor.init(string: data.FontColor!))
    }
}

extension GuestNameViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let predicate = NSPredicate(format: "LastName BEGINSWITH [c]%@", char)
        let realm = try! Realm()
        let record = realm.objects(GuestTemplate.self).filter(predicate)
        return record.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let predicate = NSPredicate(format: "LastName BEGINSWITH [c]%@", char)
        let realm = try! Realm()
        let record = realm.objects(GuestTemplate.self).filter(predicate)
        let event = realm.objects(EventTemplate.self)[0]
        //print(record[0].FirstName ?? "")
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! NameCell
        let data = record[indexPath.row]
        cell.NameLabel.text = String("\(data.LastName!), \(data.FirstName!)")
        let size = Float(event.FontSize!)
        cell.NameLabel.font = UIFont(name: event.FontName!, size: CGFloat(size!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GuestTableViewController") as! GuestTableViewController
        vc.modalPresentationStyle = .fullScreen
        let realm = try! Realm()
        //let data = realm.objects(GuestTemplate.self).filter("FirstName = guestFirstName AND LastName = guestLastName")
        let predicate = NSPredicate(format: "LastName BEGINSWITH [c]%@", char)
        let record = realm.objects(GuestTemplate.self).filter(predicate)
        
        let guestFirstName = record[indexPath.row].FirstName
        let guestLastName = record[indexPath.row].LastName
        var temp : [Int] = []
        for r in record
        {
            if r.FirstName == guestFirstName && r.LastName == guestLastName
            {
                temp.append(record.index(of: r)!)
            }
        }
        vc.firstName = guestFirstName!
        vc.lastName = guestLastName!
        vc.index = temp.firstIndex(of: indexPath.row)!
        self.present(vc,animated: false)
    }
    
}
