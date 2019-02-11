//
//  ForgotPasswordViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 11/11/18.
//  Copyright © 2018 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit


class ForgotPasswordViewController: UIViewController {
    
    //let backendless = Backendless.sharedInstance()
    @IBOutlet weak var emailTF: UITextField!
    
    
    func display(title:String, msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        Backendless.sharedInstance()!.userService.restorePassword(emailTF.text!, response: {
            self.display(title: "Check Inbox", msg: "If you have entered correct email you will get an mail to reset the password")
        }, error: { fault in
            self.display(title: "Something is Wrong", msg: (fault?.message!)!)
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appbg.jpg")!)
        
        // Do any additional setup after loading the view.
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
