import UIKit

class AdminOrdersTableViewController: UITableViewController {
    
    static var ordersTVC:AdminOrdersTableViewController = AdminOrdersTableViewController()
    
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
    
    func displayAlert(msg: String){
        let  alert  =  UIAlertController(title:  "Order",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:nil))
        self.present(alert,  animated:  true,  completion:  nil)    }
    
    
    func displayError(msg: String){
        let alert = UIAlertController(title: "Failed", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
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
        let userName = tableView.viewWithTag(300) as! UILabel
        let quantity = tableView.viewWithTag(400) as! UILabel
        
        name.text = allOrders[indexPath.row].title
        userName.text = allOrders[indexPath.row].userName
        quantity.text = String(allOrders[indexPath.row].quantity)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    override func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
      
        let selectedOrder = self.allOrders[indexPath.row] as Order!
        var actions:[UIContextualAction] = []
        if (selectedOrder!.status == "pending") {
            let approveOrder = UIContextualAction(style: .normal, title:  "Approve", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                selectedOrder?.status = "approved"
                AllOrders.allOrders.saveOrder(order: selectedOrder!)
                self.displayAlert(msg: "Order has been approved")
                print("Approve order ...")
                success(true)
            })
            approveOrder.backgroundColor = .green
            
            // Write action code for the Flag
            let rejectOrder = UIContextualAction(style: .normal, title:  "Reject", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                selectedOrder?.status = "rejected"
                AllOrders.allOrders.saveOrder(order: selectedOrder!)
                self.displayAlert(msg: "Order has been rejected")
                print("Reject order ...")
                success(true)
            })
            rejectOrder.backgroundColor = .red
            
            actions = [approveOrder, rejectOrder]
        }
        else {
            actions = []
        }
        return UISwipeActionsConfiguration(actions: actions)
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
            let orderDetailsVC = segue.destination as! DetailedOrderViewController
            print(tableView.indexPathForSelectedRow!.row)
            DetailedOrderViewController.order = self.allOrders[tableView.indexPathForSelectedRow!.row]
        } else {
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
