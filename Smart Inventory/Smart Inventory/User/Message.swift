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
    var name:String
    var email:String
    var toEmail:String
    //var ownerId:String?
    override var  description:  String  {
        //  NSObject  adheres  to  CustomStringConvertible
        return "subject:  \(subject),  message:  \(message), user: \(name), email: \(email), toEmail: \(toEmail)"
        
    }
    
    init(subject:String, message:String, name:String, email:String, toEmail:String){
        self.subject = subject
        self.message  =  message
        self.name = name
        self.email = email
        self.toEmail = toEmail
    }
    
    convenience override init(){
        self.init(subject:"",message: "",name:"", email: "", toEmail: "")
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
    
    func retriveAllMessages() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setPageSize(100)
        
        queryBuilder?.setSortBy(["created DESC"])
        messageDataStore = backendless?.data.of(Message.self)
        self.messagesArray = messageDataStore.find(queryBuilder) as! [Message]
    }
    func retriveAdminMessages() {
        let whereClause = "email='inventory.adm@yandex.ru'"
        
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setWhereClause(whereClause)
        
        queryBuilder?.setSortBy(["created DESC"])
        self.messagesArray = messageDataStore.find(queryBuilder) as! [Message]
    }
    func retrievByAdminMessages() {
        let whereClause = "toEmail='\( backendless?.userService.currentUser.getProperty("email") ?? "")'"
        
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setWhereClause(whereClause)
        
        queryBuilder?.setSortBy(["created DESC"])
        self.messagesArray = messageDataStore.find(queryBuilder) as! [Message]
    }
    func retriveOnlyAllUserMessages() {
        let whereClause = "email!='inventory.adm@yandex.ru'"
        
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setWhereClause(whereClause)
        
        queryBuilder?.setSortBy(["created DESC"])
        self.messagesArray = messageDataStore.find(queryBuilder) as! [Message]

    }
    func retriveUserMessages() {
        let whereClause = "email='\( backendless?.userService.currentUser.getProperty("email") ?? "")'"
        
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setWhereClause(whereClause)
        
        queryBuilder?.setSortBy(["created DESC"])
        self.messagesArray = messageDataStore.find(queryBuilder) as! [Message]
    }
}
