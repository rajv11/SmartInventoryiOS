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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "claim" {
            var claimQty = Int(self.claimCount.text!)
            announcement.claimed = claimQty!
            announcement.unclaimed = announcement.unclaimed - claimQty!
            Announcements.announce.updateAnnouncement(announcement: announcement)
            //AllProducts.allProducts[productIndex].quantity = AllProducts.allProducts[productIndex].quantity - Int(claimCount.text!)! ?? 0
        } else {
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
