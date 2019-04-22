//
//  MessageDetailViewController.swift
//  Smart Inventory
//
//  Created by vamshi raj on 4/7/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    var message:Message!
    
    @IBOutlet weak var subjectLBL: UILabel!
    @IBOutlet weak var messageTV: UITextView!
    
    @IBAction func onCancelNewMessages(segue:UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjectLBL.text = message.subject
        messageTV.text = message.message
        // Do any additional setup after loading the view.
    }
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
