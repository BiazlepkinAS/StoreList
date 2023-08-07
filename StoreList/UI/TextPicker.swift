//
//  TextPicker.swift
//  StoreList
//
//  Created by Andrei Bezlepkin on 7.08.23.
//

import UIKit

class TextPicker {
    
    func showPicker(in viewController : UIViewController, completion: @escaping((String)-> Void)) {
        let alertController = UIAlertController(title: "New item", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let accessAction = UIAlertAction(title: "Ok", style: .default) { _ in
            if let text = alertController.textFields?[0].text, text != "" {
                completion(text)
            }
        }
        let cancelledAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(accessAction)
        alertController.addAction(cancelledAction)
        
        viewController.present(alertController, animated: true)
    }
    
    
}
