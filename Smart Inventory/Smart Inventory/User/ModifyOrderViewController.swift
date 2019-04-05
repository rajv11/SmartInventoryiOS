//
//  ModifyOrderViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 3/24/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class ModifyOrderViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UITextView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantityLbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        nameLbl.text = String(OrderDetialsViewController.order.product.name)
        descLbl.text = String(OrderDetialsViewController.order.product.productDescription)
        quantityLbl.text = String(OrderDetialsViewController.order.quantity)
        price.text = String(OrderDetialsViewController.order.product.price)
    }

  
    @IBAction func modifyOrder(_ sender: Any) {
    }
    
    @IBAction func cancelOrder(_ sender: Any) {
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
