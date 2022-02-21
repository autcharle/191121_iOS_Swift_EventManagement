//
//  GuestSearchViewController.swift
//  ST
//
//  Created by Tuyen Tran on 11/10/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit
import RealmSwift

class GuestSearchViewController: UIViewController
{

    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var isA: UIButton!
    @IBOutlet weak var isB: UIButton!
    @IBOutlet weak var isC: UIButton!
    @IBOutlet weak var isD: UIButton!
    @IBOutlet weak var isE: UIButton!
    @IBOutlet weak var isF: UIButton!
    @IBOutlet weak var isG: UIButton!
    @IBOutlet weak var isH: UIButton!
    @IBOutlet weak var isI: UIButton!
    @IBOutlet weak var isJ: UIButton!
    @IBOutlet weak var isK: UIButton!
    @IBOutlet weak var isL: UIButton!
    @IBOutlet weak var isM: UIButton!
    @IBOutlet weak var isN: UIButton!
    @IBOutlet weak var isO: UIButton!
    @IBOutlet weak var isP: UIButton!
    @IBOutlet weak var isQ: UIButton!
    @IBOutlet weak var isR: UIButton!
    @IBOutlet weak var isS: UIButton!
    @IBOutlet weak var isT: UIButton!
    @IBOutlet weak var isU: UIButton!
    @IBOutlet weak var isV: UIButton!
    @IBOutlet weak var isW: UIButton!
    @IBOutlet weak var isX: UIButton!
    @IBOutlet weak var isY: UIButton!
    @IBOutlet weak var isZ: UIButton!
    let CharList = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadCurrentEvent()
    }

    @IBAction func gotoMainView(_ sender: Any)
    {
        let vc = self.presentingViewController
        self.dismiss(animated: true, completion: {vc?.dismiss(animated: false, completion: nil)})
    }
    
    @IBAction func didTapAChar(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GuestNameViewController") as! GuestNameViewController
        vc.modalPresentationStyle = .fullScreen
        let button = sender as! UIButton
        vc.char = CharList[button.tag - 1]
        self.present(vc,animated: false)
    }
    
    func loadCurrentEvent()
    {
        isA.layer.cornerRadius = 15.0
        isB.layer.cornerRadius = 15.0
        isC.layer.cornerRadius = 15.0
        isD.layer.cornerRadius = 15.0
        isE.layer.cornerRadius = 15.0
        isF.layer.cornerRadius = 15.0
        isG.layer.cornerRadius = 15.0
        isH.layer.cornerRadius = 15.0
        isI.layer.cornerRadius = 15.0
        isJ.layer.cornerRadius = 15.0
        isK.layer.cornerRadius = 15.0
        isL.layer.cornerRadius = 15.0
        isM.layer.cornerRadius = 15.0
        isN.layer.cornerRadius = 15.0
        isO.layer.cornerRadius = 15.0
        isP.layer.cornerRadius = 15.0
        isQ.layer.cornerRadius = 15.0
        isR.layer.cornerRadius = 15.0
        isS.layer.cornerRadius = 15.0
        isT.layer.cornerRadius = 15.0
        isU.layer.cornerRadius = 15.0
        isV.layer.cornerRadius = 15.0
        isW.layer.cornerRadius = 15.0
        isX.layer.cornerRadius = 15.0
        isY.layer.cornerRadius = 15.0
        isZ.layer.cornerRadius = 15.0
        let realm = try! Realm()
        let data = realm.objects(EventTemplate.self)[0]
        let size = Float(data.FontSize!)
        self.Label.font = UIFont(name: data.FontName!, size: CGFloat(size!))
        self.Label.textColor = UIColor.init(ciColor: CIColor.init(string: data.FontColor!))
    }
    
}
