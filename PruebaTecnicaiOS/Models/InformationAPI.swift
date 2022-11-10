//
//  InformationAPI.swift
//  PruebaTecnicaiOS
//
//  Created by Satoritech 15 on 02/06/22.
//


struct InformationAPI: Codable {
    let data: [Datum]?
    
    static func getInformation(completion: @escaping (_ response: InformationAPI?) -> Void){
        Api.getInformation(completion: completion)
    }
}

// MARK: - Datum
struct Datum: Codable {
    let pregunta: String?
    let values: [Value]?
}

// MARK: - Value
struct Value: Codable {
    let label: String?
    let value: Int?
}
