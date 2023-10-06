//
//  Cell.swift
//  WikiPlant
//
//  Created by Camila Storck on 05/09/2023.
//

import Foundation
import UIKit

final class PlantCell: UICollectionViewCell {
    static let identifier = "PlantCell"
    private(set) var plant: PlantModel!
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .boldSystemFont(ofSize: 15)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    public func configure(with plant: PlantModel) {
        
        self.plant = plant
        
        if let imageUrl = URL(string: plant.imageURL) {
            APIClient.fetchImage(from: imageUrl) { image in
                if image != nil {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                    
                }
            }
        }
        
        
//        guard let imageURL = URL(string: plant.imageURL) else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            DispatchQueue.main.async {
//                let image = UIImage(data: data)
//                self?.imageView.image = image
//            }
//        }.resume()
        
        //self.imageView.image = UIImage(named: plant.imageURL)
        self.nameLabel.text = plant.commonName
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            
        ])
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 30
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
