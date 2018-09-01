//
//  FichaViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 20/8/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit


struct FichaDetalle{
    var label: String?
    var value: String?
    
    init(_ label:String?, _ value:String?) {
        self.label = label
        self.value = value
    }
}

class FichaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].label
        cell.detailTextLabel?.text = dataSource[indexPath.row].value
        return cell
    }
    
    
    var ejemplar: Ejemplar!
    var dataSource = [FichaDetalle]()
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var fichaTableView: UITableView!
    
    @IBOutlet weak var fichaImage: UIImageView!
    
    @IBAction func abrirCamara(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ejemplar_id = ejemplar.id
        let directorio:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dibujo:URL = directorio.appendingPathComponent("dibujo_\(ejemplar_id).png")
        
        if let image: UIImage = UIImage(contentsOfFile: dibujo.path) {
            self.fichaImage.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let ejemplar_id = ejemplar.id
        navigationItem.title = ejemplar?.nombre
        
        dataSource.append(FichaDetalle("Nombre", ejemplar.nombre))
        dataSource.append(FichaDetalle("Sexo", ejemplar.sexo))
        dataSource.append(FichaDetalle("Pelo", "Zaino"))
        fichaTableView.reloadData()
        //let items = self.tabBarController?.tabBar.items
        //items![1].badgeValue = "2"
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.fichaImage.image = image
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDibujo" {
            let dibujoViewController = segue.destination as! DibujoViewController
            dibujoViewController.ejemplar = self.ejemplar
        }
        
    }
    
    
    

}
