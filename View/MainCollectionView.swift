//
//  ViewController.swift
//  WikiPlant
//
//  Created by Camila Storck on 05/09/2023.
//

import UIKit

class MainCollectionView: UIViewController {
    
    let mainCollectionViewModel: MainCollectionViewModel = MainCollectionViewModel()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: UICollectionViewFlowLayout()
        )
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // - MARK: arreglar funcionalidad de api
        //        mainCollectionViewModel.fetchDataFromAPI()
        setUpObservers()
        configureView()
    }
    
    func setUpObservers() {
        mainCollectionViewModel.dataDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    
    func configureView() {
        
        self.navigationItem.title = "WikiPlant"
        collectionView.register(PlantCell.self, forCellWithReuseIdentifier: PlantCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}

extension MainCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // - MARK: arreglar funcionalidad de api
        //        guard let itemsCount = mainCollectionViewModel.page?.data.count else {
        //            return 0
        //        }
        //        return itemsCount
        let plants = mainCollectionViewModel.plantList.count
        return plants
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantCell.identifier, for: indexPath) as? PlantCell else {
            fatalError("Unable to dequeue PlantCell in mainCollectionView")
        }
        // - MARK: arreglar funcionalidad de api
        //        guard let plant = mainCollectionViewModel.page?.data[indexPath.row] else {
        //            return cell
        //        }
        //        cell.configure(with: plant)
        //
        //        return cell
        
        let plant = mainCollectionViewModel.plantList[indexPath.row]
        cell.configure(with: plant)
        return cell
    }
    
    //delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // codigo para pasar a la vista del detalle de la planta
    }
    
    
    //flowlayput delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/3)-3,
                      height: (view.frame.size.width/3)-3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    
}

