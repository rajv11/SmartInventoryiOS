//
//  userData.swift
//  Smart Inventory
//
//  Created by student on 10/15/18.
//  Copyright © 2018 Jennaikode,Vamshi Raj. All rights reserved.
//

import Foundation
struct Address {
    var firstLine:String
    var city:String
    var state:String
    var zip:Int
}
struct User {
    var user_id:String
    var name:String
    var email:String
    var password:String
    var mobile:Int
    var dob:String
    var address:Address
}
struct UsersRepo {
    static var users = UsersRepo()
    private var users:[User]
    let address:Address = Address(firstLine: "1115 N College Drive",city: "Maryville", state: "MO", zip: 64468)
    init() {
        users = [User(user_id: "batman",name: "bruce",email:"bat@cave.com", password: "batMobile", mobile: 6605280403,dob: "12/08/1988",address:address), User(user_id: "superman",name: "kent",email:"super@krypton.com", password: "superBoy", mobile: 6605280403,dob: "11/05/1947",address:address)]
    }
    mutating func addUser(_ user:User) {
        users.append(user)
    }
    func numberOfUsers() -> Int {
        return users.count
    }
    func user(_ index:Int) -> User {
        return users[index]
    }
    func isValid(userId:String, password:String) -> Bool {
        var valid = false
        for user in users {
            if userId == user.user_id {
                if password == user.password {
                    valid = true
                }
            }
        }
        return valid
    }
}
