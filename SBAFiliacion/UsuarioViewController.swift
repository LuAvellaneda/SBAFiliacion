//
//  UsuarioViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 12/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class UsuarioViewController: UIViewController {

    @IBAction func salir(_ sender: UIBarButtonItem) {
        //dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLogin")
        self.navigationController?.navigationController?.popToRootViewController(animated: true)
    }
    
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
