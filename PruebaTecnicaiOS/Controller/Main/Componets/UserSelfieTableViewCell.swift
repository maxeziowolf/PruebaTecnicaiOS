//
//  UserSelfieTableViewCell.swift
//  PruebaTecnicaiOS
//
//  Created by Satoritech 15 on 02/06/22.
//

import UIKit

protocol UserSelfieTableViewCellDelegate {
    func openCamera()
}


class UserSelfieTableViewCell: UITableViewCell, ReuseCell {
    
    //MARK: Outlets
    @IBOutlet weak var card: UIView!
    
    public var delegate: UserSelfieTableViewCellDelegate?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }

    private func setup(){
        
        card.isUserInteractionEnabled = true
        card.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(opendCamare)))
        
    }
    
    @objc
    private func opendCamare(){
        
        delegate?.openCamera()
        
    }
 
    
}
