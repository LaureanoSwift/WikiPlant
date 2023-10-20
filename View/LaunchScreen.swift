//
//  LaunchScreen.swift
//  WikiPlant
//
//  Created by Camila Storck on 17/10/2023.
//


// MARK: - rootearlo para que sea lo primero a mostrar


import UIKit

class LaunchScreen: UIViewController {
    
    let imageView : UIImageView = {
        let imageview = UIImageView()
        imageview.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageview.image = UIImage(named: "LaunchScreenImage")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let progressBar : UIProgressView = {
        let progresbar = UIProgressView()
        
        progresbar.tintColor = .darkGreen
        progresbar.progress = 0.5
        progresbar.translatesAutoresizingMaskIntoConstraints = false
        return progresbar
    }()
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.backgroundColor = .lightGreen
        
        
            
            
            
        }
    func configureView() {
        view.addSubview(imageView)
        view.addSubview(progressBar)
        
        
        NSLayoutConstraint.activate([
        
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            progressBar.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
            
        
        
        ])
    }
}

