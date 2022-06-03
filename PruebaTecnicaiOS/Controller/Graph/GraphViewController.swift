//
//  GraphViewController.swift
//  PruebaTecnicaiOS
//
//  Created by Satoritech 15 on 02/06/22.
//

import UIKit
import FirebaseDatabase

class GraphViewController: UIViewController {
    
    @IBOutlet weak var firstPieGraph: JPieChart!
    @IBOutlet weak var seconPieGraph: JPieChart!
    @IBOutlet var circules: [UIView]!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblEmp1: UILabel!
    @IBOutlet weak var lblEmp2: UILabel!
    @IBOutlet weak var lblEmp3: UILabel!
    @IBOutlet weak var lblEmp4: UILabel!
    @IBOutlet weak var lblEmp5: UILabel!
    @IBOutlet weak var lblEmp6: UILabel!
    @IBOutlet weak var atvIndicator: UIActivityIndicatorView!
    
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchInformation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
    }

    
    //MARK: Setup UI
    private func setupUI(){
        ref = Database.database().reference()
        
        ref.child("screenColors").observe(DataEventType.value, with: {[weak self] snapshot in
           
            let backgrounds = Backgrounds()
            backgrounds.backgroundsFromSnapshot(snapshot: snapshot)
            
            self?.view.backgroundColor = UIColor(hex: backgrounds.graphScreenColor)
            
        })
        
        circules.forEach { (view) in
            view.layer.cornerRadius = view.bounds.width/2
        }
        
        atvIndicator.transform = atvIndicator.transform.scaledBy(x: 3, y: 3)
        atvIndicator.hidesWhenStopped = true
        atvIndicator.startAnimating()
        
        
    }
    
    private func fetchInformation(){
        
        InformationAPI.getInformation(){[weak self] response in
            
            self!.atvIndicator.stopAnimating()
            
            let cleanYes = response!.cleaning[0].value!
            let cleanNo = response!.cleaning[1].value!
            
            self!.firstPieGraph.lineWidth = 1
            self!.firstPieGraph.addChartData(data: [
                JPieChartDataSet(percent: CGFloat(cleanNo), colors: [UIColor.darkishPink,UIColor.red]),
                JPieChartDataSet(percent: CGFloat(cleanYes), colors: [UIColor.purpleishBlueThree,UIColor.green]),
            ])
            
            
            self!.lblYes.text = "SI \(cleanYes)%"
            self!.lblNo.text = "NO \(cleanNo)%"
            
            
            let emp1 = response!.security[0].value!
            let emp2 = response!.security[1].value!
            let emp3 = response!.security[2].value!
            let emp4 = response!.security[3].value!
            let emp5 = response!.security[4].value!
            let emp6 = response!.security[5].value!
            
            self!.seconPieGraph.lineWidth = 1
            self!.seconPieGraph.addChartData(data: [
                JPieChartDataSet(percent: CGFloat(emp1), colors: [UIColor.green,UIColor.green]),
                JPieChartDataSet(percent: CGFloat(emp2), colors: [UIColor.red,UIColor.red]),
                JPieChartDataSet(percent: CGFloat(emp3), colors: [UIColor.orange,UIColor.orange]),
                JPieChartDataSet(percent: CGFloat(emp4), colors: [UIColor.gray,UIColor.gray]),
                JPieChartDataSet(percent: CGFloat(emp5), colors: [UIColor.yellow,UIColor.yellow]),
                JPieChartDataSet(percent: CGFloat(emp6), colors: [UIColor.cyan,UIColor.cyan]),
            ])
            
            
            self!.lblEmp1.text = "\(response!.security[0].name!) \(emp1)%"
            self!.lblEmp2.text = "\(response!.security[1].name!) \(emp2)%"
            self!.lblEmp3.text = "\(response!.security[2].name!) \(emp3)%"
            self!.lblEmp4.text = "\(response!.security[3].name!) \(emp4)%"
            self!.lblEmp5.text = "\(response!.security[4].name!) \(emp5)%"
            self!.lblEmp6.text = "\(response!.security[5].name!) \(emp6)%"
            
        }
        
    }

}
