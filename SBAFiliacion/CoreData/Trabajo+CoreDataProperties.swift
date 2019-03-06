//
//  Trabajo+CoreDataProperties.swift
//  SBAFiliacion
//
//  Created by Lukas on 06/03/2019.
//  Copyright © 2019 Lucas Avellaneda. All rights reserved.
//
//

import Foundation
import CoreData


extension Trabajo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trabajo> {
        return NSFetchRequest<Trabajo>(entityName: "Trabajo")
    }

    @NSManaged public var corre: NSDate?
    @NSManaged public var cuidador: String?
    @NSManaged public var lugar: String?
    @NSManaged public var observacion: String?
    @NSManaged public var telefono: String?
    @NSManaged public var tipo: String?
    @NSManaged public var ejemplar: Ejemplar?

}
