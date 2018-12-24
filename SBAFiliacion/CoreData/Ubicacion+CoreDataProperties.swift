//
//  Ubicacion+CoreDataProperties.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 24/12/2018.
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
    @NSManaged public var ejemplar: NSSet?
    @NSManaged public var tarea: Tarea?

}

// MARK: Generated accessors for ejemplar
extension Ubicacion {

    @objc(addEjemplarObject:)
    @NSManaged public func addToEjemplar(_ value: Ejemplar)

    @objc(removeEjemplarObject:)
    @NSManaged public func removeFromEjemplar(_ value: Ejemplar)

    @objc(addEjemplar:)
    @NSManaged public func addToEjemplar(_ values: NSSet)

    @objc(removeEjemplar:)
    @NSManaged public func removeFromEjemplar(_ values: NSSet)

}
