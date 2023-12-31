//
//  MainTableViewModel.swift
//  WikiPlant
//
//  Created by Laureano Velasco on 05/09/2023.
//

import UIKit

class MainCollectionViewModel {
    
    var currentPage: Int = 1
    var apiManager = APIClient()
    var dataDidChange: (() -> Void)?
    
    var plantPage: PlantPage? {
        didSet {
            dataDidChange?()
        }
    }
    
    func nextPage() {
        currentPage += 1
    }
    
    func previousPage() {
        if currentPage > 1 {
            currentPage -= 1
        }
    }
    
    func fetchDataFromAPI() {
        apiManager.fetchData(forPage: currentPage) { [weak self] plantPage in
            self?.plantPage = plantPage
        }
        
    }
    
    
}
