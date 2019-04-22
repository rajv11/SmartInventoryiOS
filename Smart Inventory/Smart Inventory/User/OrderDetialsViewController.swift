//
//  OrderDetialsViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 3/17/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit
import Photos
class OrderDetialsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UITextView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var claimedTF: UITextField!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var updateOrderBtn: UIButton!
    @IBOutlet weak var requestSLabelBtn: UIButton!
    @IBOutlet weak var downloadSLabelBtn: UIButton!
    @IBOutlet weak var uploadShippingReceiptBtn: UIButton!
    @IBOutlet weak var confirmsAdminConfirmationBtn: UIButton!
    @IBOutlet weak var itemShippedBtn: UIButton!
    @IBOutlet weak var contactAdmin: UIButton!
    static var order:Order!
    @IBOutlet weak var requestPaymentBtn: UIButton!
    
    @IBAction func onCancelPaymentRequest(segue:UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateOrderBtn.isHidden =  true
        claimedTF.isEnabled = false
        claimedTF.backgroundColor = UIColor.clear
        requestSLabelBtn.isHidden = true
        downloadSLabelBtn.isHidden = true
        uploadShippingReceiptBtn.isHidden = true
        itemShippedBtn.isHidden = true
        confirmsAdminConfirmationBtn.isHidden = true
        contactAdmin.isHidden = true
        requestPaymentBtn.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (OrderDetialsViewController.order.status == Order.Status.Placed.rawValue ){
            updateOrderBtn.isHidden = false
            claimedTF.isEnabled = true
            claimedTF.backgroundColor = UIColor.white
            }
        if (OrderDetialsViewController.order.status == Order.Status.Approved.rawValue ){
            requestSLabelBtn.isHidden = false
        }
        if (OrderDetialsViewController.order.status == Order.Status.Receipt_Sent.rawValue ){
            itemShippedBtn.isHidden = false
            uploadShippingReceiptBtn.isHidden = true
            downloadSLabelBtn.isHidden = true
        }
        if (OrderDetialsViewController.order.status == Order.Status.Received_Order.rawValue ){
            confirmsAdminConfirmationBtn.isHidden = false
        }
        if (OrderDetialsViewController.order.status == Order.Status.Order_Confirmed.rawValue ){
            requestPaymentBtn.isHidden = false
        }
        if (OrderDetialsViewController.order.status == Order.Status.Order_not_received.rawValue ){
            contactAdmin.isHidden = false
        }
        if (OrderDetialsViewController.order.status == Order.Status.ShippingLbl_Sent.rawValue){
            downloadSLabelBtn.isHidden = false
            uploadShippingReceiptBtn.isHidden = false
        }
//        if  OrderDetialsViewController.order.status == Order.Status.Shipped_Order.rawValue {
//            uploadShippingReceiptBtn.isHidden = false
//        }
        nameLbl.text = String(OrderDetialsViewController.order.product.name)
        descLbl.text = String(OrderDetialsViewController.order.product.productDescription)
        claimedTF.text = String(OrderDetialsViewController.order.quantity)
        priceLbl.text = String(OrderDetialsViewController.order.product.price)
        statusLbl.text = OrderDetialsViewController.order.status
    }
    
    func displayAlert(msg: String){
        let  alert  =  UIAlertController(title:  "Order",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  { _ in
            self.performSegue(withIdentifier: "modifiedOrder", sender: nil)
        }))
        self.present(alert,  animated:  true,  completion:  nil)    }
    
    
    func displayError(msg: String){
        let alert = UIAlertController(title: "Failed", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


    @IBAction func updateOrder(_ sender: Any) {
        let modifiedOrder = OrderDetialsViewController.order!
        let claimQty = Int(self.claimedTF.text!)!
        let additionalClaims = claimQty - modifiedOrder.quantity
        let announcement =  Announcements.announce.getAnnouncement(objectID: modifiedOrder.product.parentId)
        if (additionalClaims > announcement.unclaimed){
            self.displayError(msg: "Can not claim more than \(announcement.unclaimed) products")
        }
        else if(claimQty <= 0){
            self.displayError(msg: "Enter valid number")
        }
        else{
            modifiedOrder.quantity = claimQty
            announcement.claimed = announcement.claimed + additionalClaims
            announcement.unclaimed = announcement.product.quantity - announcement.claimed
            Announcements.announce.updateAnnouncement(announcement: announcement)
            AllOrders.allOrders.saveOrder(order: modifiedOrder)
            displayAlert(msg: "Order has been modified successfully")
        }
    }
    
    @IBAction func requestSLabel(_ sender: Any) {
        let order = OrderDetialsViewController.order
        order?.status = Order.Status.ShippingLbl_Requested.rawValue
        AllOrders.allOrders.saveOrder(order: order!)
        displayAlert(msg: "Requested shipping label successfully")
    }
    
    @IBAction func downloadSLabel(_ sender: Any) {
        _ = OrderDetialsViewController.order
        let urlString = "https://backendlessappcontent.com/388C88F0-9D31-2F50-FFC1-AFC261CEED00/3E7299E0-45DA-682C-FFB6-31838A69DE00/files/shippingLable/\(OrderDetialsViewController.order.objectId!)+.jpeg"
        let url = URL(string: urlString)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: imageData)
            self.downloadFile(image: image!)
            
        }
        
    }
    func downloadFile(image:UIImage) {
        print(image)
        PHPhotoLibrary.requestAuthorization( { status in
            print(status)
            if status == .authorized {
                PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image)
                }, completionHandler: { success, error in
                    if success {
                        self.displayAlert(msg: "Downloaded shipping label successfully")
                    }
                    else if let error = error {
                        self.displayAlert(msg: error.localizedDescription)
                    }
                    else {
                        self.displayAlert(msg: "Failed to download")
                    }
                })
            }
            else {
                return
            }
            
        })
        
        
    }
    func uploadFile(data:Data) {
        print(OrderDetialsViewController.order.objectId!)
        let path:String = "/shippingReceipt/\(OrderDetialsViewController.order.objectId!).jpeg"
        Backendless.sharedInstance().file.uploadFile(path, content: data,
                                    overwriteIfExist: true)
        OrderDetialsViewController.order.status = Order.Status.Receipt_Sent.rawValue
        AllOrders.allOrders.saveOrder(order: OrderDetialsViewController.order)
        let  alert  =  UIAlertController(title:  "Done",  message: "Shipping Receipt Uploaded",  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  nil))
        self.present(alert,  animated:  true,  completion:  nil)
    }
    
//    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
//    func downloadImage(from url: URL) {
//        print("Download Started")
//        getData(from: url) { data, response, error in
//             let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            DispatchQueue.main.async() {
//                let image = UIImage(data: data)
//                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
//            }
//        }
//    }
    @IBAction func itemShipped(_ sender: Any) {
        OrderDetialsViewController.order.status = Order.Status.Shipped_Order.rawValue
        AllOrders.allOrders.saveOrder(order: OrderDetialsViewController.order)
        displayAlert(msg: "Order Shipped")
    }
    @IBAction func confirmAdminsConfirmation(_ sender: Any) {
        OrderDetialsViewController.order.status = Order.Status.Order_Confirmed.rawValue
        AllOrders.allOrders.saveOrder(order: OrderDetialsViewController.order)
        displayAlert(msg: "Confirmed Order")
    }
    
    @IBAction func uploadSReceipt(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageURL = info[UIImagePickerController.InfoKey.imageURL] as! NSURL
        
        picker.dismiss(animated: true, completion: nil)
        
        //extract image from the picker and save it
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let imageData = pickedImage.jpegData(compressionQuality: 0.75)
            try! imageData?.write(to: imageURL as URL)
            self.uploadFile(data: imageData!)
        }
        
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
