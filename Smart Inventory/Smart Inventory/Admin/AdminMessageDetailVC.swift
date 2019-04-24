//
//  AdminMessageDetailVC.swift
//  Smart Inventory
//
//  Created by vamshi raj on 4/7/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class AdminMessageDetailVC: UIViewController {
    @IBOutlet weak var subjectLBL: UILabel!
    @IBOutlet weak var messageTV: UITextView!
    @IBOutlet weak var replyBtn: UIButton!
    
    @IBOutlet weak var fromLBL: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    var message:Message!
    var isAdmin:Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.replyBtn.isHidden = isAdmin
        self.navBar.topItem?.title = message.name
        
        subjectLBL.text = message.subject
        messageTV.text = message.message
        fromLBL.text = message.email
        // Do any additional setup after loading the view.
    }
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adminReply" {
            let messageVC = segue.destination as! AdminReplyViewController
            messageVC.userMessage = self.message
            
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
