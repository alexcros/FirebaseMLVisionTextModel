//
//  ViewController.swift
//  ImagePickerExample
//
//  Created by Alexandre on 08/10/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit
import FirebaseMLVision

class ViewController: UIViewController, UINavigationControllerDelegate, Alertable {
    
    var textRecognizer: VisionTextRecognizer!
    var frameSublayer = CALayer()
    var imagePicker: ImagePicker!
    
    @IBOutlet var imageView: UIImageView!
    @IBInspectable var loadImageButton: UIButton! {
        didSet {
            self.loadImageButton.layer.cornerRadius = 14
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startImageViewTextRecognitionProcess()
    }
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }
    
}

private extension ViewController {
    func startImageViewTextRecognitionProcess() {
        if imageView.image != nil {
            let processor = ScaledElementProcessor()
//                        let vision = Vision.vision()
//                        textRecognizer = vision.onDeviceTextRecognizer()
            processor.process(in: imageView) { text in
                print("START")
                if text.isEmpty {
                    self.showAlert(message: NSLocalizedString("Text not recognized, try again!", comment: "no text message"))
                }
                print(text)
                // enviar a la API
                
                // respuesta ok: devuelve json con X Datos y mandamos a otra pantalla.
                if let newVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DataViewController") as? DataViewController {
                    present(newVC, animated: true, completion: nil)
                }
                
            }
        }
    }
}

extension ViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        imageView.image = image
    }
}

/*
 // FIXME: Code to improve
 func convertPDFPageToImage(page: Int) {
 
 let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
 let filePath = documentsURL.appendingPathComponent("pathLocation").path
 
 do {
 
 let pdfdata = try NSData(contentsOfFile: filePath, options: NSData.ReadingOptions.init(rawValue: 0))
 
 let pdfData = pdfdata as CFData
 let provider:CGDataProvider = CGDataProvider(data: pdfData)!
 let pdfDoc:CGPDFDocument = CGPDFDocument(provider)!
 let pageCount = pdfDoc.numberOfPages
 let pdfPage:CGPDFPage = pdfDoc.page(at: page)!
 var pageRect:CGRect = pdfPage.getBoxRect(.mediaBox)
 pageRect.size = CGSize(width:pageRect.size.width, height:pageRect.size.height)
 
 print("\(pageRect.width) by \(pageRect.height)")
 
 UIGraphicsBeginImageContext(pageRect.size)
 let context:CGContext = UIGraphicsGetCurrentContext()!
 context.saveGState()
 context.translateBy(x: 0.0, y: pageRect.size.height)
 context.scaleBy(x: 1.0, y: -1.0)
 context.concatenate(pdfPage.getDrawingTransform(.mediaBox, rect: pageRect, rotate: 0, preserveAspectRatio: true))
 context.drawPDFPage(pdfPage)
 context.restoreGState()
 let pdfImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
 UIGraphicsEndImageContext()
 
 self.imageView.image = pdfImage
 
 }
 catch {
 
 }
 }
 */
