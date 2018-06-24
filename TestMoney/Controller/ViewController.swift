//
//  ViewController.swift
//  TestMoney
//
//  Created by Abhishek Singh on 6/23/18.
//  Copyright © 2018 Abhishek Singh. All rights reserved.
//

import UIKit
import Alamofire


class tableViewCell:UITableViewCell
{
    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var titleView: UILabel!
}

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableViews: UITableView!
    var wikiText:String?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getJson().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! tableViewCell
        cell.imageViews.image = nil
        let response = getJson()[indexPath.row] as AnyObject
        cell.titleView.text = (response.object(forKey: "title") as! String)
        wikiText = (response.object(forKey: "title") as! String)
        let description = response.object(forKey: "terms") as AnyObject
        let image = response.object(forKey: "thumbnail") as AnyObject
        if let imageUrl = image["source"] {
            URLSession.shared.dataTask(with: NSURL(string: imageUrl as! String)! as URL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    cell.imageViews.image = image
                })
            }).resume()
        }
        if let desc = description["description"] {
            cell.descriptionView.text = (getDescription(key: desc as! NSObject))
        }
        tableView.tableFooterView = UIView(frame: .zero)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        serviceCall();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        wikiText = nil
        let indexPath = self.tableViews.indexPathForSelectedRow!
        let response = getJson()[indexPath.row] as AnyObject
        wikiText = (response.object(forKey: "title") as! String)
        let send = segue.destination as! WikiViewController
        send.text = wikiText?.replacingOccurrences(of: " ", with: "_")
    }
    
    func  serviceCall(){
        if Reachability.isConnectedToNetwork(){
            UserDefaults.standard.removeObject(forKey: "responseKey")
            getRequest() { responseObject, error in
                for (key, value) in responseObject! {
                    let keyElement : String = key as! String
                    if keyElement == "query"{
                        let result : NSDictionary = value as! NSDictionary
                        UserDefaults.standard.set(result.object(forKey: "pages"), forKey: "responseKey")
                        self.tableViews.dataSource = self
                        self.tableViews.delegate = self
                        self.tableViews.reloadData()
                        break;
                    }
                }
                return
            }
        }
        else{
            tableViews.delegate = self
            tableViews.dataSource = self
            self.tableViews.reloadData()
        }
        
    }
    
   
}


