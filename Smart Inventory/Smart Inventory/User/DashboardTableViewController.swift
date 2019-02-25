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
    @IBAction func onClaim(segue:UIStoryboardSegue){}
    
    static var dashboardTVC:DashboardTableViewController = DashboardTableViewController()
    var product:Product!
    var allProducts:[Product] = []
    
    let backendless = Backendless.sharedInstance()!
    var productDataStore:IDataStore!
    
    
    @objc func dataFetched() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productDataStore =  backendless.data.of(Product.self)
        allProducts = self.productDataStore.find() as! [Product]
        
        //tableView.backgroundColor = UIColor(patternImage: UIImage(named: "appbg.jpg")!)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return allProducts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardCell", for: indexPath)

        let title = tableView.viewWithTag(100) as! UILabel!
        let desc = tableView.viewWithTag(200) as! UITextView!
        let quantity = tableView.viewWithTag(400) as! UILabel!
        let price = tableView.viewWithTag(500) as! UILabel!

        title?.text = allProducts[indexPath.row].name
        desc?.text = allProducts[indexPath.row].productDescription
        quantity?.text = "Quantity:"+String(allProducts[indexPath.row].quantity)
        price?.text = "$"+String(allProducts[indexPath.row].price)
        
        
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
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
            print(tableView.indexPathForSelectedRow!.row)
            claimProductVC.product = self.allProducts[tableView.indexPathForSelectedRow!.row]
            claimProductVC.productIndex = tableView.indexPathForSelectedRow!.row
        } else {
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
