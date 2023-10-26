//
//  Protocols.swift
//  WikiPlant
//
//  Created by Laureano Velasco on 21/09/2023.
//

import Foundation

protocol APIResponseHnadler {
    func responseHandler(data: Data?, error: Error?)
    
}
