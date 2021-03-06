//
//  NewMessageViewController.swift
//  Smart Inventory
//
//  Created by vamshi raj on 4/5/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class NewMessageViewController: UIViewController {

    @IBOutlet weak var subjectTF: UITextField!
    @IBOutlet weak var messageTF: UITextView!
    
    static var newMVC:NewMessageViewController = NewMessageViewController()
    var subject:String!
    var email:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print(self.subject)
            subjectTF.text = subject
      
    }
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func displayAlert(msg: String, sent: Bool){
        let  alert  =  UIAlertController(title:  "Message",  message: msg,  preferredStyle:  .alert)
        
        if sent {
            alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  { _ in
                
                self.dismiss(animated: true, completion: nil)
            }))
        } else {
            alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler: nil))
        }
        
        self.present(alert,  animated:  true,  completion:  nil)
        
    }
    
   
    
    @IBAction func sendBtn(_ sender: Any) {
        if let subject = subjectTF.text, let message = messageTF.text, !subject.isEmpty, !message.isEmpty
        {
            if(Backendless.sharedInstance()!.userService.currentUser.getProperty("email") as! String != "inventory.adm@yandex.ru" ){
                self.email = "inventory.adm@yandex.ru"
            }
            let backendless = Backendless.sharedInstance()
            let message = Message(subject: subject, message: message, name: backendless?.userService.currentUser.getProperty("name") as! String, email: backendless?.userService.currentUser.getProperty("email") as! String, toEmail: self.email)
            Messages.messages.saveMessage(message: message)
            
            
            self.displayAlert(msg: "Message Sent", sent: true)
        } else {
            self.displayAlert(msg: "Enter All required fields", sent: false)
        }
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
