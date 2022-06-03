//
//  Api.swift
//  WomanDriveConductor
//
//  Created by Satori Tech on 7/8/20.
//  Copyright © 2020 Satoritech. All rights reserved.
//

import Alamofire

class Api {
    // System
    private static let urlAPI = "https://satoritech.com.mx/api/test"
    
    static func getInformation(completion: @escaping (_ response: InformationAPI?) -> Void){
        APIRequests.requestGet(url: urlAPI, completion: completion)
    }
        

}
