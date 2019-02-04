//
//  Product.swift
//  Smart Inventory
//
//  Created by Bharadwaj Dasari on 11/18/18.
//  Copyright © 2018 Jennaikode,Vamshi Raj. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
class Product: NSObject, Decodable {
    
    static var product:Product = Product()

    var name:String
    var productDescription:String
    var imageURL:String
    var quantity:Int
    var price:Double
    
    override var  description:  String  {
        //  NSObject  adheres  to  CustomStringConvertible
        return "Name:  \(name  ??  ""),  Description:  \(productDescription)"
        
    }
    
    init(name:String, productDescription:String, imageURL:String, quantity:Int, price:Double){
        self.name  =  name
        self.productDescription = productDescription
        self.imageURL = imageURL
        self.quantity = quantity
        self.price = price
    }
    
    convenience override init(){
        self.init(name:"", productDescription:"", imageURL:"", quantity:0, price:0.0)
        
    }
}

struct AllProducts {
    // represents the product functions
    static var allProducts:AllProducts = AllProducts()
    var productsList:[Product] = []
    
    //sets the product list
    mutating func setProductsList(productsList:[Product]) {
        self.productsList = productsList
    }
    //gets all the product list
    func getAllProductsList() -> [Product] {
        return productsList
    }
    
}
