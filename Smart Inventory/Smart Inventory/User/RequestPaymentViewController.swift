//
//  RequestPaymentViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 4/22/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class RequestPaymentViewController: UIViewController {

    @IBOutlet weak var accountNumberTF: UITextField!
    @IBOutlet weak var routingNumberTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func displayAlert(msg: String){
        let  alert  =  UIAlertController(title:  "Order",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  { _ in
            self.performSegue(withIdentifier: "paymentRequested", sender: nil)
        }))
        self.present(alert,  animated:  true,  completion:  nil)    }
    
    
    func displayError(msg: String){
        let alert = UIAlertController(title: "Failed", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onRequest(_ sender: Any) {
        let order = OrderDetialsViewController.order!
        var accountNumber = self.accountNumberTF.text!
        var routingNumber = self.routingNumberTF.text!
        let payment = Payment(orderId: order.objectId!, payeeEmail:order.email, quantity: order.quantity, unitPrice: order.product.price, totalPrice: order.product.price * Double(order.quantity),accountNumber:accountNumber, routingNumber:routingNumber, status:"Requested")
        Payments.payments.savePayments(payment: payment)
        order.status = Order.Status.Payment_Requested.rawValue
        AllOrders.allOrders.saveOrder(order: order)
        displayAlert(msg: "Payment Requested")
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
