//
//  Ejemplar+CoreDataProperties.swift
//  
//
//  Created by Lukas on 20/02/2019.
//
//

import Foundation
import CoreData


extension Ejemplar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ejemplar> {
        return NSFetchRequest<Ejemplar>(entityName: "Ejemplar")
    }

    @NSManaged public var anio: String?
    @NSManaged public var destetado: Bool
    @NSManaged public var dia: String?
    @NSManaged public var fotos: Int16
    @NSManaged public var haras: Int32
    @NSManaged public var id: Int64
    @NSManaged public var id_interno: String?
    @NSManaged public var madre: String?
    @NSManaged public var manual: Bool
    @NSManaged public var mes: String?
    @NSManaged public var microchip: Int64
    @NSManaged public var modificado: NSDate?
    @NSManaged public var muerto: Bool
    @NSManaged public var nombre: String?
    @NSManaged public var nota: String?
    @NSManaged public var padre: String?
    @NSManaged public var pelo: String?
    @NSManaged public var por: String?
    @NSManaged public var sexo: String?
    @NSManaged public var trazo: String?
    @NSManaged public var visto: Bool
    @NSManaged public var visto_no: Bool
    @NSManaged public var ubicacion: Ubicacion?

}
