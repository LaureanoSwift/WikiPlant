//
//  ViewController.swift
//  WikiPlant
//
//  Created by Laureano Velasco on 05/09/2023.
//

import UIKit

class MainCollectionView: UIViewController {
    
    // MARK: - Variables
    let mainCollectionViewModel: MainCollectionViewModel = MainCollectionViewModel()
    let firstPage: PlantPage?
    var currentPage = 1
    let pageSize = 20
    
    // MARK: - Data from LaunchScreen
    init(firstPage: PlantPage) {
        self.firstPage = firstPage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - interface
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let pagecontrol = UIPageControl()
        pagecontrol.translatesAutoresizingMaskIntoConstraints = false
        return pagecontrol
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        mainCollectionViewModel.fetchDataFromAPI()
        setUpObservers()
        configureView()
    }
    
    
    // MARK: - Functions
    func setUpObservers() {
        mainCollectionViewModel.dataDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func configureView() {
        
        self.navigationItem.title = "WikiPlant"
        collectionView.backgroundColor = .darkGreen
        collectionView.register(PlantCell.self, forCellWithReuseIdentifier: PlantCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageControl.numberOfPages = 100
        pageControl.currentPage = mainCollectionViewModel.currentPage
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    @objc func pageControlDidChange( _ sender: UIPageControl) {
        if sender.currentPage > mainCollectionViewModel.currentPage {
            mainCollectionViewModel.nextPage()
        } else if sender.currentPage < mainCollectionViewModel.currentPage {
            mainCollectionViewModel.previousPage()
        }
        mainCollectionViewModel.fetchDataFromAPI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}

// MARK: - COLLECTION VIEW EXTENSION
extension MainCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let pageWidth = scrollView.frame.size.width
            let currentPage = Int((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
            
            if currentPage != mainCollectionViewModel.currentPage {
                mainCollectionViewModel.currentPage = currentPage
            }
            pageControl.currentPage = mainCollectionViewModel.currentPage
        }
        
        mainCollectionViewModel.fetchDataFromAPI()
        
    }
    
    
    //Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let itemsCount = mainCollectionViewModel.plantPage?.data.count else {
            return 0
        }
        return itemsCount
        
    }
    //delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let selectedPlant = mainCollectionViewModel.plantPage?.data[indexPath.row] else {
            return
        }
        let detailView = DetailView(selectedPlant: selectedPlant)
        detailView.setData(selectedPlant)
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantCell.identifier, for: indexPath) as? PlantCell else {
            fatalError("Unable to dequeue PlantCell in mainCollectionView")
        }
        
        // MARK: - Intento de implementacion de precarga de pagina
        
        guard let plant1 = firstPage?.data[indexPath.row] else {
            return cell
        }
        guard let otherplant = mainCollectionViewModel.plantPage?.data[indexPath.row] else {
            return cell
        }
        
        if currentPage == 1 {
            cell.configureCell(with: plant1)
        } else {
            cell.configureCell(with: otherplant)
        }
        
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
    
    
    //flowlayout delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/4)-4,
                      height: (view.frame.size.width/4)-4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 27
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 6, right: 1)
    }
}

