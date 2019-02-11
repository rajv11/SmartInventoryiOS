//
//  ViewController.swift
//  Smart Inventory
//
//  Created by Jennaikode,Vamshi Raj on 10/3/18.
//  Copyright © 2018 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBAction func register(segue:UIStoryboardSegue){}
    @IBAction func cancel(segue:UIStoryboardSegue){}
    
    @IBAction func resetPassword(segue:UIStoryboardSegue){}
    @IBAction func cancelReset(segue:UIStoryboardSegue){}
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appbg.jpg")!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func display(title:String, msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
//        if (userNameTF.text == "" || passwordTF.text == "") {
//            self.display(title: "Login failed", msg: "Please enter email and password to continue")
//        }
//        else {
            Backendless.sharedInstance().userService.login(userNameTF.text!,
                                                           password: passwordTF.text!,
                response: { user in
                    if user != nil {
                                if self.rememberMeSwitch.isOn {
                                    Backendless.sharedInstance()?.userService.setStayLoggedIn(true)
                                        } else {
                                    Backendless.sharedInstance()?.userService.setStayLoggedIn(false)
                                        }
                        self.performSegue(withIdentifier: "login", sender: user)
                                    }
                                                            
            },error: { fault in
                self.display(title: "Login Failed", msg: (fault?.message!)!)
                
            })
            
//        }
        
    }
    
    
    
    
    
    
}

