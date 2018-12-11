//
//  Ejemplar+CoreDataProperties.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 8/8/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//
//

import Foundation
import CoreData


extension Ejemplar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ejemplar> {
        return NSFetchRequest<Ejemplar>(entityName: "Ejemplar")
    }

    @NSManaged public var nombre: String?
    @NSManaged public var sexo: String?
    @NSManaged public var trazo: String?
    @NSManaged public var fotos: Int32
    @NSManaged public var id: Int32

}
