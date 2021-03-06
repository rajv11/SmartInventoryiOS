//
//  AdminReplyViewController.swift
//  Smart Inventory
//
//  Created by vamshi raj on 4/10/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class AdminReplyViewController: UIViewController {

    @IBOutlet weak var subjectTF: UITextField!
    @IBOutlet weak var messageTV: UITextView!
    var userMessage:Message!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        subjectTF.text = self.userMessage.subject
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

    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtn(_ sender: Any) {
        if let subject = subjectTF.text, let message = messageTV.text, !subject.isEmpty, !message.isEmpty
        {
            let backendless = Backendless.sharedInstance()
            let message = Message(subject: subject, message: message, name: backendless?.userService.currentUser.getProperty("name") as! String, email: "inventory.adm@yandex.ru", toEmail: self.userMessage.email )
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
