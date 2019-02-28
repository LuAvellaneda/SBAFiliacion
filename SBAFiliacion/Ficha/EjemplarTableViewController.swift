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
        
        if(section == 0 && ejemplar != nil) {
            return 2
        }
        
        if(section == 1 && ejemplar != nil) {
            return 6
        }
        
        if(section == 2 && ejemplar != nil) {
            return 1
        }
        
        return 0
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if (ejemplar == nil) {
            return 0
        }
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        if(section == 0) {
            return "Información"
        }
        
        if(section == 1) {
            return "Estado ejemplar"
        }
        
        if(section == 2) {
            return "Fotos"
        }
        
        return ""
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ficha", for: indexPath) as! EjemplarFichaTableViewCell
            
            let width = (view.frame.size.width - 30) / 5
            let layout = cell.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: width, height: 140)
            
            return cell
        }
        
        if indexPath.row == 1 && indexPath.section == 0 {
            //let cell = tableView.dequeueReusableCell(withIdentifier: "lugar", for: indexPath) as! LugarTableViewCell
            //return cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "lugarbeta", for: indexPath) as! LugarTableViewCell
            cell.linea1?.text = "\(ejemplar.lugar_cuidador!). Tel: \(ejemplar.lugar_telefono!)"
            cell.linea2?.text = "\(ejemplar.lugar_lugar!)"
            cell.linea3?.text = "\(ejemplar.lugar_observacion ?? "Sin observación")"
            
            return cell
            
        }
        
        if indexPath.row == 0 && indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "form", for: indexPath) as! FormTableViewCell
            
            cell.id = "destetado"
            cell.titulo = "Destetado"
            cell.callBack = setCambios(id:val:)
            
            return cell
            
        }
        
        if indexPath.row == 1 && indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "form", for: indexPath) as! FormTableViewCell
            cell.id = "sin-tarjeta"
            cell.titulo = "Sin pasaporte"
            cell.callBack = setCambios(id:val:)
            
            return cell
        }
        
        if indexPath.row == 2 && indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "form", for: indexPath) as! FormTableViewCell
            cell.id = "sin-denuncia"
            cell.titulo = "Sin denuncia"
            cell.callBack = setCambios(id:val:)
            
            return cell
        }
        
        if indexPath.row == 3 && indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "form", for: indexPath) as! FormTableViewCell
            cell.id = "muerto"
            cell.titulo = "Muerto"
            cell.callBack = setCambios(id:val:)
            cell.valor = ejemplar?.muerto
            
            return cell
        }
        
        if indexPath.row == 4 && indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "form", for: indexPath) as! FormTableViewCell
            cell.id = "no-visto"
            cell.titulo = "No visto"
            cell.callBack = setCambios(id:val:)
            cell.valor = ejemplar?.visto_no
            
            return cell
        }
        
        if indexPath.row == 5 && indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "nota", for: indexPath) as! NotaTableViewCell
            cell.nota = ejemplar?.nota ?? "Sin nota"
            return cell
        }
        
        
        if indexPath.row == 0 && indexPath.section == 2{
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
            
            dataSource = [FichaDetalle]()
            
            navigationItem.title = ejemplar.nombre
            
            dataSource.append(FichaDetalle("Sexo", ejemplar.sexo,"logo"))
            dataSource.append(FichaDetalle("Pelo", ejemplar.pelo,"pelo"))
            dataSource.append(FichaDetalle("Raza", ejemplar.raza ?? "Sin Asignar","raza2"))
            dataSource.append(FichaDetalle("Microchip",ejemplar.microchip.description,"microchip"))
            dataSource.append(FichaDetalle("C", ejemplar.anio,"calendario"))
            
            
        }
    }
    
    let db: PersistenceManager
    var dataSource = [FichaDetalle]()
    var imagePicker: UIImagePickerController!
    
    var fotos = [UIImage]()
    var celdaFotos = EjemplarFotoTableViewCell()
    
    @IBOutlet weak var fichaTableView: UITableView!
    @IBOutlet weak var fichaImagen: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var fechaModificadoLabel: UILabel!
    @IBOutlet weak var por: UILabel!
    @IBOutlet weak var criador: UILabel!
    
    @IBAction func editarButton(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "ShowEditar", sender: nil)
        
    }
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
    
    func setCambios(id:String,val:Bool){
        
        let date:NSDate = NSDate()
        
        if( id == "muerto") {
            ejemplar.muerto = val
            ejemplar.modificado = date
            db.save()
        }
        
        if( id == "no-visto") {
            ejemplar.visto_no = val
            ejemplar.modificado = date
            db.save()
        }
        
        if( id == "destetado") {
            ejemplar.destetado = val
            ejemplar.modificado = date
            db.save()
        }
        
        updateFecha()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
        if let ejemplar_id = ejemplar?.id_interno {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            let directorio:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let dibujo:URL = directorio.appendingPathComponent("d_\(ejemplar_id).png")
            
            if let image: UIImage = UIImage(contentsOfFile: dibujo.path) {
                self.fichaImagen.image = image
            }
            
            //Info Ejemplar
            por.text? = (ejemplar?.por) ?? "SI VES ESTO... ESTA MAL!"
            criador.text? = (ejemplar?.haras_texto) ?? "SI VES ESTO... ESTA MAL!"
            
            //Fotos
            let cantidadFotos = (ejemplar?.fotos)!
            if(cantidadFotos > 0) {
                
                for index in 1...cantidadFotos {
                    let foto:URL = directorio.appendingPathComponent("f_\(ejemplar_id)_\(index).png")
                    let image:UIImage = UIImage(contentsOfFile: foto.path)!
                    fotos.append(image)
                }
                
            }
            
            //Data Ficha
            updateFecha()
        }
        
    }
    
    func updateFecha(){
        if let fechaModificado = ejemplar.modificado  {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let dateString = dateFormatter.string(from: fechaModificado as Date)
            self.fechaModificadoLabel.text = dateString
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        scrollView.delegate = self
        scrollView.maximumZoomScale = 3
        
    }
    
    override func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.fichaImagen
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
        
        if segue.identifier == "ShowEditar" {
            let editarEjemplarTableViewController = segue.destination as! EditarEjemplarTableViewController
            editarEjemplarTableViewController.ejemplar = self.ejemplar
            editarEjemplarTableViewController.callBack = { nejemplar in
                self.ejemplar = nejemplar
            }
                
            
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ShowDibujo" {
            if ejemplar.muerto {
                
                let alert = UIAlertController(title: "Filiación", message: "El ejemplar está muerto", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return false
            }
        }
        
        return true
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
        //return dataSource.count

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
