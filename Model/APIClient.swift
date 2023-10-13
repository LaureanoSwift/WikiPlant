//
//  APIClient.swift
//  WikiPlant
//
//  Created by Camila Storck on 05/09/2023.
//

import UIKit

class APIClient {
    
    let numberOfPage = 1
    private(set) var plant: PlantModel!
    
    func fetchData(completion: @escaping (PlantPage) -> Void) {
        
        let endPoint = "https://trefle.io/api/v1/plants?token=6iBkYteQSqlDkPLG7e2VVXu5YewFcnBgCCc0TwESy4w&order[common_name]=asc&page=\(numberOfPage)"
        
        if let url = URL(string: endPoint){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("error al hacer la solicitud api: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                          print("Respuesta de API no valida")
                          return
                      }
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let plantPage = try decoder.decode(PlantPage.self, from: data)
                        
                        completion(plantPage)
                    } catch {
                        print("Error al decodificar datos Json: \(error.localizedDescription)")
                    }
                }
            }.resume()
            
        }
        
    }
    
    static func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error al cargar la imagen :\(error.localizedDescription)")
                completion(nil)
                return
            }
            if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
    }
    
}

