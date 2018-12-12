//
//  LoginViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 12/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //performSegue(withIdentifier: "logged", sender: self)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "userLogin")
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
