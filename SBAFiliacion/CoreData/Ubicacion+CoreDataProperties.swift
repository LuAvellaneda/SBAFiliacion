//
//  Ubicacion+CoreDataProperties.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 20/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//
//

import Foundation
import CoreData


extension Ubicacion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ubicacion> {
        return NSFetchRequest<Ubicacion>(entityName: "Ubicacion")
    }

    @NSManaged public var id: Int64
    @NSManaged public var titulo: String?
    @NSManaged public var tarea: Tarea?
    @NSManaged public var ejemplar: Ejemplar?

}
