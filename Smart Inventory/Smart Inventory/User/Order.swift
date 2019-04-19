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
    
    var title:String
    var product:Product
    var quantity:Int
    var status:String
    var objectId:String?
    var created:String?
    var userName:String
    var email:String
    
    enum Status:String, Decodable {
        case Placed = "Placed"
        case Approved = "Approved"
        case Rejected = "Rejected"
        case ShippingLbl_Requested = "Requested Label"
        case ShippingLbl_Sent = "Sent Label"
        case Shipped_Order = "Shipped"
        case Received_Order = "Order Received"
        case Order_not_received = "Order not received"
        case Receipt_Sent = "Receipt Sent"
        case Payment_Sent = "Paid"
        case Close_Order = "Closed"
        case other = ""
        
    }
    
    override var  description:  String  {
        //  NSObject  adheres  to  CustomStringConvertible
        return "Name:  \(product.name)"
        
    }
    
    init(title:String, product:Product, quantity:Int, status:Status, userName:String, email:String){
        self.title = title
        self.product  =  product
        self.quantity = quantity
        self.status = status.rawValue
        self.userName = userName
        self.email = email
    }
    
    convenience override init(){
        self.init(title:"", product: Product(), quantity: 0, status: Status.other, userName: "", email: "")
        
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
        queryBuilder!.setRelationsDepth(1)
        self.orders = orderDataStore.find(queryBuilder) as! [Order]
    }
    func retrieveUserOrders() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setWhereClause("email='\( backendless?.userService.currentUser.getProperty("email") ?? "")'")
        queryBuilder!.setRelationsDepth(1)
        
        self.orders = orderDataStore.find(queryBuilder) as! [Order]
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
    
    func deleteOrder(_ objectId:String) {
        let orderDataStore = backendless?.data.of(Order.self)
        
        orderDataStore!.remove(byId: objectId, response: {(result) -> Void in
            print("Order deleted")
        },
                                error: {(exception) -> Void in
                                    print(exception.debugDescription) })
        self.retrieveAllOrders()
    }
        
    
}
