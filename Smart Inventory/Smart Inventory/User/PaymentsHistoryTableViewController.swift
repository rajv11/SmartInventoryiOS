//
//  PayementsHistoryTableViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 4/21/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class PaymentsHistoryTableViewController: UITableViewController {

    static var paymentsTVC:PaymentsHistoryTableViewController = PaymentsHistoryTableViewController()
    
    let backendless = Backendless.sharedInstance()!
    var paymentsDataStore:IDataStore!
    var allPayments:[Payment] = []
    let refreshControl1 = UIRefreshControl()
    @IBAction func onDone(segue:UIStoryboardSegue){}
    
    @objc func dataFetched() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        let user = self.backendless.userService.currentUser
        if(user?.email == "inventory.adm@yandex.ru"){
            Payments.payments.retrieveAllPayments()
        }
        else{
            Payments.payments.retrieveUserPayments()
        }
        allPayments = Payments.payments.payments
        refreshControl1.addTarget(self, action: #selector(refreshPayments), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl1)
        //        allOrders = self.orderDataStore.find(queryBuilder) as! [Order]
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func doneBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func refreshPayments() {
        let user = self.backendless.userService.currentUser
        if(user?.email == "inventory.adm@yandex.ru"){
            Payments.payments.retrieveAllPayments()
        }
        else{
            Payments.payments.retrieveUserPayments()
        }
        allPayments = Payments.payments.payments
        tableView.reloadData()
        refreshControl1.endRefreshing()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let user = self.backendless.userService.currentUser
        if(user?.email == "inventory.adm@yandex.ru"){
            Payments.payments.retrieveAllPayments()
        }
        else{
            Payments.payments.retrieveUserPayments()
        }
        allPayments = Payments.payments.payments
        tableView.reloadData()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allPayments.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath)
        
        let name = tableView.viewWithTag(100) as! UILabel
        let user = tableView.viewWithTag(200) as! UILabel
        let quantity = tableView.viewWithTag(300) as! UILabel
        let total = tableView.viewWithTag(400) as! UILabel
        let status = tableView.viewWithTag(500) as! UILabel
        
        let order = AllOrders.allOrders.getOrder(allPayments[indexPath.row].orderId)
        
        name.text = order.title
        user.text = order.userName
        quantity.text = String(allPayments[indexPath.row].quantity)
        total.text = String(allPayments[indexPath.row].totalPrice)
        status.text = String(allPayments[indexPath.row].status)
        
        return cell
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

}
