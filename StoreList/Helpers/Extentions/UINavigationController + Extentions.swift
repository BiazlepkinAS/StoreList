//
//  UINavigationController + Extentions.swift
//  StoreList
//
//  Created by Andrei Bezlepkin on 4.08.23.
//

import SwiftUI
import Foundation

extension UINavigationController {
    
    private struct Preview: UIViewControllerRepresentable {
        let navigationController: UINavigationController
        
        func makeUIViewController(context: Context) -> some UINavigationController {
            navigationController
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    func showNavigationPreview() -> some View {
        Preview(navigationController: self).edgesIgnoringSafeArea(.all)
    }
}


 //MARK: - How to use Previews withOut SwiftUI (UINavigationControllers)
/*
 struct ViewControllerProvider: PreviewProvider {
     
     static var previews: some View {
 Zstack {
         YourViewController().showPreview()
 }
     }
 }
 */

extension UINavigationController {
    
    static public func backToNavController(currentController: UINavigationController, backVC: UINavigationController, modalTransitionAnimation: UIModalTransitionStyle, modalPresentationAnimation: UIModalPresentationStyle) {
        currentController.modalTransitionStyle = modalTransitionAnimation
        currentController.modalPresentationStyle = modalPresentationAnimation
        currentController.present(backVC, animated: true)
    }
}

