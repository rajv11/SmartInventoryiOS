//
//  Announcement.swift
//  Smart Inventory
//
//  Created by Vamshi Raj on 2/14/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import Foundation

@objcMembers

class Announcemnet: NSObject {
    //var title:String
    var product:Product
    //var required:Int
    var claimed:Int
    var unclaimed:Int
    //var desc: String
    var objectId:String?
    
    override var description: String {
        return "Product: \(product), Claimed: \(claimed), Unclaimed: \(unclaimed)"
    }
    
    init(product:Product,claimed:Int, unclaimed:Int) {
        //self.title = title
        self.product = product
        //self.required = required
        self.claimed = claimed
        self.unclaimed = unclaimed
        //self.desc = desc
    }
    
   convenience override init() {
        self.init(product: Product(name: "new", productDescription: "test", quantity: 2, price: 23),claimed: 25, unclaimed: 75)
    }
}

@objcMembers
class Announcements {
    
    var objectId:String?
    let backendless = Backendless.sharedInstance()
    var announcementDataStore:IDataStore!
    var productDataStore:IDataStore!
    
    static var announce:Announcements = Announcements()
    
    var announcements:[Announcemnet] = []
    init() {
        announcementDataStore = backendless?.data.of(Announcemnet.self)
    }
    
    func saveAnouncements(product:Product, claimed:Int, unclaimed:Int)
    {
        AllProducts.allProducts.saveProducts(product: product)
        var itemToSave = Announcemnet(product:product, claimed:claimed, unclaimed:unclaimed)
        
        announcementDataStore.save(itemToSave,response:{(result) -> Void in
            itemToSave = result as! Announcemnet
            self.announcements.append(itemToSave)
            self.retrieveAllAnnouncements()
            AllProducts.allProducts.retrieveAllProducts()
            
            let dataStore = Backendless.sharedInstance().data.of(Product().ofClass())
            let prod = dataStore?.findLast() as! Product
            self.setRelationship(parentID: itemToSave.objectId!, childID: prod.objectId!)

        },
                                   
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
    
    
    func setRelationship(parentID:String, childID:String) {
        let dataStore = Backendless.sharedInstance().data.of(Announcemnet().ofClass())
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
