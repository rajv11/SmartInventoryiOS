//
//  AdminMessagesTVC.swift
//  Smart Inventory
//
//  Created by vamshi raj on 4/7/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class AdminMessagesTVC: UITableViewController {
    var messages:[Message] = []
    let backendless = Backendless.sharedInstance()!
    var messageDataStore:IDataStore!
    var arr:[[Message]] = []
    let headerTitles = ["Users", "Me"]
    @objc func dataFetched() {
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        messageDataStore = backendless.data.of(Message.self)
        Messages.messages.retriveOnlyAllUserMessages()
        arr.append(Messages.messages.messagesArray)
        Messages.messages.retriveAdminMessages()
        arr.append(Messages.messages.messagesArray)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        arr.removeAll()
        Messages.messages.retriveOnlyAllUserMessages()
        arr.append(Messages.messages.messagesArray)
        Messages.messages.retriveAdminMessages()
        arr.append(Messages.messages.messagesArray)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arr.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adminMessage", for: indexPath)
        
        let newMessage = arr[indexPath.section][indexPath.row]
        if indexPath.section == 0 {
            cell.textLabel?.text = newMessage.name
            cell.detailTextLabel?.text = newMessage.subject
        } else {
            cell.textLabel?.text = newMessage.subject
            cell.detailTextLabel?.text = newMessage.message
        }
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        
        return nil
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        if segue.identifier == "adminDetail" {
            let messageVC = segue.destination as! AdminMessageDetailVC
            messageVC.message = self.arr[tableView.indexPathForSelectedRow!.section][tableView.indexPathForSelectedRow!.row]
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
