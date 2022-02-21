//
//  AlertViewController2.swift
//  ST
//
//  Created by Tuyen Tran on 11/13/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit

class AlertViewController2: UIViewController {

    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var OKBtn: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    @IBAction func didTapOK(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
 
}
