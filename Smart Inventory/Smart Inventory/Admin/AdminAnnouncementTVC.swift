//
//  AdminAnnouncementTVC.swift
//  Smart Inventory
//
//  Created by Vamshi Raj on 2/14/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class AdminAnnouncementTVC: UITableViewController {

    //let refreshControl1 = UIRefreshControl()
    //var announcmentData:Announcements!
    
    @IBAction func onCancelAnnouncement(segue:UIStoryboardSegue){}
    @IBAction func onPostAnnouncement(segue:UIStoryboardSegue){}
    var allAnnouncements:[Announcemnet] = []
    
    let backendless = Backendless.sharedInstance()!
    var announcementDataStore:IDataStore!
    let refreshControl1 = UIRefreshControl()
    
    
    @objc func dataFetched() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        announcementDataStore =  backendless.data.of(Announcemnet.self)
        allAnnouncements = self.announcementDataStore.find() as! [Announcemnet]
        
        
        refreshControl1.addTarget(self, action: #selector(refreshAnnounce), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl1)

        //tableView.backgroundColor = UIColor(patternImage: UIImage(named: "appbg.jpg")!)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @objc func refreshAnnounce() {
        allAnnouncements = self.announcementDataStore.find() as! [Announcemnet]
        tableView.reloadData()
        
        refreshControl1.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allAnnouncements.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "admin_announce", for: indexPath)
        
        let title = tableView.viewWithTag(101) as! UILabel
        let desc = tableView.viewWithTag(201) as! UITextView
        let required = tableView.viewWithTag(401) as! UILabel
        let price = tableView.viewWithTag(501) as! UILabel
        let claimed = tableView.viewWithTag(601) as! UILabel
        
        let currentAnnouncement = allAnnouncements[indexPath.row]
        title.text = currentAnnouncement.product.name
        desc.text = currentAnnouncement.product.productDescription
        required.text = "Required:"+String(currentAnnouncement.unclaimed)
        price.text = "$"+String(currentAnnouncement.product.price)
        claimed.text = "Claimed:"+String(currentAnnouncement.claimed)
        
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            Announcements.announce.deleteAnnouncement(objectID: allAnnouncements[indexPath.row].objectId!)
            AllProducts.allProducts.deleteProduct(allAnnouncements[indexPath.row].product.objectId!)
            self.allAnnouncements.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "update" {
            let updateVC = segue.destination as! UpdateViewController
            updateVC.announcement = self.allAnnouncements[tableView.indexPathForSelectedRow!.row]
        }
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        announcmentData = Announcements.announce
//
////        refreshControl1.addTarget(self, action: #selector(refreshAnnounce), for: UIControl.Event.valueChanged)
////
////        tableView.addSubview(refreshControl1)
////
////        tableView.reloadData()
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }
//    @objc func dataFetched() {
//        tableView.reloadData()
//    }
////    @objc func refreshAnnounce() {
////        announcmentData.retrieveAllAnnouncements()
////        announcmentData.announcements = announcmentData.announcements.reversed()
////        tableView.reloadData()
////        refreshControl1.endRefreshing()
////    }
//    override func viewWillAppear(_ animated: Bool) {
////        announcmentData.retrieveAllAnnouncements()
////        announcmentData.announcements = announcmentData.announcements.reversed()
//        tableView.reloadData()
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return announcmentData.announcements.count
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "admin_announce", for: indexPath)
//
//
//        let title = tableView.viewWithTag(101) as! UILabel
//        let desc = tableView.viewWithTag(201) as! UITextView
//        let required = tableView.viewWithTag(401) as! UILabel
//        let price = tableView.viewWithTag(501) as! UILabel
//        let claimed = tableView.viewWithTag(601) as! UILabel
//        //let data = announcmentData.announcements[indexPath.row]
//        //print(data.objectId!)
//        let currentAnnouncement = announcmentData.announcements[indexPath.row]
//        title.text = currentAnnouncement.product.name
//        desc.text = currentAnnouncement.product.productDescription
//        required.text = "Required:"+String(currentAnnouncement.unclaimed)
//        price.text = "$"+String(currentAnnouncement.product.price)
//        claimed.text = "Claimed:"+String(currentAnnouncement.claimed)
//        //cell.textLabel?.text = data.product.name
//
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 155
//    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
