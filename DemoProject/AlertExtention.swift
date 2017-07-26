//
//  AlertExtention.swift
//  DemoProject
//
//  Created by MacBook Air on 26/07/2017.
//  Copyright © 2017 Sanzid. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayMyAlertMessage(_ userMessage:String)
    {
        
        let myAlert = UIAlertController(title:"Something Wrong", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil);
        
        
    }
    
}
