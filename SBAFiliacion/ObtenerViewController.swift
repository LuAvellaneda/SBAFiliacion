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
        
        dataSource.forEach { (info) in
            let ejemplar = Ejemplar(context: db.context)
            ejemplar.nombre = info["nombre"] as? String
            ejemplar.sexo = info["sexo"] as? String
            ejemplar.id = info["id"] as! Int32
            db.save()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]["nombre"] as? String
        cell.detailTextLabel?.text = dataSource[indexPath.row]["sexo"] as? String
        return cell
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
        
        //nota.alpha = 0
        
        
        let url = URL(string: "http://localhost/sbafiliacion/ejemplares.json")!
        URLCache.shared.removeAllCachedResponses()
        
        //if let url = URL(string: "http://localhost/intest/public/sba/ejemplar/exportar") {
        //if let url = URL(string: "http://192.168.1.22/intest/public/sba/ejemplar/exportar") {
        
        Alamofire.request(url).responseJSON { (response) in
            
            if let result = response.result.value {
                
                let json = result as! Dictionary<String,Any>
                
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
