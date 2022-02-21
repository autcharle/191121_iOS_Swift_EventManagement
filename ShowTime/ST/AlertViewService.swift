//
//  AlertViewService.swift
//  ST
//
//  Created by Tuyen Tran on 11/9/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit

class AlerViewService
{
    func showAlert() -> AlertViewController
    {
        let storyboard = UIStoryboard(name: "AlertView", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        return vc
    }
    
    func showAlert2() -> AlertViewController2
    {
        let storyboard = UIStoryboard(name: "AlertView", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlertViewController2") as! AlertViewController2
        return vc
    }
}
