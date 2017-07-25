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
    
    @IBOutlet var emailTextfied: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            
        }
        

    
    @IBAction func loginAction(_ sender: Any) {
        
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
    func displayMyAlertMessage(_ userMessage:String)
        {
    
            let myAlert = UIAlertController(title:"Something Wrong", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
    
            let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
    
            myAlert.addAction(okAction);
            self.present(myAlert, animated: true, completion: nil);
            
            
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

