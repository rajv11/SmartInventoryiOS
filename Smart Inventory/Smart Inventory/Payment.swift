//
//  Payment.swift
//
//
//  Created by vamshi raj jennaikode on 4/19/19.
//

import Foundation
@objcMembers
class Payment: NSObject, Decodable {
    
    static var payment:Payment  = Payment()
    
    var orderId:String
    var payeeEmail:String
    var quantity:Int
    var unitPrice:Double
    var totalPrice:Double
    var objectId:String?
    override var  description:  String  {
        //  NSObject  adheres  to  CustomStringConvertible
        return "Order ID:  \(orderId),  Quantity:  \(quantity), Unit Price: \(unitPrice), Total Price: \(totalPrice)"
        
    }
    
    init(orderId: String, payeeEmail:String, quantity:Int, unitPrice:Double, totalPrice:Double) {
        self.orderId = orderId
        self.payeeEmail = payeeEmail
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.totalPrice = totalPrice
    }
    
    convenience override init(){
        self.init(orderId:"", payeeEmail:"", quantity:0, unitPrice:0.0, totalPrice:0.0)
        
    }
}

@objcMembers
class Payments {
    static var payments:Payments = Payments()
    let backendless = Backendless.sharedInstance()
    var paymentDataStore:IDataStore!
    
    static var payment:Payment = Payment()
    
    var payments:[Payment] = []
    init() {
        paymentDataStore = backendless?.data.of(Payment.self)
    }
    
    func savePayments(payment:Payment)
    {
        var itemToSave = payment
        
        paymentDataStore.save(itemToSave,response:{(result) -> Void in
            itemToSave = result as! Payment
            self.payments.append(itemToSave)
            self.retrieveAllPayments()
            
        },
                              
                              error:{(exception) -> Void in
                                print(exception.debugDescription)
                                
        })
}
    
func retrieveAllPayments() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setPageSize(100)
        
    self.payments = paymentDataStore.find(queryBuilder) as! [Payment]
    }
    
//    func retrieveUserPayments() {
//        let queryBuilder = DataQueryBuilder()
//        queryBuilder!.setWhereClause("email='\( backendless?.userService.currentUser.getProperty("email") ?? "")'")
//        queryBuilder!.setRelationsDepth(1)
//
//        self.orders = orderDataStore.find(queryBuilder) as! [Order]
//    }
}
