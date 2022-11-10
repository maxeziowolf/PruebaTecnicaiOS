//
//  MainViewController.swift
//  PruebaTecnicaiOS
//
//  Created by Satoritech 15 on 02/06/22.
//

import UIKit
import FirebaseDatabase
import YPImagePicker
import FirebaseStorage

class MainViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var tvMenu: UITableView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var imageFoto: UIImageView!
    @IBOutlet weak var atvIndicator: UIActivityIndicatorView!
    
    //MARK: Variables
    private let cells = [
        NameUserTextfieldTableViewCell.identifier,
        UserSelfieTableViewCell.identifier,
        GraphDescriptionTableViewCell.identifier
    ]
    private var userName: String?
    var ref: DatabaseReference!
    private var  image: UIImage?
    let storage = Storage.storage()
    
   

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }

    
    //MARK: Setup UI
    private func setupUI(){
        ref = Database.database().reference()
        
        ref.child("screenColors").observe(DataEventType.value, with: {[weak self] snapshot in
           
            let backgrounds = Backgrounds()
            backgrounds.backgroundsFromSnapshot(snapshot: snapshot)
            
            self?.view.backgroundColor = UIColor(hex: backgrounds.mainScreenColor)
            
        })
        
        setupTable()
        
        btnUpload.layer.cornerRadius = 20
        
        atvIndicator.transform = atvIndicator.transform.scaledBy(x: 3, y: 3)
        atvIndicator.hidesWhenStopped = true
        atvIndicator.startAnimating()
        atvIndicator.stopAnimating()
        
    }
    
    private func setupTable(){
        
        tvMenu.dataSource = self
        tvMenu.rowHeight = UITableView.automaticDimension
        tvMenu.separatorStyle = .none
        tvMenu.separatorColor = .clear
        
        cells.forEach { (identifier) in
            
            tvMenu.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            
        }
        
    }
    
    private func openCamera2(){
        
        let config = configurationYPImage()
        
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.imageFoto.isHidden = false
                self.image = photo.image
                self.imageFoto.image = photo.image
            }
            
            picker.dismiss(animated: true)
            
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
    public func configurationYPImage()-> YPImagePickerConfiguration{
        var config = YPImagePickerConfiguration()
        config.showsPhotoFilters = false
        config.albumName = "PruebaIOS"
        config.onlySquareImagesFromCamera = false
        config.wordings.next = "Seleccionar"
        config.wordings.libraryTitle = "Galería"
        config.wordings.cameraTitle = "Cámara"
        config.wordings.cancel = "Cancelar"
        return config
    }
    
    
    @IBAction func onUploadClicked(_ sender: Any) {
        
        let storageRef = storage.reference()
        
        // Data in memory
        let data = image?.jpegData(compressionQuality: 1)
        
        // Create a reference to the file you want to upload
        if let name = userName{
            
            if let photo = data{
                let riversRef = storageRef.child("images/\(name)-\(Date().getCurrentDateString()).jpg")
                
                atvIndicator.startAnimating()
                
                riversRef.putData(photo, metadata: nil){ (metadata, error) in
                    self.atvIndicator.stopAnimating()
                    
                    guard let metadata = metadata else {
                        print(error)
                        return
                        
                    }
                    
                    let alertController = UIAlertController (title: "Aviso", message: "Se subio correctamente la foto" , preferredStyle: .alert)
                    
                    let settingsAction = UIAlertAction(title: "Ok", style: .default)
                    
                    alertController.addAction(settingsAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }else{
                
                let alertController = UIAlertController (title: "Aviso", message: "Tome una selfi para poderla subir" , preferredStyle: .alert)
                
                let settingsAction = UIAlertAction(title: "Ok", style: .default)
                
                alertController.addAction(settingsAction)
                
                present(alertController, animated: true, completion: nil)
                
            }
            
        }else{
            
            let alertController = UIAlertController (title: "Aviso", message: "Ingrese un nombre para poder subir la foto." , preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Ok", style: .default)
            
            alertController.addAction(settingsAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
}

//MARK: MainViewController: UITableViewDataSource
extension MainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        cells.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: cells[indexPath.row],
                for: indexPath
            ) as! NameUserTextfieldTableViewCell
            
            cell.delegate = self
            
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: cells[indexPath.row],
                for: indexPath
            ) as! UserSelfieTableViewCell
            
            cell.delegate = self
            
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: cells[indexPath.row],
                for: indexPath
            ) as! GraphDescriptionTableViewCell
            
            cell.delegate = self
            
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: cells[indexPath.row],
                for: indexPath
            )
            
            return cell
            
            
        }
        
    }
    
}

//MARK: NameUserTextfieldTableViewCellDelegate
extension MainViewController: NameUserTextfieldTableViewCellDelegate{
    
    func updateUserName(userName: String) {
        
        self.userName = userName
        
        print(self.userName ?? "")
    }
    
}

//MARK: GraphDescriptionTableViewCellDelegate
extension MainViewController: GraphDescriptionTableViewCellDelegate{
    
    func openGraphView() {
        
        let vc =  UIStoryboard(name: "Graph", bundle: nil).instantiateViewController(withIdentifier: "GraphViewController")
        
        navigationController?.pushViewController(vc, animated: true)
        
        print("Abriendo grafica")
    }
    
}

//MARK:  UserSelfieTableViewCellDelegate

extension MainViewController:  UserSelfieTableViewCellDelegate{
    
    func openCamera(){
        
        
        
        let alertController = UIAlertController (title: "Aviso", message: "Seleccione una opción." , preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Tomar selfie.", style: .default) { (_) -> Void in
            
            self.openCamera2()
        }
        
        alertController.addAction(settingsAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
        
    }
    
}




