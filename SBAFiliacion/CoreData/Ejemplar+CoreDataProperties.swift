//
//  Ejemplar+CoreDataProperties.swift
//  SBAFiliacion
//
//  Created by Lukas on 07/03/2019.
//  Copyright © 2019 Lucas Avellaneda. All rights reserved.
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
    @NSManaged public var haras: Int32
    @NSManaged public var haras_texto: String?
    @NSManaged public var id: Int64
    @NSManaged public var id_interno: String?
    @NSManaged public var lugar_corre: NSDate?
    @NSManaged public var lugar_cuidador: String?
    @NSManaged public var lugar_lugar: String?
    @NSManaged public var lugar_observacion: String?
    @NSManaged public var lugar_telefono: String?
    @NSManaged public var lugar_tipo: String?
    @NSManaged public var madre: String?
    @NSManaged public var manual: Bool
    @NSManaged public var mes: String?
    @NSManaged public var microchip: String?
    @NSManaged public var modificado: NSDate?
    @NSManaged public var muerto: Bool
    @NSManaged public var nombre: String?
    @NSManaged public var nota: String?
    @NSManaged public var padre: String?
    @NSManaged public var pelo: String?
    @NSManaged public var pelo_id: Int16
    @NSManaged public var por: String?
    @NSManaged public var raza: String?
    @NSManaged public var raza_id: Int16
    @NSManaged public var sexo: String?
    @NSManaged public var sexo_id: String?
    @NSManaged public var trazo: String?
    @NSManaged public var visto: Bool
    @NSManaged public var visto_no: Bool
    @NSManaged public var corre: String?
    @NSManaged public var sin_denuncia: Bool
    @NSManaged public var sin_pasaporte: Bool
    @NSManaged public var fotos: Fotos?
    @NSManaged public var trabajo: Trabajo?
    @NSManaged public var ubicacion: Ubicacion?

}
