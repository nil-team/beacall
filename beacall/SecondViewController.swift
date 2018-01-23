//
//  ViewController.swift
//  beacall
//
//  Created by nil-team on 20/12/2017.
//  Copyright © 2017 nil-team. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var calendar: UITableView!
    @IBOutlet weak var dateNow: UILabel!
    
    var placeFeed = [String]()
    var beginFeed = [String]()
    var endFeed = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ligne", for: indexPath) as! CalendarCell
        
        // Course begin label
        let labelBegin:UILabel? = cell.viewWithTag(11) as? UILabel
        labelBegin?.text = beginFeed[indexPath.row]
        
        // Course end label
        let labelEnd:UILabel? = cell.viewWithTag(12) as? UILabel
        labelEnd?.text = endFeed[indexPath.row]
        
        // Course place label
        let labelPlace:UILabel? = cell.viewWithTag(10) as? UILabel
        labelPlace?.text = placeFeed[indexPath.row]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display the date of the day
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        let result = formatter.string(from: date)
        dateNow.text = result
        
        // Fetch user calendar
        let session = URLSession.shared
        let t = session.dataTask(with: URL(string: "http://172.16.4.236:8080/student1")!) { (data, rep, err) in
            if let e = err {
                print(e)
            } else if let d = data {
                do {
                    let dico = try JSONSerialization.jsonObject(with: d, options: []) as! [String:Any]
                    for (k, v) in dico {
                        if k == "courses", let v2 = v as? [[String:Any]] {
                            for i in 0...dico.count {
                                self.placeFeed.append(v2[i]["place"] as! String)
                                self.beginFeed.append(v2[i]["begin"] as! String)
                                self.endFeed.append(v2[i]["end"] as! String)
                            }
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

class CalendarCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var begin: UILabel!
    @IBOutlet weak var end: UILabel!
}

