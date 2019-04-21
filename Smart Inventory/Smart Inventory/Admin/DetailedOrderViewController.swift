//
//  DetailedOrderViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 4/8/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit
import Photos
class DetailedOrderViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UITextView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var claimedLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var uploadShippingLabelBtn: UIButton!
    @IBOutlet weak var orderReceived: UIButton!
    @IBOutlet weak var orderNotReceived: UIButton!
    @IBOutlet weak var downloadReceiptBtn: UIButton!
    @IBOutlet weak var payBtn: UIButton!
    
    static var order:Order!
    let backendless = Backendless.sharedInstance()!
    override func viewDidLoad() {
        super.viewDidLoad()
         uploadShippingLabelBtn.isHidden = true
         orderReceived.isHidden = true
         orderNotReceived.isHidden = true
        downloadReceiptBtn.isHidden = true
        payBtn.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(DetailedOrderViewController.order.status == Order.Status.ShippingLbl_Requested.rawValue){
            uploadShippingLabelBtn.isHidden = false
        }
        if(DetailedOrderViewController.order.status == Order.Status.Shipped_Order.rawValue){
            orderReceived.isHidden = false
            orderNotReceived.isHidden = false
        }
        if(DetailedOrderViewController.order.status == Order.Status.Receipt_Sent.rawValue){
            downloadReceiptBtn.isHidden = false
        }
        if(DetailedOrderViewController.order.status == Order.Status.Payment_Requested.rawValue){
            payBtn.isHidden = false
        }
        nameLbl.text = String(DetailedOrderViewController.order.product.name)
        descLbl.text = String(DetailedOrderViewController.order.product.productDescription)
        claimedLbl.text = String(DetailedOrderViewController.order.quantity)
        priceLbl.text = String(DetailedOrderViewController.order.product.price)
        statusLbl.text = DetailedOrderViewController.order.status
        userNameLbl.text = String(DetailedOrderViewController.order.userName)
    }
    
    
    
    func displayAlert(msg: String){
        let  alert  =  UIAlertController(title:  "Order",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,  animated:  true,  completion:  nil)    }
    func displayError(msg: String){
        let alert = UIAlertController(title: "Failed", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func uploadSLabel(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
        DetailedOrderViewController.order.status = Order.Status.ShippingLbl_Sent.rawValue
        AllOrders.allOrders.saveOrder(order: DetailedOrderViewController.order)
        
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
   
    func uploadFile(data:Data) {
       
        let path:String = "/shippingLable/\(DetailedOrderViewController.order.objectId!) .jpeg"
        backendless.file.uploadFile(path, content: data,
                                    overwriteIfExist: true)
        self.displayAlert(msg: "Shipping Lable Uploaded")
        
    }
    
    @IBAction func orderReceived(_ sender: Any) {
        let order = DetailedOrderViewController.order!
        order.status = Order.Status.Received_Order.rawValue
        AllOrders.allOrders.saveOrder(order: order)
        self.displayAlert(msg: "Order Confirmed")
        
    }
    @IBAction func orderNotReceived(_ sender: Any) {
        let order = DetailedOrderViewController.order!
        order.status = Order.Status.Order_not_received.rawValue
        AllOrders.allOrders.saveOrder(order: order)
        self.displayAlert(msg: "Order not received")
    }
    
    @IBAction func downloadReceipt(_ sender: Any) {
        print("in download")
        let urlString = "https://backendlessappcontent.com/388C88F0-9D31-2F50-FFC1-AFC261CEED00/3E7299E0-45DA-682C-FFB6-31838A69DE00/files/shippingReceipt/\(DetailedOrderViewController.order.objectId!).jpeg"
        let url = URL(string: urlString)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: imageData)
            self.downloadFile(image: image!)
        }
        //        order?.status = Order.Status.Shipped_Order.rawValue
        //        AllOrders.allOrders.saveOrder(order: order!)
//        let  alert  =  UIAlertController(title:  "Order",  message: "Receipt Downloaded",  preferredStyle:  .alert)
//        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  nil))
//        self.present(alert,  animated:  true,  completion:  nil)
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
                        self.displayAlert(msg: "Downloaded shipping receipt successfully")
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
