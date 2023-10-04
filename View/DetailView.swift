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
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.addSubview(imageView)
        view.addSubview(nameLabel)
    }
    
}
