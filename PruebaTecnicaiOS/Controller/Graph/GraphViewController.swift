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
            
            let cleanYes = response?.data?.first?.values?.first(where: {$0.label?.lowercased() == "si"})?.value ?? 0
            let cleanNo = response?.data?.first?.values?.first(where: {$0.label?.lowercased() == "no"})?.value ?? 0
            
            self!.firstPieGraph.lineWidth = 1
            self!.firstPieGraph.addChartData(data: [
                JPieChartDataSet(percent: CGFloat(cleanNo), colors: [UIColor.darkishPink,UIColor.red]),
                JPieChartDataSet(percent: CGFloat(cleanYes), colors: [UIColor.purpleishBlueThree,UIColor.green]),
            ])
            
            
            self!.lblYes.text = "SI \(cleanYes)%"
            self!.lblNo.text = "NO \(cleanNo)%"
            
            
            let emp1 = response?.data?[1].values?[0].value ?? 0
            let emp2 = response?.data?[1].values?[1].value ?? 0
            let emp3 = response?.data?[1].values?[2].value ?? 0
            let emp4 = response?.data?[1].values?[3].value ?? 0
            let emp5 = response?.data?[1].values?[4].value ?? 0
            let emp6 = response?.data?[1].values?[5].value ?? 0

            self!.seconPieGraph.lineWidth = 1
            self!.seconPieGraph.addChartData(data: [
                JPieChartDataSet(percent: CGFloat(emp1), colors: [UIColor.green,UIColor.green]),
                JPieChartDataSet(percent: CGFloat(emp2), colors: [UIColor.red,UIColor.red]),
                JPieChartDataSet(percent: CGFloat(emp3), colors: [UIColor.orange,UIColor.orange]),
                JPieChartDataSet(percent: CGFloat(emp4), colors: [UIColor.gray,UIColor.gray]),
                JPieChartDataSet(percent: CGFloat(emp5), colors: [UIColor.yellow,UIColor.yellow]),
                JPieChartDataSet(percent: CGFloat(emp6), colors: [UIColor.cyan,UIColor.cyan]),
            ])


            self!.lblEmp1.text = "\(response?.data?[1].values?[0].label ?? "") \(emp1)%"
            self!.lblEmp2.text = "\(response?.data?[1].values?[1].label ?? "") \(emp2)%"
            self!.lblEmp3.text = "\(response?.data?[1].values?[2].label ?? "") \(emp3)%"
            self!.lblEmp4.text = "\(response?.data?[1].values?[3].label ?? "") \(emp4)%"
            self!.lblEmp5.text = "\(response?.data?[1].values?[4].label ?? "") \(emp5)%"
            self!.lblEmp6.text = "\(response?.data?[1].values?[5].label ?? "") \(emp6)%"
            
        }
        
    }

}
