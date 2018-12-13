//
//  LoginViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 12/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let veterinarios =  ["2641","4408","6176","6876","7264","57119"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //performSegue(withIdentifier: "logged", sender: self)
    }
    
    @IBOutlet weak var veterinariosCollectionView: UICollectionView!
    @IBAction func loginButton(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "userLogin")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return veterinarios.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VeterinarioCollectionViewCell
        let veterinario_img = UIImage(named: veterinarios[indexPath.row])
        cell.veterinario = veterinario_img
    
        return cell
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
