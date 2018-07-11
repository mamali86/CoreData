//
//  UIViewController.swift
//  ElvotraCoreData
//
//  Created by Mohammad Farhoudi on 10/07/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
     func setupNavigationItems(selector: Selector) {
        
           navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
        
    }
    
    func setupNavigationBarCancel() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleDismiss))
        
    }
    
    
    @objc fileprivate func handleDismiss() {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupLightBlueView(height: CGFloat) -> UIView {
        
        let lightBlueView = UIView()
        lightBlueView.backgroundColor = UIColor.lightBlue
        lightBlueView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lightBlueView)
        
        lightBlueView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        lightBlueView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        lightBlueView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        lightBlueView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return lightBlueView
        
    }
    
    
    
}
