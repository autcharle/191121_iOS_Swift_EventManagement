//
//  AlertViewController.swift
//  ST
//
//  Created by Tuyen Tran on 11/9/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController
{
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var OKBtn: UIButton!
    @IBOutlet weak var CancelBtn: UIButton!
    let service = DataService()
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    @IBAction func didTapOK(_ sender: Any)
    {
        service.deleteAllData()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        vc.modalPresentationStyle = .fullScreen
        vc.Title = "CREATE NEW EVENT"
        self.present(vc,animated: true)
    }
    @IBAction func didTapCancel(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
}
