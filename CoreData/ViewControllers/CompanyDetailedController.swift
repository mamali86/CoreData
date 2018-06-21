//
//  companyDetailedController.swift
//  CoreData
//
//  Created by Mohammad Farhoudi on 10/06/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import UIKit
import CoreData


protocol companyDetailedControllerDelegate {
    func didAddCompany(company: Company)
}


class CompanyDetailedController: UIViewController {
    
    var delegate: companyDetailedControllerDelegate?
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.placeholder = "Enter Company"
        return textFiled
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGreen
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleDismiss))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        setupUI()
    }
    

    @objc fileprivate func handleDismiss() {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc fileprivate func handleSave() {
        
        
        
//        dismiss(animated: true) {
//            guard let companyName = self.nameTextFiled.text else {return}
//            let company = Company(name: companyName, founded: Date())
//            self.delegate?.didAddCompany(company: company)
            
//        }
        
    }
    
   
    fileprivate func setupUI() {
        
        let lightBlueView = UIView()
        lightBlueView.backgroundColor = UIColor.lightBlue
        lightBlueView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lightBlueView)
        
        
        lightBlueView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        lightBlueView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        lightBlueView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        lightBlueView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextFiled)
        nameTextFiled.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 0).isActive = true
        nameTextFiled.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        nameTextFiled.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        nameTextFiled.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    

}
