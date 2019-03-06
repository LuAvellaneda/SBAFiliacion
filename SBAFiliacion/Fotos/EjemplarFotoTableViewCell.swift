//
//  EjemplarFotoTableViewCell.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 15/9/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

struct Posicion {
    var id: Int
    var nombre: String
}

class EjemplarFotoTableViewCell: UITableViewCell {
    
    var callBackCamera: ((_ id:Int)->())?
    var posiciones = [Posicion]()
    
    
    var fotos = [UIImage]() {
        didSet {
            //collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self as UICollectionViewDataSource
            collectionView.delegate = self as UICollectionViewDelegate
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posiciones.append(Posicion(id: 1, nombre: "Cabeza"))
        posiciones.append(Posicion(id: 2, nombre: "Costado izquierdo"))
        posiciones.append(Posicion(id: 3, nombre: "Costado derecho"))
        posiciones.append(Posicion(id: 4, nombre: "Pat. delantera izquierda"))
        posiciones.append(Posicion(id: 5, nombre: "Pat. delantera derecha"))
        posiciones.append(Posicion(id: 6, nombre: "Pat. trasera izquierda"))
        posiciones.append(Posicion(id: 7, nombre: "Pat. trasera derecha"))
        
        collectionView.reloadData()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    

}

extension EjemplarFotoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posiciones.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! EjemplarFotoCollectionViewCell
        
        
        //cell.caballo = fotos[indexPath.row]
        cell.posicionLabel?.text = posiciones[indexPath.row].nombre
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let posicion = posiciones[indexPath.row]
        callBackCamera?(posicion.id)
    }
    
}
