//
//  MainViewController.swift
//  ST
//
//  Created by Tuyen Tran on 11/8/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController
{
    @IBOutlet weak var GuestViewBtn: UIButton!
    @IBOutlet weak var AdminViewBtn: UIButton!
    let alertService = AlerViewService()
    let dataService = DataService()
    @IBAction func goAsAdmin(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AdminViewController") as! AdminViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc,animated: true)
    }
    
    @IBAction func goAsGuest(_ sender: Any)
    {
        if dataService.eventIsEmpty()
        {
            let AlertVC = alertService.showAlert2()
            self.present(AlertVC,animated: true)
        }
        else
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "GuestViewController") as! GuestViewController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .partialCurl
            self.present(vc,animated: true)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
}
