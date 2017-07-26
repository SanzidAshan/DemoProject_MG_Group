//
//  ViewController.swift
//  DemoProject
//
//  Created by MacBook Air on 25/07/2017.
//  Copyright © 2017 Sanzid. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    //Outlets
    @IBOutlet var emailTextfied: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func loginAction(_ sender: Any) {
        TextFieldValidation()
        postLoginRequest()
    }
    func postLoginRequest(){
        let parameters: [String : Any]? = [
            "tag": "login",
            "email": emailTextfied.text!,
            "password":passwordTextField.text!,
            ]
        let url = "http://54.218.102.254/scarecrow/json.php"
        Alamofire.request(url, method:.post, parameters:parameters).responseJSON { response in
            if response.result.value != nil {
                switch response.result {
                case .success:
                    if let jsonRoot = response.result.value as? [String:Any]!{
                        if let loginInfo = jsonRoot["success"] as! Bool!{
                            if loginInfo == true {
                                print("User Login Success")
                                self.localStorage()
                                self.performSegue(withIdentifier: "NewViewController", sender: NewViewController.self)
                            }
                            else {
                                print("User Login Fail")
                                self.displayMyAlertMessage("Wrong Username or Password")
                            }
                        }
                    }
                case .failure(let error):
                    
                    print(error)
                }
            } else{
                
                self.displayMyAlertMessage("Check Internet")
                print("Check Internet")
            }
            
        }
    }
    func localStorage(){
        
        UserDefaults.standard.set(emailTextfied.text, forKey: "name")
    }
    func TextFieldValidation(){
        if emailTextfied.text?.isEmpty == true{
            displayMyAlertMessage("Email field Missing")
        }
        if passwordTextField.text?.isEmpty == true{
            displayMyAlertMessage("Password field Missing")
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



