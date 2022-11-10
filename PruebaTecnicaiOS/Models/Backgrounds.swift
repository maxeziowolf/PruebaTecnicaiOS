//
//  Backgrounds.swift
//  PruebaTecnicaiOS
//
//  Created by Satoritech 15 on 02/06/22.
//

import FirebaseDatabase

class Backgrounds {
    
    var mainScreenColor: String!
    var graphScreenColor: String!
    
    init() {}
    
    public func backgroundsFromSnapshot(snapshot: DataSnapshot){
        
        let value = snapshot.value as? NSDictionary
        self.mainScreenColor = value?["mainScreenColor"] as? String ?? ""
        self.graphScreenColor  = value?["graphScreenColor"] as? String ?? ""
        
    }
    
}
