//
//  CompanyCell.swift
//  ElvotraCoreData
//
//  Created by Mohammad Farhoudi on 03/07/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import UIKit


class CompanyCell: UITableViewCell {
    
    var company: Company? {
        didSet{
            
        
            
            if let companyName = company?.name, let founded = company?.founded {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let foundedDatedString = dateFormatter.string(from: founded)
                
                //            let locale = Locale(identifier: "EN")
                nameLabel.text = "\(companyName) - Founded: \(foundedDatedString)"
            }
            else {
                nameLabel.text = company?.name
            }
            
            
            guard let imageData = company?.imageData else {return}
            companyImage.image = UIImage(data: imageData)
            
//            if let companyImage = company?.imageData {
//                companyImage.image = UIImage(data: companyImage)
//
//        }
    }
    
    }
    
    
    let companyImage: UIImageView =  {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.layer.borderColor = UIColor.darkGreen.cgColor
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 1
        return image
        
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello Everyone"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(companyImage)
        companyImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        companyImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        companyImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        companyImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true

        addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: companyImage.rightAnchor, constant: 8).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
