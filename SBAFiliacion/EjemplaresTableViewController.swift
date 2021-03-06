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
    
    var secciones = [String]()
    let db: PersistenceManager
    var revisar = [Ejemplar]()
    var revisados = [Ejemplar]()
    var dataSource = [Ejemplar]() {
        didSet {
            
            dataSource.sort(by: { (first: Ejemplar, second: Ejemplar) -> Bool in
                first.nombre! < second.nombre!
            })
            
            revisar = dataSource.filter { (ejemplar) -> Bool in
                !ejemplar.visto
            }
            
            revisados = dataSource.filter { ejemplar -> Bool in
                ejemplar.visto
            }
            
            secciones = [String]()
            
            secciones.append("Revisar")
            
            if(revisados.count > 0) {
                secciones.append("Revisados")
            }
           
            
        }
    }
    var ubicacion: Ubicacion? {
        didSet {
            navigationItem.prompt = ubicacion?.titulo
        }
    }
    var ejemplarSeleccionado: Ejemplar?
    
    required init?(coder aDecoder: NSCoder) {
        db = PersistenceManager.shared
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "actualizarListadoEjemplares"), object: nil, queue: OperationQueue.main) { (notification) in
            self.dataSource = self.revisados + self.revisar
            self.tableView.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return secciones.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secciones[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(section == 0) {
            
            if revisar.count == 0 {
                return 1
            } else {
                return revisar.count
            }
            
        } else {
            
            return revisados.count
            
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if(indexPath.section == 0) {
            
            if revisar.count == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "cellTerminado", for: indexPath)
                cell.textLabel?.text = "TERMINADO"
            } else {
                let data = revisar[indexPath.row]
                cell.textLabel?.text = "\(data.nombre!)"
                cell.detailTextLabel?.text = data.madre
            }
            
        } else {
            let data = revisados[indexPath.row]
            cell.textLabel?.text = "\(data.nombre!)"
            cell.detailTextLabel?.text = data.madre
        }
        
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
        var ejempar: Ejemplar?
        
        if (indexPath.section == 0) {
            ejempar = revisar[indexPath.row]
        } else {
            ejempar = revisados[indexPath.row]
        }
        
        ejemplarSeleccionado = ejempar
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


