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
    
    @IBOutlet weak var navBar: UINavigationBar!
    var message:Message!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar.topItem?.title = message.name
        
        subjectLBL.text = message.subject
        messageTV.text = message.message
        // Do any additional setup after loading the view.
    }
    @IBAction func backBtn(_ sender: Any) {
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
