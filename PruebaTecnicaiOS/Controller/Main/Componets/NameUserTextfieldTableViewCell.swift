//
//  NameUserTextfieldTableViewCell.swift
//  PruebaTecnicaiOS
//
//  Created by Satoritech 15 on 02/06/22.
//

import UIKit

//MARK: Protocol
protocol NameUserTextfieldTableViewCellDelegate {
    func updateUserName(userName: String)
}

class NameUserTextfieldTableViewCell: UITableViewCell, ReuseCell{
    
    //MARK: Outlets
    @IBOutlet weak var tfUsername: UITextField!
    
    //MARK: Variables
    public var delegate: NameUserTextfieldTableViewCellDelegate?
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupUI()
    }
    
    //MARK: Setup()
    private func setupUI(){
        
        tfUsername.delegate = self
        
    }
    
    //MARK: Private Functions
    private func validateAlphabet(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let regEx = "([A-Z]*[a-z]*( )*)*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
         
        if (predicate.evaluate(with: string)){
            
            return true
            
        }else if string == ""{
            
            return true
            
        }
        
        return false
    }
    
}


//MARK: NameUserTextfieldTableViewCell
extension NameUserTextfieldTableViewCell: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        delegate?.updateUserName(userName: tfUsername.text ?? "")
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return validateAlphabet(textField, shouldChangeCharactersIn: range, replacementString: string)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
    }
    
}
