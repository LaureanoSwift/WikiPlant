//
//  MainTableViewModel.swift
//  WikiPlant
//
//  Created by Camila Storck on 05/09/2023.
//

import UIKit

class MainCollectionViewModel {
    
    //    var plantList: [PlantModel] = PlantModel.getMockArray()
    var page: Int = 1
    var apiManager = APIClient()
    var dataDidChange: (() -> Void)?
    
    var plantPage: PlantPage? {
        didSet {
            dataDidChange?()
        }
    }
    
    func fetchDataFromAPI() {
        apiManager.fetchData(forPage: page) { [weak self] plantPage in
            self?.plantPage = plantPage
        }
        
    }
    
    
}
