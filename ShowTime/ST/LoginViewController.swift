//
//  LoginViewController.swift
//  ST
//
//  Created by Tuyen Tran on 11/14/19.
//  Copyright © 2019 Tuyen Tran. All rights reserved.
//

import UIKit
class Account : Codable
{
    var username: String
    var password: String
    
    init()
    {
        username = ""
        password = ""
    }
    
    static func loadFrom(data: Data) -> Account?
    {
        var account: Account?
        do
        {
            let decoder: JSONDecoder = JSONDecoder()
            account = try decoder.decode(Account.self, from: data)
        }
        catch
        {
            print("Error: \(error)")
            return nil
        }
        
        return account
    }
}
class LoginViewController: UIViewController {

    @IBOutlet weak var UsernameTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    var account = Account()
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    func checkAccount(account: Account) -> Bool
    {
        return UsernameTF.text! != "" &&  PasswordTF.text! != "" && UsernameTF.text! == account.username && PasswordTF.text! == account.password
    }
    
    func loginTask()
    {
        let url = URL(string: "https://private-b9d7ae-showtimelogin.apiary-mock.com/authentication")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            if let response = response
            {
                print(response)
                
                if let data = data, let body = String(data: data, encoding: .utf8)
                {
                    print(body)
                    
                    self.account = Account.loadFrom(data: data)!
                }
            }
            else
            {
                print(error ?? "Unknown error")
            }
        }
        
        task.resume()
    }
    @IBAction func didTapLogin(_ sender: Any)
    {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2)
        {
            // Get correct account
            self.loginTask()
            
            let alertController: UIAlertController = UIAlertController(title: "Notification", message: "Waiting for 3 seconds...", preferredStyle: UIAlertController.Style.alert)
            alertController.view.backgroundColor = UIColor.white
            self.present(alertController, animated: true)
            // Go to mainVC
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0)
            {
                alertController.dismiss(animated: false, completion: nil)
                if self.checkAccount(account: self.account)
                {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc,animated: true)
                }
                else
                {
                    alertController.message = "Invalid account, please try again!"
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alertController, animated: true)
                    return
                }
            }
        }
    }
}
