//
//  VeterinarioCollectionViewCell.swift
//  SBAFiliacion
//
//  Created by Lukas on 12/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class VeterinarioCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imagen: UIImageView!
    
    public var veterinario:UIImage! {
        didSet {
            var context = CIContext(options: nil)
            imagen.image = veterinario
            imagen.layer.masksToBounds = true
            imagen.layer.cornerRadius = imagen.frame.size.width/2
            let currentFilter = CIFilter(name: "CIPhotoEffectMono")
            currentFilter!.setValue(CIImage(image: imagen.image!), forKey: kCIInputImageKey)
            let output = currentFilter!.outputImage
            let cgimg = context.createCGImage(output!,from: output!.extent)
            let processedImage = UIImage(cgImage: cgimg!)
            imagen.image = processedImage
        }
    }
}
