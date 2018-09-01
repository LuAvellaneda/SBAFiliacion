//
//  ViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 4/8/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var db: PersistenceManager
    required init?(coder aDecoder: NSCoder) {
        
        self.db = PersistenceManager.shared
        super.init(coder: aDecoder)
        
    }
    
    //var container:NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    //var container = AppDelegate.persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //createEjemplar()
        //getEjemplares()
        
        /*
        if let context = container?.viewContext {
            let ejemplar = Ejemplar(context: context)
            ejemplar.nombre = "Hi Happy"
        }
         */
        
        
    }
    
    func createEjemplar() {
        let ejemplar = Ejemplar(context: db.context)
        ejemplar.nombre = "Pure Prize"
        db.save()
    }
    
    func getEjemplares() {
        //guard let ejemplares = try! db.context.fetch(Ejemplar.fetchRequest()) as? [Ejemplar] else { return }
        
        let ejemplares = db.fetch(Ejemplar.self)
        
        ejemplares.forEach({print($0.nombre!)})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

