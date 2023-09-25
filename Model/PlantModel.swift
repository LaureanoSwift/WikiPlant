//
//  PlantModel.swift
//  WikiPlant
//
//  Created by Camila Storck on 05/09/2023.
// tokken: 6iBkYteQSqlDkPLG7e2VVXu5YewFcnBgCCc0TwESy4w

import UIKit

struct PlantModel: Codable {
    
    let id: Int
    let common_name: String
    let scientific_name: String
    let family_common_name: String
    let image_url: String
    
}


extension PlantModel {
    public static func getMockArray() -> [PlantModel]{
        return[
            PlantModel(id: 1, common_name: "Calatea", scientific_name: "calateatus", family_common_name: "nose", image_url: "calatea"),
               PlantModel(id: 2, common_name: "Ficus", scientific_name: "Phicus", family_common_name: "nose", image_url: "ficus"),
               PlantModel(id: 3, common_name: "Dolar", scientific_name: "Dolaritus", family_common_name: "nose", image_url: "dolar")
        ]
    }
}
