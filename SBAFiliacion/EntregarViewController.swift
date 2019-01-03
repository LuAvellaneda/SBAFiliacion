//
//  EntregarViewController.swift
//  SBAFiliacion
//
//  Created by Lukas on 02/01/2019.
//  Copyright © 2019 Lucas Avellaneda. All rights reserved.
//

import UIKit
import Alamofire

class EntregarViewController: UIViewController {
    
    let db:PersistenceManager = PersistenceManager.shared
    let url_save:String = "http://myproject.com.ar/jc/save.php"
    var ejemplares:[Ejemplar] = [Ejemplar]()
    var index = 0
    

    @IBAction func subirButton(_ sender: UIButton) {
        print("Iniciar")
        index = 0
        subirEjemplar(for: index)
        
    }
    
    func subirEjemplar(for index:Int){
        
        let ejemplar:Ejemplar = ejemplares[index]
        
        let params:Parameters = ["nombre":ejemplar.nombre!]
        let directorio:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //let dibujo:URL = directorio.appendingPathComponent("t_\(ejemplar.id_interno!)_trazo.png")
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            let fileURL:URL = directorio.appendingPathComponent("t_\(ejemplar.id_interno!)_trazo.png")
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                multipartFormData.append(fileURL , withName: "image")
            }
            
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
                        //debugPrint(response)
                        print(index)
                        if ( self.ejemplares.count > ( self.index + 1 )) {
                            self.index = self.index + 1
                            self.subirEjemplar(for: self.index)
                        } else {
                            let alert = UIAlertController(title: "Terminado", message: "Se entregaron todos los trabajos", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
                            
                            self.present(alert, animated: true)
                        }
                        
                        
                    }
                    upload.uploadProgress(closure: { //Get Progress
                        progress in
                        //print(progress.fractionCompleted)
                    })
                case .failure(let encodingError):
                    //print(encodingError)
                    print("error")
                }
        })
 
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Cargo los ejemplares
        ejemplares = db.fetch(Ejemplar.self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
