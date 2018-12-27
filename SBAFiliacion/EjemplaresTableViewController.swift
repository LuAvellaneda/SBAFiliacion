//
//  EjemplaresTableViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 18/8/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit
import AVFoundation

import Alamofire

class EjemplaresTableViewController: UITableViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    @IBAction func salir(_ sender : UIStoryboardSegue) {
        print("salir")
    }
    
    @IBAction func openScan (_ sender: UIBarButtonItem) {
        
        
        
        /*
        let url_save:String = "http://myproject.com.ar/jc/save.php";
        let params:Parameters = ["nombre":"Lucas","apellido":"Avellaneda"]
        //let fileURL = Bundle.main.url(forResource: "ficha", withExtension: "jpg")!
        
        let ejemplares: [Ejemplar] = db.fetch(Ejemplar.self)
        
        let ejemplar = ejemplares[0]
        
        let directorio:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dibujo:URL = directorio.appendingPathComponent("dibujo_\(ejemplar.id)_trazo.png")
        
       let fileURL = dibujo
       
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(fileURL , withName: "image")
            for (key, value) in params
            {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
        },
        to: url_save,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                }
                upload.uploadProgress(closure: { //Get Progress
                    progress in
                    print(progress.fractionCompleted)
                })
            case .failure(let encodingError):
                print("Error")
                //print(encodingError)
            }
        })
 
        */

        
    }
    
    
    
    enum error:Error {
        case noCameraAvailable
        case videoInputInitFail
    }
    
    let db: PersistenceManager
    var dataSource = [Ejemplar]() {
        didSet {
            dataSource.sort(by: { (first: Ejemplar, second: Ejemplar) -> Bool in
                first.nombre! < second.nombre!
            })
        }
    }
    var ubicacion: Ubicacion?
    var ejemplarSeleccionado: Ejemplar?
    
    required init?(coder aDecoder: NSCoder) {
        db = PersistenceManager.shared
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            let lectura = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if lectura.type == AVMetadataObject.ObjectType.code128 {
                let valor = lectura.stringValue!
                print(valor)
                
            }
        }
    }
    
    func scanCode() throws {
        let session = AVCaptureSession()
        
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("no camera")
            throw error.noCameraAvailable
        }
        
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else {
            throw error.videoInputInitFail
        }
        
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        session.addInput(avCaptureInput)
        session.addOutput(avCaptureMetadataOutput)
        
        avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.code128]
        
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        //avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avCaptureVideoPreviewLayer.frame = view.bounds
        view.layer.addSublayer(avCaptureVideoPreviewLayer)
        
        session.startRunning()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = dataSource[indexPath.row].nombre
        cell.detailTextLabel?.text = dataSource[indexPath.row].madre
        //cell.backgroundColor = UIColor.green
        

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            db.delete(dataSource[indexPath.row])
            dataSource.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let tarea = dataSource[indexPath.row]
        
        
        ejemplarSeleccionado = dataSource[indexPath.row]
        performSegue(withIdentifier: "ShowFicha", sender: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFicha" {
            
           
            
            //segue.destination.performSegue(withIdentifier: "showMaster", sender: self)
            
            //let fichaViewController = segue.destination as! FichaViewController
            //fichaViewController.ejemplar = ejemplarSeleccionado
            if let vc = segue.destination.children[0] as? EjemplarTableViewController {
                vc.ejemplar = ejemplarSeleccionado
            }
        }
        
        if segue.identifier == "goNuevo" {
            if let vc = segue.destination as? NuevoEjemplarTableViewController {
                vc.ubicacion = ubicacion
            }
        }
        
    }
    

}


