//
//  RegistrationViewController.swift
//  Smart Inventory
//
//  Created by Patlolla,Shruthi on 10/5/18.
//  Copyright © 2018 Jennaikode,Vamshi Raj. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController{
    
    var  backendless  =  Backendless.sharedInstance()
    
   
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var emailIdTF: UITextField!
    
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipTF: UITextField!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appbg.jpg")!)
        
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    /* @IBAction func onRegister(_ sender: Any) {
     
     let user = User(user_id: userIdTF.text! ,name: firstNameTF.text! + " " + lastNameTF.text!,
     email:emailIdTF.text!, password: passwordTF.text!, mobile: Int(mobileNumberTF.text!)!,dob: dobTF.text!, address:Address(firstLine: addressTF.text! ,city: cityTF.text! , state: stateTF.text! , zip: Int(zipTF.text!)!))
     UsersRepo.users.addUser(user)
     display(title: "Success", msg: "Registered successfully" )
     
     }
     
     @IBAction func onCancel(_ sender: Any) {
     let view = self.storyboard?.instantiateViewController(withIdentifier: "loginvc")
     self.present(view!, animated: true, completion: nil)
     }
     */
    
    func isValidEmail(email:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let validEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return validEmail.evaluate(with: email)
    }
    
    func isValidMobileNumber(mobileNumber: String) -> Bool {
        return mobileNumber.count == 10
    }
    
    func isValidPassword(password:String) -> Bool{
        return password.count >= 8
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "register"{

            
            //saving user to Backendless
            //Established a connection , need to work
            let userBackend = BackendlessUser()
            
            userBackend.setProperties(["name": fullNameTF.text!, "email": emailIdTF.text! ,"password": passwordTF.text!, "mobile": mobileNumberTF.text!, "address": addressTF.text!, "city": cityTF.text!, "state": stateTF.text!, "zip": zipTF.text!])
            
            let registeredUser = self.backendless?.userService.register(userBackend)
            print("User has been registered (SYNC): \(String(describing: registeredUser))")
            
            
            displayAlert(msg: "Registered successfully")
            
        }
    }
    
    func displayAlert(msg: String){
        let  alert  =  UIAlertController(title:  "Alert",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  nil))
        self.present(alert,  animated:  true,  completion:  nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "register" {
            
            if fullNameTF.text!.isEmpty || emailIdTF.text!.isEmpty || passwordTF.text!.isEmpty || confirmPasswordTF.text!.isEmpty || mobileNumberTF.text!.isEmpty || addressTF.text!.isEmpty || cityTF.text!.isEmpty || stateTF.text!.isEmpty || stateTF.text!.isEmpty || zipTF.text!.isEmpty {
                displayAlert(msg: "Enter values for all the fields")
                return false
            }
            if (!isValidEmail(email: emailIdTF.text!)){
                displayAlert(msg: "Inavlid Email ID")
                return false;
            }
            if (!isValidMobileNumber(mobileNumber: mobileNumberTF.text!)){
                displayAlert(msg: "Invalid Mobile Number")
            }
            if(!isValidPassword(password : passwordTF.text!)){
                displayAlert(msg: "Enter Password of length more than 8")
                return false
            }
            if(passwordTF.text! != confirmPasswordTF.text!){
                displayAlert(msg: "Password is Unmatched")
                return false;
            }
            
        }
        return true;
    }
    
    
    
}
