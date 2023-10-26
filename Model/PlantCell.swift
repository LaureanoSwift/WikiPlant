//
//  Cell.swift
//  WikiPlant
//
//  Created by Laureano Velasco on 05/09/2023.
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
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return nameLabel
    }()
    
    public func configureCell(with plant: PlantModel) {
        
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
        
        self.nameLabel.text = plant.commonName
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
            
        ])
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
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
