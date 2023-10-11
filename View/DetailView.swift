//
//  DetailView.swift
//  WikiPlant
//
//  Created by Camila Storck on 03/10/2023.
//

import Foundation
import UIKit

class DetailView: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.contentSize = CGSize(width: scrollview.frame.size.width, height: 800)
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
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
    var tempSynonyms = ""
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
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
        
        name.text = plant.commonName
        scientificName.text = plant.scientificName
        family.text = plant.family
        for item in plant.synonyms {
            tempSynonyms += item + "\n "
        }
        
        synonyms.text = tempSynonyms + "."
        
    }
    
    func setUp() {
        
        view.backgroundColor = .darkGreen
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(name)
        scrollView.addSubview(scientificName)
        scrollView.addSubview(family)
        scrollView.addSubview(synonyms)
        
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 500),
            imageView.widthAnchor.constraint(equalToConstant: 350),
            
            name.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20),
            name.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20),
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            
            scientificName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20),
            scientificName.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20),
            scientificName.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            
            family.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20),
            family.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20),
            family.topAnchor.constraint(equalTo: scientificName.bottomAnchor, constant: 20),
            
            synonyms.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20),
            synonyms.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20),
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
    label.clipsToBounds = true
    label.layer.cornerRadius = 5
    label.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    return label
    
}
