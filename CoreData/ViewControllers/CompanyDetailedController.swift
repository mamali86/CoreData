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
    func didEditCompany(company: Company)
}


class CompanyDetailedController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate: companyDetailedControllerDelegate?
    
    var company: Company? {
        didSet{
            
            nameTextFiled.text = company?.name
            guard let founded = company?.founded else {return}
            datePicker.date = founded
            
            if let compnayImageData = company?.imageData {
                
                companyImageView.image = UIImage(data: compnayImageData)
                
            }
            circularImage()
            
        }
    }
    
    
    // at the beginning of the instantiation of the Controller, if let is used self will be nil
    lazy var companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhotoSelection)))
        return imageView
        
    }()
    
    @objc fileprivate func handlePhotoSelection() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            companyImageView.image = originalImage
            
        } else if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            companyImageView.image = editedImage
        }

       circularImage()
        
        dismiss(animated: true, completion: nil)

    }
    
    fileprivate func circularImage() {
    
    companyImageView.layer.cornerRadius = companyImageView.frame.width / 2
    companyImageView.layer.masksToBounds = true
    companyImageView.layer.borderColor = UIColor.darkGreen.cgColor
    companyImageView.contentMode = .scaleAspectFill
    companyImageView.layer.borderWidth = 3
    
    }
    
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
        
    }()
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGreen
        setupNavigationBarCancel()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        setupUI()
    }
    


    
    
    @objc fileprivate func handleSave() {
        
        
        if self.company == nil {
            
         createComany()
            
        } else {
            
          editCompany()
            
        }
        
    }
    
    
    fileprivate func editCompany() {
        
        let context = CoreDataManager.sharedInstance.persistenceContainer.viewContext

        company?.name = nameTextFiled.text
        company?.founded = datePicker.date
        
        if let companyImage =  companyImageView.image {
            
            let imageData = UIImageJPEGRepresentation(companyImage, 0.8)
            company?.imageData = imageData
            
        }
        
        
        do {
            try context.save()

            dismiss(animated: true) {
                
                self.delegate?.didEditCompany(company: self.company!)
            }
        } catch let saveErr {
            print("Failed to save company", saveErr)
        }
    
    }
    
    fileprivate func createComany() {
        
        let context = CoreDataManager.sharedInstance.persistenceContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        
        company.setValue(nameTextFiled.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        
        
        if let companyImage =  companyImageView.image {
    
            let imageData = UIImageJPEGRepresentation(companyImage, 0.8)
            company.setValue(imageData, forKey: "imageData")
            
        }
        
        
        // perform the save
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didAddCompany(company: company as! Company)
            }
        } catch let saveErr {
            print("Failed to save company", saveErr)
        }
    }
    
   
    fileprivate func setupUI() {
        
        
        let lightBlueView = setupLightBlueView(height: 300)
        
        
        view.addSubview(companyImageView)
        companyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        


        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: 0).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextFiled)
        nameTextFiled.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 0).isActive = true
        nameTextFiled.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        nameTextFiled.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        nameTextFiled.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: lightBlueView.rightAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: lightBlueView.leftAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: lightBlueView.bottomAnchor).isActive = true


    }
    

}
