//
//  NuevoEjemplarTableViewController.swift
//  SBAFiliacion
//
//  Created by Lukas on 14/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class NuevoEjemplarTableViewController: UITableViewController {
    
    let db:PersistenceManager = PersistenceManager.shared
    
    
    let dataSourceSexo: [(nombre:String, value:String)] = [("Macho","M"), ("Hembra","H")]
    let dataSourcePelo: [(nombre:String, value:Int16)] = [("Alazan",7),("Alazan o Tordillo",3),("Alazan Tostado",2),("Moro",13),("No Consigna",14),("Oscuro",8),("Rosillo",11),("Ruano",15),("Tordillo",9),("Zaino",1),("Zaino Colorado",4),("Zaino Doradillo",6),("Zaino Negro",5),("Zaino o Tordillo",10)]
    
    
    @IBOutlet weak var fecha: UIDatePicker!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var padre: UITextField!
    @IBOutlet weak var madre: UITextField!
    @IBOutlet weak var microchip: UITextField!
    @IBOutlet weak var sexo: UIPickerView!
    @IBOutlet weak var pelo: UIPickerView!
    @IBOutlet weak var nota: UITextView!
    
    public var ubicacion: Ubicacion?
    
    @IBAction func guardar(_ sender: UIBarButtonItem) {
        
        let date: Date = fecha.date
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day,from: date)
        
        let ejemplar = Ejemplar(context: db.context)
        ejemplar.manual = true
        ejemplar.nombre = nombre.text!
        ejemplar.padre = padre.text!
        ejemplar.madre = madre.text!
        //ejemplar.microchip = Int64(microchip.text!) ?? 0
        ejemplar.sexo = dataSourceSexo[sexo.selectedRow(inComponent: 0)].nombre
        ejemplar.sexo_id = dataSourceSexo[sexo.selectedRow(inComponent: 0)].value
        ejemplar.pelo = dataSourcePelo[pelo.selectedRow(inComponent: 0)].nombre
        ejemplar.pelo_id = dataSourcePelo[pelo.selectedRow(inComponent: 0)].value
        ejemplar.nota = nota.text!
        ejemplar.anio = year.description
        ejemplar.mes = month.description
        ejemplar.dia = day.description
        //ejemplar.fotos = 0
        ejemplar.id = 0
        ejemplar.visto = false
        ejemplar.id_interno = UUID().uuidString
        
        ubicacion?.addToEjemplar(ejemplar)
        db.save()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "actualizarListadoEjemplares"), object: self)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 8
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

extension NuevoEjemplarTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView == sexo){
            return dataSourceSexo.count
        }
        
        if(pickerView == pelo){
            return dataSourcePelo.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if(pickerView == sexo){
            let info = dataSourceSexo[row] as (nombre:String,value:String)
            return info.nombre
        }
        
        if(pickerView == pelo){
            let info = dataSourcePelo[row] as (nombre:String,value:Int16)
            return info.nombre
        }
        
        return nil
        
    }
    
    
}
