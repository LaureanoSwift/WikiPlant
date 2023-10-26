//
//  LaunchScreen.swift
//  WikiPlant
//
//  Created by Laureano Velasco on 17/10/2023.
//

import UIKit

class LaunchScreen: UIViewController {
    
    let firstApiCall: APIClient = APIClient()
    var plantPage: PlantPage?
    var currentPage: Int = 1
    
    
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
        progresbar.progress = 0.1
        progresbar.translatesAutoresizingMaskIntoConstraints = false
        return progresbar
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstApiCall.fetchData(forPage: currentPage) { [weak self] plantPage in
            self?.plantPage = plantPage
        }
        
        
        ProgressBarLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()+26) {
            guard let plantPage = self.plantPage else {
                return
            }
            
            let mainCollectionView = MainCollectionView(firstPage: plantPage)
            self.navigationController?.pushViewController(mainCollectionView, animated: true)
            
        }
    }
    
    func ProgressBarLoad() {
        for x in 1..<100 {
            DispatchQueue.main.asyncAfter(deadline: .now()+Double(x)*0.25) {
                self.progressBar.setProgress(Float(x)/100, animated: true)
            }
        }
    }
    
    func configureView() {
        view.backgroundColor = .lightGreen
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
