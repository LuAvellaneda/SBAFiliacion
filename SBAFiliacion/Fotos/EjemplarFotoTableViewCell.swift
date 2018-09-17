//
//  EjemplarFotoTableViewCell.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 15/9/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class EjemplarFotoTableViewCell: UITableViewCell {
    
    var fotos = [UIImage]() {
        didSet {
            collectionView.reloadData()
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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    

}

extension EjemplarFotoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! EjemplarFotoCollectionViewCell
        
        cell.caballo = fotos[indexPath.row]
        
        return cell
    }
    
}
