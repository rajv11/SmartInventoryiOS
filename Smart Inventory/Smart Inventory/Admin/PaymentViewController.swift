//
//  PaymentViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 4/21/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

   
    @IBOutlet weak var payeeLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var claimedLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let order = DetailedOrderViewController.order!
        payeeLbl.text = String(order.userName)
        productNameLbl.text = String(order.title)
        priceLbl.text = String(order.product.price)
        claimedLbl.text = String(order.quantity)
        totalAmountLbl.text = String(order.product.price * Double(order.quantity))
    }
    func displayAlert(msg: String){
        let  alert  =  UIAlertController(title:  "Payment",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,  animated:  true,  completion:  nil)    }
    func displayError(msg: String){
        let alert = UIAlertController(title: "Failed", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func pay(_ sender: Any) {
        let order = DetailedOrderViewController.order!
        let payment = Payment(orderId: order.objectId!, payeeEmail:order.email, quantity: order.quantity, unitPrice: order.product.price, totalPrice: order.product.price * Double(order.quantity))
        Payments.payments.savePayments(payment: payment)
        order.status = Order.Status.Payment_Sent.rawValue
        AllOrders.allOrders.saveOrder(order: order)
        self.displayAlert(msg: "Payment Successful")
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
