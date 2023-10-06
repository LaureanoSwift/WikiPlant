//
//  DetailView.swift
//  WikiPlant
//
//  Created by Camila Storck on 03/10/2023.
//

import Foundation
import UIKit

class DetailView: UIViewController {
    
    
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    
    let name = createLabel(fontSize: 35)
    let scientificName = createLabel(fontSize: 30)
    let family = createLabel(fontSize: 20)
    let synonyms = createLabel(fontSize: 15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    
    private let selectedPlant: PlantModel
    
    init(selectedPlant: PlantModel) {
        self.selectedPlant = selectedPlant
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ plant: PlantModel) {
        
        
        if let imageUrl = URL(string: plant.imageURL) {
            APIClient.fetchImage(from: imageUrl) { image in
                if image != nil {
                    self.imageView.image = image
                }
            }
        }
        
        name.text = plant.commonName
        scientificName.text = plant.scientificName
        family.text = plant.family
        
        
    }
    
    func setUp() {
        view.backgroundColor = .lightGreen
        view.addSubview(imageView)
        view.addSubview(name)
        view.addSubview(scientificName)
        view.addSubview(family)
        view.addSubview(synonyms)
        
        
        NSLayoutConstraint.activate([
        
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            
            scientificName.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scientificName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scientificName.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            
            family.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            family.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            family.topAnchor.constraint(equalTo: scientificName.bottomAnchor, constant: 20),
            
            synonyms.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            synonyms.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            synonyms.topAnchor.constraint(equalTo: family.bottomAnchor, constant: 20),
        
        ])
    }
    
}

func createLabel(fontSize: CGFloat) -> UILabel{
    
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.numberOfLines = 0
    label.layer.masksToBounds = true
    label.layer.cornerRadius = 5
    return label
    
}
