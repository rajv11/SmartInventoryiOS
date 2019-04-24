//
//  DashboardTableViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 11/18/18.
//  Copyright © 2018 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class DashboardTableViewController: UITableViewController {
    
    @IBAction func onCancel(segue:UIStoryboardSegue){}
    
    static var dashboardTVC:DashboardTableViewController = DashboardTableViewController()
    var product:Product!
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardCell", for: indexPath)

        let title = tableView.viewWithTag(100) as! UILabel
        let desc = tableView.viewWithTag(200) as! UITextView
        let required = tableView.viewWithTag(400) as! UILabel
        let price = tableView.viewWithTag(500) as! UILabel
        let claimed = tableView.viewWithTag(600) as! UILabel
        
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
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let chatAction = UITableViewRowAction(style: .normal, title:"       ") { (rowAction, indexPath) in
            print("delete clicked")
            let currentAnnouncement = self.allAnnouncements[indexPath.row]
            //NewMessageViewController.newMVC.subject = currentAnnouncement.product.name
            //self.performSegue(withIdentifier: "newMssage", sender: self)
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "newMessageVC") as! NewMessageViewController
            vc.subject = currentAnnouncement.product.name
            self.present(vc,animated: true, completion: nil)
            
        }
        chatAction.backgroundColor = UIColor(patternImage:UIImage(named: "chatPic")!)
        return [chatAction]
    }

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "claim_product" {
            let claimProductVC = segue.destination as! ClaimProductsViewController
            claimProductVC.announcement = self.allAnnouncements[tableView.indexPathForSelectedRow!.row]
        }        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
