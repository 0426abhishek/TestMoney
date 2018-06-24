//
//  NetworkServiceCall.swift
//  TestMoney
//
//  Created by Abhishek Singh on 6/23/18.
//  Copyright © 2018 Abhishek Singh. All rights reserved.
//

import Foundation
import Alamofire


func makeCall(urlString: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
    Alamofire.request(urlString, parameters: nil)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(value as? NSDictionary, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
    }
}
