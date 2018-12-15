//
//  HarasFiltrosTableViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 13/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

struct HarasStruct {
    let id: Int32
    let name:String?
    let zone:String?
}

class HarasFiltrosTableViewController: UITableViewController {
    
    var data = [HarasStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        data.append(HarasStruct.init(id: 1, name: "Suli", zone: "Zona 1"))
        data.append(HarasStruct.init(id: 2, name: "Don Vicente", zone: "Zona 1"))
        data.append(HarasStruct.init(id: 3, name: "Mi Anhelo", zone: "Zona 1"))
        data.append(HarasStruct.init(id: 4, name: "Don Danilo", zone: "Zona 1"))
        data.append(HarasStruct.init(id: 5, name: "Altos de Godeken", zone: "Zona 1"))
        data.append(HarasStruct.init(id: 6, name: "Carlos Julio", zone: "Zona 1"))
        data.append(HarasStruct.init(id: 7, name: "El Galisteo", zone: "Zona 1"))
        data.append(HarasStruct.init(id: 8, name: "La Olimpia", zone: "Zona 1"))
        data.append(HarasStruct.init(id: 9, name: "Presidente Roca", zone: "Zona 1"))
        data.append(HarasStruct.init(id: 10, name: "Imperial", zone: "Zona 1"))
        
        navigationItem.title = "Haras"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let info = data[indexPath.row] as HarasStruct
        cell.detailTextLabel?.text = info.zone
        cell.textLabel?.text = info.name
        
        return cell
    }
    
    // MARK: - Table view actions
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(self.presentedViewController)
        //performSegue(withIdentifier: "salir", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EjemplaresTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let info = data [indexPath.row]
            destinationVC.porHaras = info.name
            
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
