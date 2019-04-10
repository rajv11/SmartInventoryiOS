//
//  DetailedOrderViewController.swift
//  Smart Inventory
//
//  Created by Shruthi  Patlolla on 4/8/19.
//  Copyright © 2019 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class DetailedOrderViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UITextView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var claimedLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var uploadShippingLabelBtn: UIButton!
    
    static var order:Order!
    let backendless = Backendless.sharedInstance()!
    override func viewDidLoad() {
        super.viewDidLoad()
         uploadShippingLabelBtn.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(DetailedOrderViewController.order.status == "requested"){
            uploadShippingLabelBtn.isHidden = false
        }
        nameLbl.text = String(DetailedOrderViewController.order.product.name)
        descLbl.text = String(DetailedOrderViewController.order.product.productDescription)
        claimedLbl.text = String(DetailedOrderViewController.order.quantity)
        priceLbl.text = String(DetailedOrderViewController.order.product.price)
        statusLbl.text = String(DetailedOrderViewController.order.status)
        userNameLbl.text = String(DetailedOrderViewController.order.userName)
    }
    
    func displayAlert(msg: String){
        let  alert  =  UIAlertController(title:  "Order",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  { _ in
            self.performSegue(withIdentifier: "orderDone", sender: nil)
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
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imageURL = info[UIImagePickerController.InfoKey.imageURL] as! NSURL
        let imageName = URL(fileURLWithPath: imageURL.absoluteString!).lastPathComponent
        //print(imageName)
        let imagePath = documentsPath?.appendingPathComponent(imageName)
        //print(imagePath?.absoluteString)
        picker.dismiss(animated: true, completion: nil)
        
         //extract image from the picker and save it
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let imageData = pickedImage.jpegData(compressionQuality: 0.75)
            try! imageData?.write(to: imagePath!)
            self.uploadFile(data: imageData!)
        }
        
    }
   
    func uploadFile(data:Data) {
       
        let path:String = "/shippingLable/\(DetailedOrderViewController.order.product.objectId!) .jpeg"
        backendless.file.uploadFile(path, content: data,
                                    overwriteIfExist: true)
        let  alert  =  UIAlertController(title:  "Done",  message: "Shipping Lable Uploaded",  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  nil))
        self.present(alert,  animated:  true,  completion:  nil)
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
