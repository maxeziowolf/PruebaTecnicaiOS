//
//  APIRequests.swift
//  WomanDriveConductor
//
//  Created by Satori Tech 13 on 4/4/22.
//  Copyright © 2022 Satoritech. All rights reserved.
//

import Foundation
import Alamofire
import UIKit.UIImage

class APIRequests {
    
    static func requestGet<T>(url: String, completion: @escaping (_ data: T?) -> Void) where T: Codable {
        AF.request(url, method: .get).responseDecodable { (response: DataResponse<T, AFError>) in
            debugPrint(response)
            if response.error != nil {
                NSLog("API error: \(String(describing: response.error))")
                completion(nil)
            } else {
                completion(response.value)
            }
        }
    }
    
}
