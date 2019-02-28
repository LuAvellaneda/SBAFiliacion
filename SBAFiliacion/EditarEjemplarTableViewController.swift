//
//  NuevoEjemplarTableViewController.swift
//  SBAFiliacion
//
//  Created by Lukas on 14/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class EditarEjemplarTableViewController: UITableViewController {
    
    let db:PersistenceManager = PersistenceManager.shared
    
    let dataSourceRaza: [(nombre:String, value:Int)] = [("Anglo Arabe",2), ("Arabe Puro",3),("Sangre Pura Carrera",4)]
    let dataSourceSexo: [(nombre:String, value:Int)] = [("Macho",1), ("Hembra",2)]
    let dataSourcePelo: [(nombre:String, value:Int)] = [("Alazan",7),("Alazan o Tordillo",3),("Alazan Tostado",2),("Moro",13),("No Consigna",14),("Oscuro",8),("Rosillo",11),("Ruano",15),("Tordillo",9),("Zaino",1),("Zaino Colorado",4),("Zaino Doradillo",6),("Zaino Negro",5),("Zaino o Tordillo",10)]
    
    
    @IBOutlet weak var raza: UIPickerView!
    @IBOutlet weak var sexo: UIPickerView!
    @IBOutlet weak var pelo: UIPickerView!
    @IBOutlet weak var nacimiento: UIDatePicker!
    @IBOutlet weak var nota: UITextView!
    
    public var ejemplar: Ejemplar?
    var callBack: ((_ ejemplar:Ejemplar)->())?
    
    @IBAction func guardar(_ sender: UIBarButtonItem) {
        
        ejemplar?.pelo = dataSourcePelo[pelo.selectedRow(inComponent: 0)].nombre
        ejemplar?.sexo = dataSourceSexo[sexo.selectedRow(inComponent: 0)].nombre
        ejemplar?.raza = dataSourceRaza[raza.selectedRow(inComponent: 0)].nombre
        ejemplar?.nota = nota.text!
        
        db.save()
        
        callBack?(ejemplar!)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    /*
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
        ejemplar.microchip = Int64(microchip.text!) ?? 0
        ejemplar.sexo = dataSourceSexo[sexo.selectedRow(inComponent: 0)].nombre
        ejemplar.pelo = dataSourcePelo[pelo.selectedRow(inComponent: 0)].nombre
        ejemplar.nota = nota.text!
        ejemplar.anio = year.description
        ejemplar.mes = month.description
        ejemplar.dia = day.description
        ejemplar.fotos = 0
        ejemplar.id = 0
        ejemplar.visto = false
        ejemplar.id_interno = UUID().uuidString
        
        ubicacion?.addToEjemplar(ejemplar)
        db.save()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "actualizarListadoEjemplares"), object: self)
        self.navigationController?.popViewController(animated: true)
        
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let peloEjemplar = ejemplar?.pelo
        if let index = dataSourcePelo.firstIndex(where: { $0.nombre == peloEjemplar }) {
            pelo.selectRow(index, inComponent: 0, animated: true)
        }
        
        let sexoEjemplar = ejemplar?.sexo
        if let index = dataSourceSexo.firstIndex(where: { $0.nombre == sexoEjemplar }) {
            sexo.selectRow(index, inComponent: 0, animated: true)
        }
        
        let razaEjemplar = ejemplar?.raza
        if let index = dataSourceRaza.firstIndex(where: { $0.nombre == razaEjemplar }) {
            raza.selectRow(index, inComponent: 0, animated: true)
        }
        
        nota.text = ejemplar?.nota

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source
    

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


extension EditarEjemplarTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        
        if(pickerView == raza){
            return dataSourceRaza.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if(pickerView == sexo){
            let info = dataSourceSexo[row] as (nombre:String,value:Int)
            return info.nombre
        }
        
        if(pickerView == pelo){
            let info = dataSourcePelo[row] as (nombre:String,value:Int)
            return info.nombre
        }
        
        if(pickerView == raza){
            let info = dataSourceRaza[row] as (nombre:String,value:Int)
            return info.nombre
        }
        
        return nil
        
    }
    
    
}
