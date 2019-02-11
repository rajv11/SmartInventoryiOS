//
//  UserProfileViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 11/10/18.
//  Copyright © 2018 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var numberLBL: UILabel!
    @IBOutlet weak var addressLBL: UILabel!
    @IBOutlet weak var addres2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appbg.jpg")!)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let user  = Backendless.sharedInstance()
        
        
        nameLBL.text = user?.userService.currentUser.getProperty("name") as? String
        emailLBL.text = user?.userService.currentUser.getProperty("email") as? String
        numberLBL.text = user?.userService.currentUser.getProperty("mobile") as? String
        addressLBL.text = user?.userService.currentUser.getProperty("address") as? String
        addres2.text = ("\(user?.userService.currentUser.getProperty("city") as! String), \(user?.userService.currentUser.getProperty("state") as! String) \(user?.userService.currentUser.getProperty("zip") as! String)")

        
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
