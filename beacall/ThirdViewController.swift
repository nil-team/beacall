//
//  ViewController.swift
//  beacall
//
//  Created by nil-team on 20/12/2017.
//  Copyright © 2017 nil-team. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login("http://172.16.4.236:8080/login")
    }
    
    func login(_ url:String) {
        
        let postUsername = username.text
        
        let url: URL = URL(string: url)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let paramString = "username=\(postUsername)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            if let dataString = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            {
                if(dataString == "true") {
                    print("OK")
                } else {
                  print("NOK")
                }
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
