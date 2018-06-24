//
//  ViewControllerInteractor.swift
//  TestMoney
//
//  Created by Abhishek Singh on 6/23/18.
//  Copyright © 2018 Abhishek Singh. All rights reserved.
//

import Foundation

func getRequest(completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
    makeCall(urlString: "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=Sachin+T&gpslimit=10", completionHandler: completionHandler)
}

func getJson() -> NSArray
{
    let responseKey  = UserDefaults.standard.object(forKey: "responseKey") as! NSArray;
    return responseKey;
}

func getDescription(key : NSObject) -> String{
    let descArray: NSArray?   = key as? NSArray
    var data : String = "";
    for (descData) in descArray!
    {
        data.append(descData as! String)
    }
    
    return data;
    
}


