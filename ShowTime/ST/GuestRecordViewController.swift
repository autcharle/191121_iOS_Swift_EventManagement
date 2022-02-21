//
//  GuestRecordViewController.swift
//  ST
//
//  Created by Tuyen Tran on 11/9/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit

protocol reloadTableDelegate {
    func reloadTable()
}

class GuestRecordViewController: UIViewController
{
    @IBOutlet weak var FirstNameField: UITextField!
    @IBOutlet weak var LastNameField: UITextField!
    @IBOutlet weak var GuestsField: UITextField!
    @IBOutlet weak var TableField: UITextField!
    @IBOutlet weak var SectionField: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    let service = DataService()
    var delegate : reloadTableDelegate?
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    @IBAction func goBack(_ sender: Any)
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func saveGuest(_ sender: Any)
    {
        service.addRecord(firstName: FirstNameField.text ?? "", lastName: LastNameField.text ?? "", guests: GuestsField.text ?? "", table: TableField.text ?? "", section: SectionField.text ?? "")
        delegate?.reloadTable()
        self.dismiss(animated: false, completion: nil)
    }
    
}
