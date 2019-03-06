//
//  Tarea+CoreDataProperties.swift
//  SBAFiliacion
//
//  Created by Lukas on 06/03/2019.
//  Copyright © 2019 Lucas Avellaneda. All rights reserved.
//
//

import Foundation
import CoreData


extension Tarea {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tarea> {
        return NSFetchRequest<Tarea>(entityName: "Tarea")
    }

    @NSManaged public var descripcion: String?
    @NSManaged public var fecha: String?
    @NSManaged public var id: Int64
    @NSManaged public var titulo: String?
    @NSManaged public var total: Int16
    @NSManaged public var ubicacion: NSSet?

}

// MARK: Generated accessors for ubicacion
extension Tarea {

    @objc(addUbicacionObject:)
    @NSManaged public func addToUbicacion(_ value: Ubicacion)

    @objc(removeUbicacionObject:)
    @NSManaged public func removeFromUbicacion(_ value: Ubicacion)

    @objc(addUbicacion:)
    @NSManaged public func addToUbicacion(_ values: NSSet)

    @objc(removeUbicacion:)
    @NSManaged public func removeFromUbicacion(_ values: NSSet)

}
