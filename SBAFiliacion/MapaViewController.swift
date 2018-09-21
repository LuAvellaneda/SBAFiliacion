//
//  MapaViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 16/9/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit
import MapKit
import AddressBook


class MapaViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView! {
        didSet {
            mapa.mapType = .standard
            mapa.delegate = self
            zoomOnMap(location: initialLocation)
        }
    }
    
    private let initialLocation = CLLocation(latitude: -34.00, longitude: -64.00)
    private let regionRadius: CLLocationDistance = 900000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let haras =  Haras(title: "Firmamento",subtitle: "Mar del Plata, BS.AS",coordinate: CLLocationCoordinate2D(latitude: -36.0398042, longitude: -60.9772331))
        
        mapa.addAnnotation(haras)
        
        let haras2 =  Haras(title: "La Pasión",subtitle: "Solis, BS.AS",coordinate: CLLocationCoordinate2D(latitude: -34.2981689, longitude: -59.3282848))
        mapa.addAnnotation(haras2)
        
        let haras3 =  Haras(title: "El Paraiso",subtitle: "La Luisa, BS.AS",coordinate: CLLocationCoordinate2D(latitude: -34.1247545, longitude: -59.9230457))
        mapa.addAnnotation(haras3)
        
        let haras4 =  Haras(title: "Abolengo",subtitle: "Capitán Sarmiento, BS.AS",coordinate: CLLocationCoordinate2D(latitude: -34.168972, longitude: -59.8080936))
        mapa.addAnnotation(haras4)
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func zoomOnMap(location:CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapa.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: "haras")
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "haras")
            view.canShowCallout = true
        } else {
            view.annotation = annotation
        }
        
        view.leftCalloutAccessoryView = nil
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "showHaras", sender: view)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHaras" {
            var view = sender as! MKAnnotationView
            if let vc = segue.destination as? HarasTableViewController {
                vc.harasNombre = view.annotation?.title!
            }
        }
    }
    

}

class Haras:NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    init(title:String, subtitle:String?, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
