//
//  EventViewController.swift
//  ST
//
//  Created by Tuyen Tran on 11/9/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit
import EFColorPicker
import RealmSwift

class EventViewController: UIViewController, UIFontPickerViewControllerDelegate, UIPopoverPresentationControllerDelegate, EFColorSelectionViewControllerDelegate
{
    func colorViewController(_ colorViewCntroller: EFColorSelectionViewController, didChangeColor color: UIColor)
    {
        self.FontColorLabel.backgroundColor = color
    }
    
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var EventTextField: UITextField!
    @IBOutlet weak var FontLabel: UILabel!
    @IBOutlet weak var FontSizeLabel: UILabel!
    @IBOutlet weak var FontSizeSlider: UISlider!
    @IBOutlet weak var FontColorLabel: UILabel!
    @IBOutlet weak var FontOptionBtn: UIButton!
    @IBOutlet weak var FontColorOptionBtn: UIButton!
    @IBOutlet weak var addGuestBtn: UIButton!
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var GuestRecordsTable: UITableView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var choosePosterBtn: UIButton!
    var Title = String()
    let service = DataService()
    //var IndexList : [IndexPath] = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
        TitleLabel.text = Title
        FontSizeSlider.maximumValue = 80.0
        FontSizeSlider.minimumValue = 17.0
        FontSizeLabel.text = Int(FontSizeSlider.minimumValue).description
        loadCurrentEvent()
        FontSizeSlider.value = Float(FontSizeLabel.text!)!
        //TitleLabel.font = UIFont(name: FontName, size: 35)
        //GuestRecordsTable.reloadData()
    }
    
    func loadCurrentEvent()
    {
        let realm = try! Realm()
        let data = realm.objects(EventTemplate.self)
        if data.isEmpty
        {
            
        }
        else
        {
            self.EventTextField.text = data[0].Name
            self.FontLabel.font = UIFont(name: data[0].FontName!, size: 24)
            self.FontLabel.text = data[0].FontName
            self.FontColorLabel.backgroundColor = UIColor.init(ciColor: CIColor.init(string: data[0].FontColor!))
            self.FontSizeLabel.text = data[0].FontSize
            self.choosePosterBtn.layer.cornerRadius = 15.0
        }
    }
    
    @IBAction func FontSizeValueChanged(_ sender: Any)
    {
        let value = Int(FontSizeSlider.value)
        FontSizeLabel.text = value.description
    }
    
    @IBAction func gotoAdminView(_ sender: Any)
    {
        service.deleteData()
        let vc = self.presentingViewController
        if vc?.title == "AlertVC"
        {
            self.dismiss(animated: true, completion: {vc?.dismiss(animated: true, completion: nil)})
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func didTapAdd(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GuestRecordViewController") as! GuestRecordViewController
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        self.present(vc,animated: false)
    }
    @IBAction func selectFont(_ sender: Any)
    {
        let VC = UIFontPickerViewController()
        VC.delegate = self
        self.present(VC,animated: false)
    }
    
    func fontPickerViewControllerDidPickFont(_ ViewController: UIFontPickerViewController) {
        guard let Descriptor = ViewController.selectedFontDescriptor else { return }

        let Font = UIFont(descriptor: Descriptor, size: 24)
        FontLabel.font = Font
        FontLabel.text = Font.familyName
    }
    @IBAction func selectFontColor(_ sender: UIButton)
    {
        let ColorSelectionController = EFColorSelectionViewController()
        let navCtrl = UINavigationController(rootViewController: ColorSelectionController)
        navCtrl.navigationBar.backgroundColor = UIColor.white
        navCtrl.navigationBar.isTranslucent = false
        navCtrl.modalPresentationStyle = UIModalPresentationStyle.popover
        navCtrl.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        navCtrl.popoverPresentationController?.delegate = self
        navCtrl.popoverPresentationController?.sourceView = sender
        navCtrl.popoverPresentationController?.sourceRect = sender.bounds
        navCtrl.preferredContentSize = ColorSelectionController.view.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize)
        ColorSelectionController.isColorTextFieldHidden = false
        ColorSelectionController.delegate = self
        ColorSelectionController.color = self.FontColorLabel.backgroundColor ?? UIColor.white
        self.present(navCtrl, animated: true, completion: nil)
    }
    @IBAction func saveEvent(_ sender: Any)
    {
        let color = FontColorLabel.backgroundColor?.toString()
        service.addData(name: EventTextField.text ?? "", fontName: FontLabel.text ?? "Arial", fontSize: FontSizeLabel.text ?? "17", fontColor: color ?? "0 0 0 1")
        service.confirmRecordStored()
        let vc = self.presentingViewController
        if vc?.title == "AlertVC"
        {
            self.dismiss(animated: true, completion: {vc?.dismiss(animated: true, completion: nil)})
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    @IBAction func removeGuest(_ sender: Any)
    {
            let realm = try! Realm()
            let record = realm.objects(GuestTemplate.self)
            //for idx in IndexList
            for data in record
            {
                let index = IndexPath.init(row: record.index(of: data)!, section: 0)
                if (service.isToDelete(index: index.row))
                {
                    try! realm.write
                    {
                        realm.delete(data)
                    }
                    GuestRecordsTable.deleteRows(at: [index], with: .fade)
                }
            }
        //IndexList.removeAll()
    }
    @IBAction func choosePoster(_ sender: Any)
    {
        showImagePickerController()
    }
}

extension EventViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let realm = try! Realm()
        let record = realm.objects(GuestTemplate.self)
        return record.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let realm = try! Realm()
        let record = realm.objects(GuestTemplate.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestRecordCell", for: indexPath) as! GuestRecordCell
        let data = record[indexPath.row]
        cell.GuestName.text = String("\(data.LastName!), \(data.FirstName!)")
        cell.NumOfGuests.text = data.Guests
        cell.GuestTable.text = data.Table
        cell.GuestSection.text = data.Section
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        service.confirmRecordToDelete(indexPathRow: indexPath.row)
        //IndexList.append(indexPath)
        //print(indexPath.row)
        //print(IndexList.count)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        service.confirmRecordNotToDelete(indexPathRow: indexPath.row)
        //IndexList.removeLast()
        //print(indexPath.row)
        //print(IndexList.count)
    }
}

extension UIColor
{
    func toString() -> String
    {
         let colorRef = self.cgColor
         return CIColor(cgColor: colorRef).stringRepresentation
    }
}

extension EventViewController : reloadTableDelegate
{
    func reloadTable()
    {
        GuestRecordsTable.reloadData()
    }
}

extension EventViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func showImagePickerController()
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.modalPresentationStyle = .overFullScreen
        self.present(imagePickerController,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
