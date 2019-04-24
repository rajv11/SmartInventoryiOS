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
    var quantity:Int
    var price:Double
    var objectId:String?
    var parentId:String
    override var  description:  String  {
        //  NSObject  adheres  to  CustomStringConvertible
        return "Name:  \(name  ),  Description:  \(productDescription)"
        
    }
    
    init(name:String, productDescription:String, quantity:Int, price:Double, parentId:String){
        self.name  =  name
        self.productDescription = productDescription
        self.quantity = quantity
        self.price = price
        self.parentId = parentId
    }
    
    convenience override init(){
        self.init(name:"", productDescription:"", quantity:0, price:0.0, parentId: "")
        
    }
}

@objcMembers
class AllProducts {
    static var allProducts:AllProducts = AllProducts()    
    let backendless = Backendless.sharedInstance()
    var productDataStore:IDataStore!
    
    static var product:Product = Product()
    
    var products:[Product] = []
    init() {
        productDataStore = backendless?.data.of(Product.self)
    }
    
    func saveProducts(product:Product)
    {
        var itemToSave = product
        
        productDataStore.save(itemToSave,response:{(result) -> Void in
            itemToSave = result as! Product
            self.products.append(itemToSave)
            self.retrieveAllProducts()},
                                   
                                   error:{(exception) -> Void in
                                    print(exception.debugDescription)
                                    
        })
    }
    
    func retrieveAllProducts()
    {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setPageSize(100)
        
        queryBuilder?.setSortBy(["created DESC"])
        productDataStore.find(queryBuilder, response: {(results) -> Void in
            self.products = results as! [Product]
            print(self.products.count)
        },
                                   error:{(exception) -> Void in
                                    print(exception.debugDescription)
        })
    }
    func deleteProduct(_ objectId:String) {
        productDataStore = backendless?.data.of(Product.self)
        
        productDataStore.remove(byId: objectId, response: {(result) -> Void in
            print("deleted")
        },
                                error: {(exception) -> Void in
                                    print(exception.debugDescription) })
        self.retrieveAllProducts()
        
    }
}
