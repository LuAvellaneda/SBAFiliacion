//
//  Tarea+CoreDataProperties.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 20/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//
//

import Foundation
import CoreData


extension Tarea {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tarea> {
        return NSFetchRequest<Tarea>(entityName: "Tarea")
    }

    @NSManaged public var id: Int64
    @NSManaged public var titulo: String?
    @NSManaged public var descripcion: String?
    @NSManaged public var ubicacion: Ubicacion?

}
