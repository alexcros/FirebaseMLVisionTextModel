//
//  UIViewController+Alertable.swift
//  ImagePickerExample
//
//  Created by Alexandre on 11/10/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

protocol Alertable { }
extension Alertable where Self: UIViewController {
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlert(message: String) {
        showAlert(title: NSLocalizedString("Error", comment: ""), message: message)
    }
}
