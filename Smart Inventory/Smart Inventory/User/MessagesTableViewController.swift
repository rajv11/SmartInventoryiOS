//
//  ChatTableViewController.swift
//  Smart Inventory
//
//  Created by Vamshi Raj on 11/30/18.
//  Copyright © 2018 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {
    var messages:[Message] = []
    let backendless = Backendless.sharedInstance()!
    var messageDataStore:IDataStore!
    var arr:[[Message]] = []
    let headerTitles = ["Sent", "Inbox"]
    let refreshControl1 = UIRefreshControl()
    
    @IBAction func onCancelNewMessages(segue:UIStoryboardSegue){}
    
    @objc func dataFetched() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Messages.messages.retriveUserMessages()
        messages = Messages.messages.messagesArray
        arr.append(messages)
        Messages.messages.retrievByAdminMessages()
        arr.append(Messages.messages.messagesArray)
        
        refreshControl1.addTarget(self, action: #selector(refreshMesaages), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl1)
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appbg.jpg")!)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @objc func refreshMesaages() {
        arr.removeAll()
        Messages.messages.retriveUserMessages()
        messages = Messages.messages.messagesArray
        arr.append(messages)
        Messages.messages.retrievByAdminMessages()
        arr.append(Messages.messages.messagesArray)
        tableView.reloadData()
        refreshControl1.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        arr.removeAll()
        Messages.messages.retriveUserMessages()
        messages = Messages.messages.messagesArray
        arr.append(messages)
        Messages.messages.retrievByAdminMessages()
        arr.append(Messages.messages.messagesArray)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr[section].count
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return messages.count
//    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)
        let currentMessage = arr[indexPath.section][indexPath.row]
        cell.textLabel?.text = currentMessage.subject
        cell.detailTextLabel?.text = currentMessage.message

        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        
        return nil
    }
    @IBAction func chatDone(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageDetail" {
            let messageVC = segue.destination as! MessageDetailViewController
            messageVC.message = self.arr[tableView.indexPathForSelectedRow!.section][tableView.indexPathForSelectedRow!.row]
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
