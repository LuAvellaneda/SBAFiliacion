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

class EjemplaresTableViewController: UITableViewController {
    
    @IBAction func organizarButton(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
    }
    
    var secciones = [String]()
    let db: PersistenceManager
    var dibujo:URL?
    var revisar = [Ejemplar]()
    var revisados = [Ejemplar]()
    var dataSource = [Ejemplar]() {
        didSet {
            
            dataSource.sort(by: { (first: Ejemplar, second: Ejemplar) -> Bool in
                first.orden < second.orden
            })
            
            
            revisar = dataSource.filter { ejemplar -> Bool in
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! EjemplaresTableViewCell
        
        var data:Ejemplar!
        if(indexPath.section == 0) {
            data = revisar[indexPath.row]
        } else {
            data = revisados[indexPath.row]
        }
        
        cell.sexo = data.sexo_id ?? ""
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EjemplaresTableViewCell
        
        if(indexPath.section == 0) {
            
            if revisar.count == 0 {
                //cell = tableView.dequeueReusableCell(withIdentifier: "cellTerminado", for: indexPath) as!
                //cell.textLabel?.text = "TERMINADO"
            } else {
                
                let data = revisar[indexPath.row]
                
                cell.ejemplarLabel?.text = "\(data.nombre!) ( \(data.anio!) / \(data.pelo!) ) "
                cell.lugarLabel?.text = data.lugar_lugar
                cell.tipoLabel?.text = data.lugar_tipo
                cell.correLabel?.text = data.corre ?? "no"
                cell.cuidador?.text = data.lugar_cuidador
                
                
                var estados = [String]()
                
                
                if(data.muerto){
                    estados.append("Muerto")
                }
                
                if(data.destetado){
                    estados.append("Destetado")
                }
                
                if(data.visto_no){
                    estados.append("No visto")
                }
                
                if(data.sin_pasaporte){
                    estados.append("Sin pasaporte")
                }
                
                if(data.sin_denuncia){
                    estados.append("Sin denuncia")
                }
                
                if((data.nota) != nil){
                    estados.append("Nota")
                }
                cell.estados = estados
                
                
            }
            
        } else {
            
            let data = revisados[indexPath.row]
            cell.ejemplarLabel?.text = "\(data.nombre!) - ( \(data.anio!), \(data.pelo!) ) "
            cell.lugarLabel?.text = data.lugar_lugar
            cell.tipoLabel?.text = data.lugar_tipo
            cell.correLabel?.text = data.corre ?? "no"
            cell.cuidador?.text = data.lugar_cuidador
            
        }
        
        
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    /*
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // 1
        let shareAction = UITableViewRowAction(style: .destructive, title: "Ver" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
        })
        // 3
        let rateAction = UITableViewRowAction(style: .default, title: "Revisar" , handler: { (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
            
        })
        // 5
        return [shareAction,rateAction]
    }
    */
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let ver = verAction(at: indexPath)
        let revisar = paraRevisar(at: indexPath)
        return UISwipeActionsConfiguration(actions: [ver,revisar])
    }
    
    func verAction(at indexPath: IndexPath) ->UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Imagen") { (action, view, completion) in
            completion(true)
            
            var data:Ejemplar!
            if indexPath.section == 0 {
                data = self.revisar[indexPath.row]
            } else {
                data = self.revisados[indexPath.row]
            }
            
           
            
            
            let directorio:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            self.dibujo = directorio.appendingPathComponent("d_\(data.id_interno!).png")
       
            self.performSegue(withIdentifier: "zoom", sender: self)
            
            //self.performSegue(withIdentifier: "zoom", sender: self)
        }
        
        action.backgroundColor = .magenta
        return action
    }
    
    func paraRevisar(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Revisar") { (action, view, completion) in
            completion(true)
        }
        
        action.backgroundColor = .orange
        return action
    }
    
    /*
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
    */

    
    /*
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    */
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let movedObject = self.revisar[fromIndexPath.row]
        revisar.remove(at: fromIndexPath.row)
        revisar.insert(movedObject, at: to.row)
        
        var pos:Int16 = 1;
        revisar.forEach { (ejemplar) in
            ejemplar.orden = pos
            pos+=1
            
            
        }
        
        db.save()
        
    }

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        if (indexPath.section == 0) {
            return true
        }
        return false
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            var row = 0
            if sourceIndexPath.section < proposedDestinationIndexPath.section {
                row = self.tableView(tableView, numberOfRowsInSection: sourceIndexPath.section) - 1
            }
            return IndexPath(row: row, section: sourceIndexPath.section)
        }
        return proposedDestinationIndexPath
    }
    
    
    
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
            //if let vc = segue.destination.children[0] as? EjemplarTableViewController {
            if let vc = segue.destination as? EjemplarTableViewController {
                vc.ejemplar = ejemplarSeleccionado
            }
        }
        
        if segue.identifier == "goNuevo" {
            if let vc = segue.destination as? NuevoEjemplarTableViewController {
                vc.ubicacion = ubicacion
            }
        }
        
        if segue.identifier == "zoom" {
            
            
            //if let navigation = segue.destination as? UINavigationController {
                if let vc = segue.destination as? ZoomViewController {
                    
                    let path:String = (self.dibujo?.path)!
                    
                    
                    if let image: UIImage = UIImage(contentsOfFile: path) {
                        vc.uiImage = image
                    }
                    
                }
            //}
            
            /*
            if let vc = segue.destination as? ZoomViewController {
                
                let path:String = (self.dibujo?.path)!
                
                if let image: UIImage = UIImage(contentsOfFile: path) {
                    
                    vc.uiImage = image
                }
                
            }
                */
        }
        
    }
    

}


