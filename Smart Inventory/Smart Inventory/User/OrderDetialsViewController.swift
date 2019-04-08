//
//  OrderDetialsViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 3/17/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class OrderDetialsViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UITextView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var claimedTF: UITextField!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var updateOrderBtn: UIButton!
   
    static var order:Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateOrderBtn.isHidden =  true
        claimedTF.isEnabled = false
        claimedTF.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (String(OrderDetialsViewController.order.status) == "requested"){
            updateOrderBtn.isHidden = false
            claimedTF.isEnabled = true
            claimedTF.backgroundColor = UIColor.white
            }
        nameLbl.text = String(OrderDetialsViewController.order.product.name)
        descLbl.text = String(OrderDetialsViewController.order.product.productDescription)
        claimedTF.text = String(OrderDetialsViewController.order.quantity)
        priceLbl.text = String(OrderDetialsViewController.order.product.price)
        statusLbl.text = String(OrderDetialsViewController.order.status)
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


    @IBAction func updateOrder(_ sender: Any) {
        let modifiedOrder = OrderDetialsViewController.order
        modifiedOrder?.quantity = Int(self.claimedTF.text!)!
        AllOrders.allOrders.saveOrder(order: modifiedOrder!)
        displayAlert(msg: "Order has been modified successfully")
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
