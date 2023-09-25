//
//  MainTableViewModel.swift
//  WikiPlant
//
//  Created by Camila Storck on 05/09/2023.
//

import UIKit

class MainCollectionViewModel {
    
//    var plantList: [PlantModel] = PlantModel.getMockArray()
    
    var dataDidChange: (() -> Void)?
    
    var apiManager = APIClient()
    
    var plants: [PlantModel] = [] {
        didSet {
            dataDidChange?()
        }
    }
    
    func fetchDataFromAPI() {
        apiManager.fetchData { [weak self] plants in
            self?.plants = plants
        }
    }
}
