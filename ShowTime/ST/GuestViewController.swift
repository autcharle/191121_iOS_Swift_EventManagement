//
//  GuestViewController.swift
//  ST
//
//  Created by Tuyen Tran on 11/8/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit
import RealmSwift

class GuestViewController: UIViewController
{
    @IBOutlet weak var findMyTableBtn: UIButton!
    @IBOutlet weak var EventNameLabel: UILabel!
    @IBOutlet weak var EventImageView: UIImageView!
   // var img = UIImage()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadCurrentEvent()

    }
    @IBAction func gotoGuestSearch(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier:  "GuestSearchViewController") as! GuestSearchViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc,animated: true)
    }
    func loadCurrentEvent()
    {
        let realm = try! Realm()
        let data = realm.objects(EventTemplate.self)[0]
        let size = Float(data.FontSize!)
        self.EventNameLabel.text = data.Name
        self.EventNameLabel.font = UIFont(name: data.FontName!, size: CGFloat(size!))
        self.EventNameLabel.textColor = UIColor.init(ciColor: CIColor.init(string: data.FontColor!))
        //self.EventImageView.image = img
    }
}
