//
//  Fotos+CoreDataProperties.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 05/03/2019.
//  Copyright © 2019 Lucas Avellaneda. All rights reserved.
//
//

import Foundation
import CoreData


extension Fotos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fotos> {
        return NSFetchRequest<Fotos>(entityName: "Fotos")
    }

    @NSManaged public var id: String?
    @NSManaged public var posicion: Int16

}
