//
//  DibujoViewController.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 23/8/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//


import UIKit
import WebKit

class DibujoViewController: UIViewController, WKScriptMessageHandler, WKUIDelegate {
    
    let db: PersistenceManager
    var webView: WKWebView!
    var ejemplar: Ejemplar?
    var updateController: EjemplaresTableViewController?
    
    required init?(coder aDecoder: NSCoder) {
        db = PersistenceManager.shared
        super.init(coder: aDecoder)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "loginAction" {
            
            let messageBody = message.body as! [String:Any]
            let dibujo = messageBody ["dibujo"] as! String
            let trazo = messageBody ["trazo"] as! String
            let trazoJSON = messageBody["trazoJSON"] as! String
            
            //let ejemplar_id = ejemplar!.id
            let id_interno = (ejemplar!.id_interno)!
            
            let b64 = dibujo
            let image = base64Convert(base64String: b64)
            let image_trazo = base64Convert(base64String: trazo)
            
            let url_dibujo = DibujoViewController.storeImageToDocumentDirectory(image: image,fileName: "d_\(id_interno).png")!
            let url_thumb = DibujoViewController.storeImageToDocumentDirectory(image: image_trazo,fileName: "t_\(id_interno)_trazo.png")!
            
            //Guardar el trazo
            print(url_dibujo)
            print(url_thumb)
            ejemplar?.trazo = trazoJSON
            ejemplar?.modificado = NSDate()
            ejemplar?.visto = true
            db.save()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "actualizarListadoEjemplares"), object: self)
            
            self.dismiss(animated: true, completion: nil)

        }
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let trazo = ejemplar?.trazo
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "loginAction")
        
        
        let fichaPath = Bundle.main.path(forResource: "fichanueva", ofType: "jpg")
        let fichaUrl = URL(fileURLWithPath: fichaPath!)
        let imageData:NSData = NSData.init(contentsOf: fichaUrl)!
        let strBase64 = imageData.base64EncodedString()
        
        let userScript = WKUserScript(
            source: "var plantilla = 'data:image/png;base64,\(strBase64)';",
            injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
 
        if(trazo != nil){
            
            let trazoScript = WKUserScript(
                source: "var trazo = '\(trazo!)';",
                injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
                forMainFrameOnly: true
            )
            contentController.addUserScript(trazoScript)
            
        }
        
        
        let config = WKWebViewConfiguration()
        config.preferences = preferences
        config.userContentController = contentController
        
        self.webView = WKWebView(frame: self.view.bounds, configuration: config)
        webView.uiDelegate = self
        webView.scrollView.bounces = false
        webView.allowsBackForwardNavigationGestures = false
        
        self.view.addSubview(webView)
        
        let htmlpath = Bundle.main.path(forResource: "index", ofType: "html")
        
        let url = URL(fileURLWithPath: htmlpath!)
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    
    
    
    func base64Convert(base64String: String?) -> UIImage{
        if (base64String?.isEmpty)! {
            return #imageLiteral(resourceName: "no_image_found")
        }else {
            // !!! Separation part is optional, depends on your Base64String !!!
            let temp = base64String?.components(separatedBy: ",")
            let dataDecoded : Data = Data(base64Encoded: temp![1], options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
        }
    }
    
    public static func storeImageToDocumentDirectory(image: UIImage, fileName: String) -> URL? {
        guard let data = image.pngData() else {
            return nil
        }
        let fileURL = self.fileURLInDocumentDirectory(fileName)
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            return nil
        }
    }
    
    public static var documentsDirectoryURL: URL {
        return FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
    }
    public static func fileURLInDocumentDirectory(_ fileName: String) -> URL {
        return self.documentsDirectoryURL.appendingPathComponent(fileName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
