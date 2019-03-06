//
//  Order.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 3/6/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
class Order: NSObject, Decodable {
    
    static var order:Order = Order()
    
    var product:Product
    var quantity:Int
    var status:String
    var objectId:String?
    var created:String?
    override var  description:  String  {
        //  NSObject  adheres  to  CustomStringConvertible
        return "Name:  \(product.name  ??  ""),  status:  \(status)"
        
    }
    
    init(product:Product, quantity:Int, status:String){
        self.product  =  product
        self.quantity = quantity
        self.status = status
    }
    
    convenience override init(){
        self.init(product: Product(), quantity: 0, status: "")
        
    }
}

@objcMembers
class AllOrders {
    static var allOrders:AllOrders = AllOrders()
    
    let backendless = Backendless.sharedInstance()
    var orderDataStore:IDataStore!
    
    static var order:Order = Order()
    
    var orders:[Order] = []
    init() {
        orderDataStore = backendless?.data.of(Order.self)
    }
    
    func saveOrder(order:Order)
    {
        var itemToSave = order
        
        orderDataStore.save(itemToSave,response:{(result) -> Void in
            itemToSave = result as! Order
            self.orders.append(itemToSave)
            self.retrieveAllOrders()
            self.setRelationship(parentID: itemToSave.objectId!, childID: order.product.objectId!)
        },
                            
                            error:{(exception) -> Void in
                                print(exception.debugDescription)
                                
        })
    }
    
    func retrieveAllOrders()
    {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setPageSize(100)
        
        orderDataStore.find(queryBuilder, response: {(results) -> Void in
            self.orders = results as! [Order]
            print(self.orders.count)
        },
                            error:{(exception) -> Void in
                                print(exception.debugDescription)
        })
    }
    
    func setRelationship(parentID:String, childID:String) {
        let dataStore = Backendless.sharedInstance().data.of(Order().ofClass())
        dataStore?.setRelation("product",
                               parentObjectId: parentID,
                               childObjects: [childID],
                               response: {
                                (result : NSNumber?) -> () in
                                print ("Relation has been saved: \(String(describing: result))")
        },
                               error: {
                                (fault : Fault?) -> () in
                                print("Server reported an error: \(String(describing: fault))")
        })
    }
    
}
