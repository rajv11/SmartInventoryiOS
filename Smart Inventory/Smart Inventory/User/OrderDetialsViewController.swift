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
    @IBOutlet weak var claimedLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    var order:Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        nameLbl.text = String(order.product.name)
        descLbl.text = String(order.product.productDescription)
        claimedLbl.text = String(order.quantity)
        priceLbl.text = String(order.product.price)
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
