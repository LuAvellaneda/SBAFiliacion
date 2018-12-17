//
//  FichaViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 20/8/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

struct FichaDetalle{
    var label: String?
    var value: String?
    var icono: String?
    
    init(_ label:String?, _ value:String? ,_ icono:String?) {
        self.label = label
        self.value = value
        self.icono = icono
    }
}

class EjemplarTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ficha", for: indexPath) as! EjemplarFichaTableViewCell
            return cell
            
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "form", for: indexPath) as! FormTableViewCell
            cell.titulo = "Destetado"
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "form", for: indexPath) as! FormTableViewCell
            cell.titulo = "Sin tarjeta"
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "form", for: indexPath) as! FormTableViewCell
            cell.titulo = "Muerto"
            return cell
        }
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nota", for: indexPath) as! NotaTableViewCell
            
            cell.nota = ejemplar?.nota!
            
            return cell
        }
        
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "fotos", for: indexPath) as! EjemplarFotoTableViewCell
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
       
        if indexPath.row == 0 {
            if let cell = cell as? EjemplarFichaTableViewCell {
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                cell.collectionView.reloadData()
                //cell.collectionView.isScrollEnabled = false
            }
        }
        
        if indexPath.row == 1 {
            if let cell = cell as? EjemplarFotoTableViewCell {
                celdaFotos = cell
                celdaFotos.fotos = fotos
            }
        }
        
        
    }
    
    
    var ejemplar: Ejemplar! {
        didSet {
            
            navigationItem.title = ejemplar.madre
            navigationItem.prompt = "\(ejemplar.nombre!) - \(ejemplar.sexo!)"
            
            dataSource.append(FichaDetalle("Pelo", ejemplar.pelo,"pelo"))
            dataSource.append(FichaDetalle("Raza", "Sangre Pura","raza2"))
            dataSource.append(FichaDetalle("Microchip",ejemplar.microchip.description,"microchip"))
            dataSource.append(FichaDetalle("C", ejemplar.anio,"calendario"))
            
            
        }
    }
    
    let db: PersistenceManager
    var dataSource = [FichaDetalle]()
    var imagePicker: UIImagePickerController!
    var filtro: Int32? {
        didSet {
            print("Set haras")
        }
    }
    
    var fotos = [UIImage]()
    var celdaFotos = EjemplarFotoTableViewCell()
    
    @IBOutlet weak var fichaTableView: UITableView!
    @IBOutlet weak var fichaImagen: UIImageView!
    
    @IBOutlet weak var por: UILabel!
    
    @IBAction func abrirCamara(_ sender: UIBarButtonItem) {
    
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        db = PersistenceManager.shared
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let ejemplar_id = ejemplar?.id {
            let directorio:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let dibujo:URL = directorio.appendingPathComponent("dibujo_\(ejemplar_id).png")
            
            if let image: UIImage = UIImage(contentsOfFile: dibujo.path) {
                self.fichaImagen.image = image
            }
            
            //Info Ejemplar
            por.text? = (ejemplar?.por) ?? ""
            
            //Fotos
            let cantidadFotos = (ejemplar?.fotos)!
            if(cantidadFotos > 0) {
                
                for index in 1...cantidadFotos {
                    let foto:URL = directorio.appendingPathComponent("foto_\(ejemplar_id)_\(index).png")
                    let image:UIImage = UIImage(contentsOfFile: foto.path)!
                    fotos.append(image)
                }
                
            }
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
        
        let siguienteIndiceFotos = (ejemplar?.fotos)! + 1
        let id = (ejemplar?.id)!
        
        let nombre = "foto_\(id)_\(siguienteIndiceFotos).png"
        
        _ = EjemplarTableViewController.storeImageToDocumentDirectory(image: image,fileName: nombre)
        
        ejemplar?.fotos = siguienteIndiceFotos
        db.save()
        
        fotos.append(image)
        celdaFotos.fotos = fotos
        
        picker.dismiss(animated: true, completion: nil)
        
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDibujo" {
            
            let dibujoViewController = segue.destination as! DibujoViewController
            dibujoViewController.ejemplar = self.ejemplar
            
        }
        
    }
    
    public static func storeImageToDocumentDirectory(image: UIImage, fileName: String) -> URL? {
        guard let data = image.pngData() else {
            return nil
        }
        let fileURL = self.fileURLInDocumentDirectory(fileName)
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            return nil
        }
    }
    
    public static var documentsDirectoryURL: URL {
        return FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
    }
    public static func fileURLInDocumentDirectory(_ fileName: String) -> URL {
        return self.documentsDirectoryURL.appendingPathComponent(fileName)
    }
    

}



extension EjemplarTableViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! EjemplarFichaCollectionViewCell
        
        let data = dataSource[indexPath.row]
        cell.iconoString = data.icono
        cell.info = data.value
        
        return cell
        
    }
    
}


/*

extension EjemplarTableViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 2.5
        let itemWidth = (collectionView.bounds.width - 5.0) / 2.0
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
*/






// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
