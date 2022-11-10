//
//  Protocols.swift
//  PruebaTecnicaiOS
//
//  Created by Satoritech 15 on 02/06/22.
//

import UIKit


//MARK: ReuseCell
protocol ReuseCell {
    static var identifier: String { get }
    static var nibName: UINib { get }
}

extension ReuseCell {
    static var identifier: String {
        return String(describing: self)
    }
    static var nibName: UINib {
        return UINib(nibName: identifier, bundle: .main)
    }
}
