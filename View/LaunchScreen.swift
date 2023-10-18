//
//  LaunchScreen.swift
//  WikiPlant
//
//  Created by Camila Storck on 17/10/2023.
//


// MARK: - rootearlo para que sea lo primero a mostrar


import UIKit

class LaunchScreen: UIViewController {
    
    let imageView = UIImageView()
    let progressBar = UIProgressView()
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.center = view.center
        imageView.image = UIImage(named: "LaunchScreenImage")
        imageView.contentMode = .scaleAspectFit
        
        func configureView() {
            view.addSubview(imageView)
            view.addSubview(progressBar)
            
            imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            imageView.center = view.center
            imageView.image = UIImage(named: "LaunchScreenImage")
            imageView.contentMode = .scaleAspectFit
            
            progressBar.frame = CGRect(x: 50, y: imageView.frame.maxY + 20, width: view.frame.width - 100, height: 20)
            progressBar.tintColor = .blue
            progressBar.progress = 0.5
        }
    }
}

