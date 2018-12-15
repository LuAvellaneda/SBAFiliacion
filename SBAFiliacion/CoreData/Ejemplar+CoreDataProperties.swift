//
//  Ejemplar+CoreDataProperties.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 15/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//
//

import Foundation
import CoreData


extension Ejemplar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ejemplar> {
        return NSFetchRequest<Ejemplar>(entityName: "Ejemplar")
    }

    @NSManaged public var fotos: Int16
    @NSManaged public var id: Int32
    @NSManaged public var nombre: String?
    @NSManaged public var por: String?
    @NSManaged public var sexo: String?
    @NSManaged public var trazo: String?
    @NSManaged public var visto: Bool
    @NSManaged public var nota: String?
    @NSManaged public var padre: String?
    @NSManaged public var madre: String?
    @NSManaged public var pelo: String?
    @NSManaged public var destetado: Bool
    @NSManaged public var muerto: Bool
    @NSManaged public var haras: Int32
    @NSManaged public var manual: Bool
    @NSManaged public var microchip: Int32

}
