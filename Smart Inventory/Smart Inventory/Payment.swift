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
    var accountNumber:String
    var routingNumber:String
    var status:String
    var objectId:String?
    override var  description:  String  {
        //  NSObject  adheres  to  CustomStringConvertible
        return "Order ID:  \(orderId),  Quantity:  \(quantity), Unit Price: \(unitPrice), Total Price: \(totalPrice)"
        
    }
    
    init(orderId: String, payeeEmail:String, quantity:Int, unitPrice:Double, totalPrice:Double, accountNumber:String,routingNumber:String , status:String) {
        self.orderId = orderId
        self.payeeEmail = payeeEmail
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.totalPrice = totalPrice
        self.accountNumber = accountNumber
        self.routingNumber = routingNumber
        self.status = status
    }
    
    convenience override init(){
        self.init(orderId:"", payeeEmail:"", quantity:0, unitPrice:0.0, totalPrice:0.0, accountNumber:"", routingNumber:"", status:"")
        
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
    
    func retrieveUserPayments() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setWhereClause("payeeEmail='\( backendless?.userService.currentUser.getProperty("email") ?? "")'")
        queryBuilder!.setRelationsDepth(1)

        self.payments = paymentDataStore.find(queryBuilder) as! [Payment]
        print(self.payments.count)
    }
    
    func getPayment(_ orderId:String) -> Payment{
        var payment:[Payment] = []
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setWhereClause("orderId='\( orderId )'")
        queryBuilder!.setRelationsDepth(1)
        payment = paymentDataStore.find(queryBuilder) as! [Payment]
        return payment[0]
    }
    
}
