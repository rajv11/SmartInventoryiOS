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
    @IBOutlet weak var requestSLabelBtn: UIButton!
    @IBOutlet weak var downloadSLabelBtn: UIButton!
    
    static var order:Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateOrderBtn.isHidden =  true
        claimedTF.isEnabled = false
        claimedTF.backgroundColor = UIColor.clear
        requestSLabelBtn.isHidden = true
        downloadSLabelBtn.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (OrderDetialsViewController.order.status == Order.Status.Placed.rawValue ){
            updateOrderBtn.isHidden = true
            claimedTF.isEnabled = true
            claimedTF.backgroundColor = UIColor.white
            }
        if (OrderDetialsViewController.order.status == Order.Status.Approved.rawValue ){
            requestSLabelBtn.isHidden = false
        }
        if (OrderDetialsViewController.order.status == Order.Status.ShippingLbl_Sent.rawValue){
            downloadSLabelBtn.isHidden = false
        }
        nameLbl.text = String(OrderDetialsViewController.order.product.name)
        descLbl.text = String(OrderDetialsViewController.order.product.productDescription)
        claimedTF.text = String(OrderDetialsViewController.order.quantity)
        priceLbl.text = String(OrderDetialsViewController.order.product.price)
        statusLbl.text = OrderDetialsViewController.order.status
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
    
    @IBAction func requestSLabel(_ sender: Any) {
        let order = OrderDetialsViewController.order
        order?.status = Order.Status.ShippingLbl_Requested.rawValue
        AllOrders.allOrders.saveOrder(order: order!)
        displayAlert(msg: "Requested shipping label successfully")
    }
    
    @IBAction func downloadSLabel(_ sender: Any) {
        displayAlert(msg: "Downloaded shipping label successfully")
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
