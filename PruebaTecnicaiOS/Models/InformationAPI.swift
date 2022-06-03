//
//  InformationAPI.swift
//  PruebaTecnicaiOS
//
//  Created by Satoritech 15 on 02/06/22.
//


struct InformationAPI : Codable{
    
    let security: [Security]!
    let cleaning: [Cleaning]!
    
    static func getInformation(completion: @escaping (_ response: InformationAPI?) -> Void){
        Api.getInformation(completion: completion)
    }
}

struct Security : Codable{
    
    let name: String!
    let value: Int!
    
    
}

struct Cleaning : Codable{
    
    let name: String!
    let value: Int!
}
