//
//  APIClient.swift
//  WikiPlant
//
//  Created by Camila Storck on 05/09/2023.
//

import UIKit

class APIClient {
    
    func fetchData(completion: @escaping ([PlantModel]) -> Void) {
        
        let endPoint = "https://trefle.io/api/v1/plants?token=6iBkYteQSqlDkPLG7e2VVXu5YewFcnBgCCc0TwESy4w"
        
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
                        let plants = try decoder.decode([PlantModel].self, from: data)
                        
                        completion(plants)
                    } catch {
                        print("Error al decodificar datos Json: \(error.localizedDescription)")
                    }
                }
            }.resume()
            
        }
    }
}

