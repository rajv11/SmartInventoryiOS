//
//  ClaimProductsViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 2/17/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class ClaimProductsViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UITextView!
    @IBOutlet weak var requiredLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var claimCount: UITextField!
    var announcement:Announcemnet!
    let backendless = Backendless.sharedInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        titleLbl.text = String(announcement.product.name)
        descLbl.text = String(announcement.product.productDescription)
        requiredLbl.text = String(announcement.unclaimed)
        priceLbl.text = String(announcement.product.price)
    }
    
    func displayAlert(msg: String){
        let  alert  =  UIAlertController(title:  "Claim",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  { _ in
            self.performSegue(withIdentifier: "claim", sender: nil)
        }))
        self.present(alert,  animated:  true,  completion:  nil)    }

    
    func displayError(msg: String){
        let alert = UIAlertController(title: "Failed", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onClaim(_ sender: Any) {
            let claimQty = Int(self.claimCount.text!)!
            if (claimQty > announcement.unclaimed){
                self.displayError(msg: "Can not claim more than \(announcement.unclaimed) products")
            }
            else if (claimQty <= 0){
                self.displayError(msg: "Enter valid number")
            }
            else{
                announcement.claimed = announcement.claimed + claimQty
                announcement.unclaimed = announcement.product.quantity - announcement.claimed
                Announcements.announce.updateAnnouncement(announcement: announcement)
                let order:Order = Order(title:announcement.product.name , product: announcement.product, quantity: claimQty, status:Order.Status.Placed, userName: backendless?.userService.currentUser.getProperty("name") as! String, email: backendless?.userService.currentUser.getProperty("email") as! String )
                AllOrders.allOrders.saveOrder(order: order)
                self.displayAlert(msg: "You have claimed \(claimQty) products")
        }
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
