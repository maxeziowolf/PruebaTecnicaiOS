//
//  GraphDescriptionTableViewCell.swift
//  PruebaTecnicaiOS
//
//  Created by Satoritech 15 on 02/06/22.
//

import UIKit

//MARK: Protocol
protocol GraphDescriptionTableViewCellDelegate {
    func openGraphView()
}

class GraphDescriptionTableViewCell: UITableViewCell, ReuseCell {

    //MARK: Outlets
    @IBOutlet weak var card: UIView!
    
    
    //MARK: Variables
    public var delegate: GraphDescriptionTableViewCellDelegate?
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupUI()
    }
    
    //MARK: setupUI
    
    private func setupUI(){
        
        card.isUserInteractionEnabled = true
        card.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openGraphView)))
        
    }
    
    //MARK: Objc Functions
    @objc
    private func openGraphView(){
        
        delegate?.openGraphView()
        
    }
    
    
    
}
