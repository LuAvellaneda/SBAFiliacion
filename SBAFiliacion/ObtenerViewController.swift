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
        
        dataSourceTareas.forEach { (info) in
            
            let tarea = Tarea(context: db.context)
            tarea.id = info["id"] as! Int64
            tarea.titulo = info["titulo"] as? String
            tarea.descripcion = info["descripcion"] as? String
            tarea.fecha = info["fecha"] as? String
            
            let lugares: [[String:Any]] = info["lugar"] as! [[String : Any]]
            
            lugares.forEach({ (lugar) in
                let ubicacion = Ubicacion(context: db.context)
                ubicacion.id = lugar["id"] as! Int64
                ubicacion.titulo = lugar["titulo"] as? String
                tarea.addToUbicacion(ubicacion)
                
                let ejemplares = lugar["ejemplares"] as! [[String: Any]]
                
                ejemplares.forEach({ (ejemplar) in
                    let _ejemplar = Ejemplar(context: db.context)
                    _ejemplar.id = ejemplar["id"] as! Int64
                    _ejemplar.nombre = ejemplar["nombre"] as? String
                    _ejemplar.anio = ejemplar["anio"] as? String
                    _ejemplar.mes = ejemplar["mes"] as? String
                    _ejemplar.dia = ejemplar["dia"] as? String
                    _ejemplar.sexo = ejemplar["sexo"] as? String
                    _ejemplar.por = ejemplar["por"] as? String
                    _ejemplar.padre = ejemplar["padre"] as? String
                    _ejemplar.madre = ejemplar["madre"] as? String
                    _ejemplar.microchip = ejemplar["microchip"] as! Int64
                    _ejemplar.pelo = ejemplar["pelo"] as? String
                    _ejemplar.id_interno = UUID().uuidString
                    _ejemplar.muerto = false
                    _ejemplar.haras_texto = ejemplar["haras_nacimiento"] as? String
                    ubicacion.addToEjemplar(_ejemplar)
                })
                
            })
            
            db.save()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "actualizarTareas"), object: self)
            
            let alert = UIAlertController(title: "Trabajos", message: "Se obtuvieron todos los trabajos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
            
            dataSourceTareas = []
            tableView.reloadData()
            self.obtenerBtn.setTitle("", for: .normal)
            
            self.present(alert, animated: true)
            
        }
        
        
        /*
        dataSource.forEach { (info) in
            let ejemplar = Ejemplar(context: db.context)
            ejemplar.nombre = info["nombre"] as? String
            
            ejemplar.por = info["por"] as? String
            ejemplar.fotos = 0
            ejemplar.id = info["id"] as! Int32
            db.save()
        }
         */
        
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
        cell.fechaLabel.text = dataSourceTareas[indexPath.row]["fecha"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let tarea = dataSourceTareas[indexPath.row]
        let lugar = (tarea["lugar"] as! [[String:Any]]).first!
        let ejemplares = lugar["ejemplares"] as! [[String:Any]]
        dataSourceEjemplares = ejemplares
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        performSegue(withIdentifier: "showEjemplaresSegue", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        super.viewDidAppear(animated)
        
        //let url = URL(string: "http://localhost/sbafiliacion/ejemplares.json")!
        
        let url = URL(string: "http://myproject.com.ar/jc/ejemplares.json")!
        //let url = URL(string: "http://192.168.0.105/tablet-exportacion")!
        URLCache.shared.removeAllCachedResponses()
        
        let veterinario_id = UserDefaults.standard.integer(forKey: "veterinario_id")
        
        let parameters: Parameters = ["veterinario_id": veterinario_id]
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            
            print(response)
            if let result = response.result.value {
                
                let json = result as! Dictionary<String,Any>
                
                
                
                let tarea = json["tarea"] as! [[String : Any]]
                
                self.dataSourceTareas = tarea
                self.tableView.reloadData()
                
                self.obtenerBtn.setTitle("\(self.dataSourceTareas.count)", for: .normal)
                
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
            let tarea = dataSourceTareas[(tableView.indexPathForSelectedRow?.row)!]
            vc.titulo = tarea["titulo"] as? String
        }
    }

}
