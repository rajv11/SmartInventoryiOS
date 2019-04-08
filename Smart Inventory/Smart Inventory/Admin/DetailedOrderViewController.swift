//
//  DetailedOrderViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 4/8/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class DetailedOrderViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UITextView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var claimedLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var uploadShippingLabelBtn: UIButton!
    
    static var order:Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLbl.text = String(DetailedOrderViewController.order.product.name)
        descLbl.text = String(DetailedOrderViewController.order.product.productDescription)
        claimedLbl.text = String(DetailedOrderViewController.order.quantity)
        priceLbl.text = String(DetailedOrderViewController.order.product.price)
        statusLbl.text = String(DetailedOrderViewController.order.status)
    }
    
    func displayAlert(msg: String){
        let  alert  =  UIAlertController(title:  "Order",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  { _ in
            self.performSegue(withIdentifier: "modifiedOrder", sender: nil)
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

}
