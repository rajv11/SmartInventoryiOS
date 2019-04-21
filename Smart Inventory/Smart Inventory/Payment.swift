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
    var quantity:Int
    var unitPrice:Double
    var totalPrice:Double
    var objectId:String?
    override var  description:  String  {
        //  NSObject  adheres  to  CustomStringConvertible
        return "Order ID:  \(orderId),  Quantity:  \(quantity), Unit Price: \(unitPrice), Total Price: \(totalPrice)"
        
    }
    
    init(orderId: String, quantity:Int, unitPrice:Double, totalPrice:Double) {
        self.orderId = orderId
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.totalPrice = totalPrice
    }
    
    convenience override init(){
        self.init(orderId:"", quantity:0, unitPrice:0.0, totalPrice:0.0)
        
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
        
        paymentDataStore.find(queryBuilder, response: {(results) -> Void in
            self.payments = results as! [Payment]
            print(self.payments.count)
        },
                              error:{(exception) -> Void in
                                print(exception.debugDescription)
        })
    }
}
