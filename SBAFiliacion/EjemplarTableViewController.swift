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

class EjemplarTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ficha", for: indexPath) as! EjemplarFichaTableViewCell
            
            return cell
            
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "fotos", for: indexPath) as! EjemplarFotoTableViewCell
            
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
       
        if indexPath.row == 0 {
            if let cell = cell as? EjemplarFichaTableViewCell {
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                cell.collectionView.reloadData()
                //cell.collectionView.isScrollEnabled = false
                
            }
        }
        
        if indexPath.row == 1 {
            if let cell = cell as? EjemplarFotoTableViewCell {
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                cell.collectionView.reloadData()
                //cell.collectionView.isScrollEnabled = false
                
            }
        }
    }
    
    
    
    
    
    
    var ejemplar: Ejemplar? {
        didSet {
            let ejemplar_id = ejemplar?.id
            navigationItem.title = ejemplar?.nombre
            
            dataSource.append(FichaDetalle("Nombre", ejemplar?.nombre))
            dataSource.append(FichaDetalle("Sexo", ejemplar?.sexo))
            dataSource.append(FichaDetalle("Pelo", "Zaino"))
            
        }
    }
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
        
        /*
        if let ejemplar_id = ejemplar?.id {
            let directorio:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let dibujo:URL = directorio.appendingPathComponent("dibujo_\(ejemplar_id).png")
            
            if let image: UIImage = UIImage(contentsOfFile: dibujo.path) {
                self.fichaImage.image = image
            }
            fichaTableView.reloadData()
        }
 */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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



extension EjemplarTableViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! EjemplarFichaCollectionViewCell
        
        //let shoes = Shoe.fetchShoes()
        //cell.image = shoes[indexPath.item].images?.first
        cell.info = "Pelo"
        
        
        return cell
    }
    
}


/*

extension EjemplarTableViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 2.5
        let itemWidth = (collectionView.bounds.width - 5.0) / 2.0
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
*/





