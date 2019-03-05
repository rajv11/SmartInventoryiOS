//
//  UpdateViewController.swift
//  Smart Inventory
//
//  Created by vamshi raj on 3/5/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    var announcement:Announcemnet!
    @IBOutlet weak var productNameTF: UITextField!
    @IBOutlet weak var quantityTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        productNameTF.text = announcement.product.name
        quantityTF.text = "\(announcement.product.quantity)"
        priceTF.text = "\(announcement.product.price)"
        descriptionTF.text = announcement.product.productDescription
    }
    
    func displayError(msg: String) {
        let alert = UIAlertController(title: "Failed", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func displayAlert(msg: String){
        let  alert  =  UIAlertController(title:  "Announcement",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  { _ in
            
            self.performSegue(withIdentifier: "done", sender: nil)
        }))
        self.present(alert,  animated:  true,  completion:  nil)    }
    
    @IBAction func updateBtn(_ sender: Any) {
        
        
        
        if let productName = productNameTF.text, let quantity = Int(quantityTF.text!), let price = Double(priceTF.text!)
        {
            if descriptionTF.text.isEmpty {
                descriptionTF.text = "N/A"
            }
//            let product = Product(name: productName, productDescription: descriptionTF.text!, quantity: quantity, price: Double(priceTF.text!)!)
//            let updateAnnoucement = Announcemnet(product: product, claimed: announcement.claimed, unclaimed: product.quantity - announcement.claimed)
            announcement.product.name = productName
            announcement.product.productDescription = descriptionTF.text
            announcement.product.quantity = quantity
            announcement.product.price = price
            announcement.unclaimed = quantity - announcement.claimed
            Announcements.announce.updateAnnouncement(announcement: announcement)
            
            self.displayAlert(msg: "Updated!!")
        } else {
            self.displayError(msg: "Enter All required fields")
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
