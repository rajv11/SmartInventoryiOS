//
//  Message.swift
//  Smart Inventory
//
//  Created by vamshi raj on 4/5/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import Foundation

@objcMembers
class Message: NSObject {
    
    static var message:Order = Order()
    
    var subject:String
    var message:String
    
    var objectId:String?
    override var  description:  String  {
        //  NSObject  adheres  to  CustomStringConvertible
        return "subject:  \(subject),  message:  \(message)"
        
    }
    
    init(subject:String, message:String){
        self.subject = subject
        self.message  =  message
    }
    
    convenience override init(){
        self.init(subject:"",message: "")
    }
}

@objcMembers
class Messages {
    static var messages:Messages = Messages()
    
    let backendless = Backendless.sharedInstance()
    var messageDataStore:IDataStore!
    var messagesArray:[Message] = []
    init() {
        messageDataStore = backendless?.data.of(Message.self)
    }
    
    func saveMessage(message:Message) {
        var itemToSave = message
        messageDataStore.save(itemToSave, response: {(result) -> Void in
            itemToSave = result as! Message
            self.messagesArray.append(message)
            //self.retrieveAllOrders()
        },
                              error:{(exception) -> Void in
                                print(exception.debugDescription)
                                
        })
    }
    
    
//    func retriveAllMessages() {
//        <#function body#>
//    }
}
