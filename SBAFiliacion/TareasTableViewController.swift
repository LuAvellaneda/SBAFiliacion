//
//  TareasTableViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 23/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class TareasTableViewController: UITableViewController {
    
    let db:PersistenceManager = PersistenceManager.shared
    var dataSource = [Tarea]() {
        didSet {
            dataSource.sort(by: { (first: Tarea, second: Tarea) -> Bool in
                first.titulo! < second.titulo!
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = db.fetch(Tarea.self)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "actualizarTareas"), object: nil, queue: OperationQueue.main) { (notification) in
            self.dataSource = self.db.fetch(Tarea.self)
            self.tableView.reloadData()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showLugaresSegue", sender: self)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ubicaciones:[Ubicacion] = self.dataSource[indexPath.row].ubicacion?.allObjects as! [Ubicacion]
        
        var lugares = [String]()
        ubicaciones.forEach { (ubicacion) in
            lugares.append(ubicacion.titulo ?? "Sin data")
        }
        
        let lugares_string = lugares.joined(separator: " - ")
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(self.dataSource[indexPath.row].titulo!)"
            cell.detailTextLabel?.text = "\(lugares_string)  (\(self.dataSource[indexPath.row].fecha!)) - \(self.dataSource[indexPath.row].total.description) ejemplares"
            return cell
        
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showLugaresSegue" {
            
            if let vc = segue.destination as? LugaresTableViewController {
                let indexPath = tableView.indexPathForSelectedRow!
                let tarea = dataSource[indexPath.row]
                let ubicacion = tarea.ubicacion
                let ubicaciones:[Ubicacion] = ubicacion?.allObjects as! [Ubicacion]
                vc.lugares = ubicaciones
                vc.tarea = tarea
            }
            
        }
        
    }
    

}
