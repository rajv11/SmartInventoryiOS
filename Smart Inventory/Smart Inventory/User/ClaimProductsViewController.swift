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
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var claimCount: UITextField!
    var product:Product!
    var productIndex:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        titleLbl.text = String(product.name)
        descLbl.text = String(product.productDescription)
        quantityLbl.text = String(product.quantity)
        priceLbl.text = String(product.price)
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
            //AllProducts.allProducts[productIndex].quantity = AllProducts.allProducts[productIndex].quantity - Int(claimCount.text!)! ?? 0
        } else {
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
