//
//  MainTableViewModel.swift
//  WikiPlant
//
//  Created by Camila Storck on 05/09/2023.
//

import UIKit

class MainCollectionViewModel {
    
    var plantList: [PlantModel] = PlantModel.getMockArray()
    
    var dataDidChange: (() -> Void)?
    
    var apiManager = APIClient()
    // - MARK: arreglar funcionalidad de api
    //    var plants: PlantPage = PlantPage() {
    //        didSet {
    //            dataDidChange?()
    //        }
    //    }
    
    var page: PlantPage?
    
    // - MARK: arreglar funcionalidad de api
    //    func fetchDataFromAPI() {
    //        apiManager.fetchData { [weak self] page in
    //            self?.page = page
    //        }
    //    }
}
