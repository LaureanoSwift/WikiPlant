//
//  PlantPage.swift
//  WikiPlant
//
//  Created by Camila Storck on 15/09/2023.
//

import UIKit

import Foundation

// MARK: - PlantPage
struct PlantPage: Codable {
    let data: [PlantModel]
    let links: PageLinks
    let meta: Meta
}

// MARK: - PlantModel
struct PlantModel: Codable {
    let id: Int
    let commonName, scientificName: String
    let familyCommonName: String?
    let imageURL: String
    let synonyms: [String]
    let family: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case familyCommonName = "family_common_name"
        case imageURL = "image_url"
        case synonyms
        case family
        
    }
}

// MARK: - PageLinks
struct PageLinks: Codable {
    let linksSelf, first, next, last: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case first, next, last
    }
}

// MARK: - Meta
struct Meta: Codable {
    let total: Int
}

// MARK: - MockArray
//extension PlantModel {
//    public static func getMockArray() -> [PlantModel]{
//        return[
//            PlantModel(id: 1, commonName: "Calatea", scientificName: "calateatus", familyCommonName: "nose", imageURL: "calatea"),
//               PlantModel(id: 2, commonName: "Ficus", scientificName: "Phicus", familyCommonName: "nose", imageURL: "ficus"),
//               PlantModel(id: 3, commonName: "Dolar", scientificName: "Dolaritus", familyCommonName: "nose", imageURL: "dolar")
//        ]
//    }
//}
