//
//  AdminViewController.swift
//  ST
//
//  Created by Tuyen Tran on 11/8/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController
{
    @IBOutlet weak var ExitBtn: UIButton!
    @IBOutlet weak var createEventBtn: UIButton!
    @IBOutlet weak var editEventBtn: UIButton!
    let alertService = AlerViewService()
    let dataService = DataService()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Button Customizations
        createEventBtn.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        createEventBtn.layer.cornerRadius = 15.0
        createEventBtn.tintColor = UIColor.white
        createEventBtn.layer.borderWidth = 1
        createEventBtn.layer.borderColor = UIColor.blue.cgColor
        editEventBtn.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        editEventBtn.layer.cornerRadius = 15.0
        editEventBtn.tintColor = UIColor.white
        editEventBtn.layer.borderWidth = 1
        editEventBtn.layer.borderColor = UIColor.blue.cgColor
        
        //
    }
    @IBAction func createEvent(_ sender: Any)
    {
        //let alert = UIAlertController(title: "My title here", message: "My message here", preferredStyle: .alert)
        //let cancelAction = UIAlertAction(title: "Cancel", style: .cancel,handler: nil)
        //alert.addAction(cancelAction)
        //self.present(alert,animated: true, completion: nil)
        let AlertVC = alertService.showAlert()
        self.present(AlertVC, animated: true)
    }
    
    
    @IBAction func editEvent(_ sender: Any)
    {
        if dataService.eventIsEmpty()
        {
            let AlertVC = alertService.showAlert2()
            self.present(AlertVC,animated: true)
        }
        else
        {
            let VC = storyboard?.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
            VC.modalPresentationStyle = .fullScreen
            VC.modalTransitionStyle = .crossDissolve
            VC.Title = "EDIT CURRENT EVENT"
            self.present(VC,animated: true)
        }
    }
    
    @IBAction func gotoMainView(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
