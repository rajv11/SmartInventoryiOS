//
//  Announcement.swift
//  Smart Inventory
//
//  Created by student on 2/14/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import Foundation

@objcMembers

class Announcemnet: NSObject {
    var title:String
    var required:Int
    var claimed:Int
    var unclaimed:Int
    var desc: String
    
    override var description: String {
        return "Title: \(title), Required amount: \(required), Claimed: \(claimed), Unclaimed: \(unclaimed)\n Description: \(desc)"
    }
    
    init(title:String, required:Int, claimed:Int, unclaimed:Int,desc:String) {
        self.title = title
        self.required = required
        self.claimed = claimed
        self.unclaimed = unclaimed
        self.desc = desc
    }
    
    convenience override init() {
        self.init(title: "title", required: 100, claimed: 25, unclaimed: 75, desc:"Need more iphones")
    }
}

@objcMembers
class Announcements {
    let backendless = Backendless.sharedInstance()
    var announcementDataStore:IDataStore!
    
    static var announce:Announcements = Announcements()
    
    var announcements:[Announcemnet] = []
    init() {
        announcementDataStore = backendless?.data.of(Announcemnet.self)
    }
    
    func saveAnouncements(title:String, required:Int, claimed:Int, unclaimed:Int,desc:String)
    {
        var itemToSave = Announcemnet(title:title, required:required, claimed:claimed, unclaimed:unclaimed, desc:desc)
        
        announcementDataStore.save(itemToSave,response:{(result) -> Void in
            itemToSave = result as! Announcemnet
            self.announcements.append(itemToSave)
            self.retrieveAllAnnouncements() },
                                   
                                   error:{(exception) -> Void in
                                    print(exception.debugDescription)
                                    
        })
    }
    
    func retrieveAllAnnouncements()
    {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setPageSize(100)
        
        announcementDataStore.find(queryBuilder, response: {(results) -> Void in
            self.announcements = results as! [Announcemnet]
        },
                                   error:{(exception) -> Void in
                                    print(exception.debugDescription)
        })
    }
    
}
