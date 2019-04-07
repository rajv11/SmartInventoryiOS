//
//  UserOrdersTableViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 3/6/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class UserOrdersTableViewController: UITableViewController {

    static var ordersTVC:UserOrdersTableViewController = UserOrdersTableViewController()
    
    let backendless = Backendless.sharedInstance()!
    var orderDataStore:IDataStore!
    var allOrders:[Order] = []
    
    @IBAction func onDone(segue:UIStoryboardSegue){}
    
    @objc func dataFetched() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderDataStore =  backendless.data.of(Order.self)
        let queryBuilder = DataQueryBuilder ()
        queryBuilder!.setRelationsDepth(1)
        allOrders = self.orderDataStore.find(queryBuilder) as! [Order]

        
        // Do any additional setup after loading the view.
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
        return allOrders.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        
        let name = tableView.viewWithTag(100) as! UILabel
        //let createdDate = tableView.viewWithTag(200) as! UILabel!
        let status = tableView.viewWithTag(300) as! UILabel
        
        name.text = allOrders[indexPath.row].title
        //createdDate?.text = "Order requested on:"+String(allOrders[indexPath.row].created!)
        status.text = allOrders[indexPath.row].status
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            AllOrders.allOrders.deleteOrder(allOrders[indexPath.row].objectId!)
            AllProducts.allProducts.deleteProduct(allOrders[indexPath.row].objectId!)
            self.allOrders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
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
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "order_details" {
            let orderDetailsVC = segue.destination as! OrderDetialsViewController
            print(tableView.indexPathForSelectedRow!.row)
            OrderDetialsViewController.order = self.allOrders[tableView.indexPathForSelectedRow!.row]
        } else {
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
