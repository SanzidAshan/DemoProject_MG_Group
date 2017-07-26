//
//  NewViewController.swift
//  DemoProject
//
//  Created by Sanzid iOS on 7/26/17.
//  Copyright © 2017 Sanzid. All rights reserved.
//

import UIKit
import Alamofire

class NewViewController: UIViewController {
    
    @IBOutlet var emailLabel: UILabel!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var token: UILabel!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
         getDataRequest()
        // Do any additional setup after loading the view.
    }

    func getDataRequest(){
        
        
        let parameters: [String : Any]? = [
            "tag": "getData",
            
            ]
        
        let url = "http://54.218.102.254/scarecrow/json.php"
        
        Alamofire.request(url, method:.post, parameters:parameters).responseJSON { response in
            
            if response.result.value != nil {

            switch response.result {
                
            case .success:
                if let jsonRoot = response.result.value as? [String:Any]!{
                    self.emailLabel.text = jsonRoot["email"] as? String
                    self.name.text = jsonRoot["name"] as? String
                    self.token.text = jsonRoot["token"] as? String

                }
                print(response)
                
            case .failure(let error):
                
                print(error)
            }
            }
                else{
                    self.displayMyAlertMessage("Check Your Internet Connection")
                    print("Check Your Internet Connection")
                }
            
        }
            
        
        
        
    }
    @IBAction func LogOutAction(_ sender: Any) {
        
       UserDefaults.standard.removeObject(forKey: "name")
       performSegue(withIdentifier: "ViewController", sender: ViewController.self)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
