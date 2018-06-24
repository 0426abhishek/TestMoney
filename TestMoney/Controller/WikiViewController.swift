//
//  WikiViewController.swift
//  TestMoney
//
//  Created by Abhishek Singh on 6/24/18.
//  Copyright © 2018 Abhishek Singh. All rights reserved.
//

import UIKit

class WikiViewController: UIViewController {
  
    @IBOutlet weak var webViews: UIWebView!
    var text:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL (string: "https://en.wikipedia.org/wiki/\(String(describing: text!))")
        let requestObj = URLRequest(url: url!)
        webViews.loadRequest(requestObj)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        
       performSegue(withIdentifier: "segue1", sender: self)
        
        
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
