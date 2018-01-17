//
//  ViewController.swift
//  beacall
//
//  Created by Arnaud Manaranche on 20/12/2017.
//  Copyright © 2017 ArnaudManaranche. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var calendar: UITableView!
    
    var news = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: "ligne", for: indexPath) as! Pokemon
        
        let label:UILabel? = c.viewWithTag(10) as? UILabel
        
        // Cibler le tag
        label?.text = news[indexPath.row]
        
        return c
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession.shared
        let t = session.dataTask(with: URL(string: "http://172.16.4.140:8080/student1")!) { (data, rep, err) in
            if let e = err {
                print(e)
            } else if let d = data {
                do {
                    let dico = try JSONSerialization.jsonObject(with: d, options: []) as! [String:Any]
                    // Push les data dans la table view
                    for (k,v) in dico {
                        if v2 = v as! [String:Any] {
//                            for i in 0..<dico.count {
//                                self.news.append(v2[i]["title"] as! String)
//                            }
                        }
                    }
                    
                    // Action à exectuer plus tard (boucle principale libre)
                    DispatchQueue.main.async {
                        self.calendar?.reloadData()
                    }
                } catch {}
            }
        }
        t.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class Pokemon: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var begin: UILabel!
    @IBOutlet weak var end: UILabel!
}
