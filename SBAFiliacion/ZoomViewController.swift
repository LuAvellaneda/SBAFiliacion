//
//  ZoomViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 17/03/2019.
//  Copyright © 2019 Lucas Avellaneda. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            
            imageView.image = uiImage!
        }
    }
    
    var uiImage:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
