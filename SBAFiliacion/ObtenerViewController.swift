//
//  ObtenerViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 13/8/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit
import Alamofire



class ObtenerViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var db: PersistenceManager
    var dataSource = [[String:Any]]()
    var dataSourceTareas = [[String:Any]]()
    var dataSourceEjemplares = [[String:Any]]()
    var indiceActual = 0
    
    required init?(coder aDecoder: NSCoder) {
        self.db = PersistenceManager.shared
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var obtenerBtn: UIButton!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var nota: UITextView!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var veterinarioImg: UIImageView! {
        didSet {
            veterinarioImg.layer.cornerRadius = veterinarioImg.frame.size.width/2
            veterinarioImg.clipsToBounds = true
        }
    }
    
    @IBAction func Obtener() {
        
        /*
        guardarData(indiceActual)
        */
        
    
        
        dataSource.forEach { (info) in
            let ejemplar = Ejemplar(context: db.context)
            ejemplar.nombre = info["nombre"] as? String
            
            ejemplar.por = info["por"] as? String
            ejemplar.fotos = 0
            ejemplar.id = info["id"] as! Int32
            db.save()
        }
        
    }
    
    func guardarData(_ posicion: Int) {
        
        /*
        // DATA JSON
        let info = dataSource[posicion]
        let nombre = info["nombre"] as? String
        
        // VER SI NECESITA BAJAR DATA
        
        let url = URL(string: "https://hdqwalls.com/wallpapers/imac-pro-5k-ad.jpg")!
        
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        Alamofire.download(url, to: destination).response { response in
            
            if response.error == nil, let imagePath = response.destinationURL?.path {
                print(imagePath)
            }
            
            print(response.error)
        }
        */
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceTareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TareaTableViewCell
        
        cell.tituloLabel.text = dataSourceTareas[indexPath.row]["titulo"] as? String
        cell.descripcionLabel.text = dataSourceTareas[indexPath.row]["descripcion"] as? String
        
        
        //cell.textLabel?.text = dataSourceTareas[indexPath.row]["titulo"] as? String
        //cell.detailTextLabel?.text = dataSourceTareas[indexPath.row]["descripcion"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tarea = dataSourceTareas[indexPath.row]
        let lugar = (tarea["lugar"] as! [[String:Any]]).first!
        let ejemplares = lugar["ejemplares"] as! [[String:Any]]
        dataSourceEjemplares = ejemplares
        performSegue(withIdentifier: "showEjemplaresSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        super.viewDidAppear(animated)
        print("viewDidApper")
        self.view.layoutIfNeeded()
        
        //let url = URL(string: "http://localhost/sbafiliacion/ejemplares.json")!
        let url = URL(string: "http://myproject.com.ar/jc/ejemplares.json")!
        URLCache.shared.removeAllCachedResponses()
        
        
        let parameters: Parameters = ["veterinario_id": 1]
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (response) in
            
            if let result = response.result.value {
                
                let json = result as! Dictionary<String,Any>
                
                let tarea = json["tarea"] as! [[String : Any]]
                
                self.dataSourceTareas = tarea
                self.tableView.reloadData()
                /*
                tarea.forEach{ (info) in
                    print(info)
                }
                */
                
                /*
                let total = json["ejemplares_cantidad"] as! Int32
                
                if(total == 0) {
                    
                    self.titulo.text = "Sin asignación"
                    self.fecha.text = nil
                    self.nota.text = nil
                    self.obtenerBtn.setTitle("\(total)", for: .normal)
                    
                } else {
                
                    self.titulo.text = json["titulo"] as? String
                    self.fecha.text = json["fecha"] as? String
                    self.nota.text = json["nota"] as? String
                    
                    self.obtenerBtn.setTitle("\(total)", for: .normal)
                    
                    self.dataSource = json["ejemplares"] as! [[String:Any]]
                    self.tableView.reloadData()
                }
                */
                
                /*
                UIView.animate(withDuration: 5, animations: {
                    self.nota.alpha = 1
                })
                */
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showEjemplaresSegue" {
            let nc = segue.destination as! UINavigationController
            let vc = nc.viewControllers.first as! ObtenerDetalleTableViewController
            
            vc.dataSource = dataSourceEjemplares
        }
    }

}
