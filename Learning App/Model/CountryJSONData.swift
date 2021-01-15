//
//  WeatherJSONData.swift
//  Learning App
//
//  Created by Richard Lam on 29/10/20.
//

import Foundation


struct CountryJSONData: Codable {
    let countries: [Country]
}

struct Country: Codable {
    let name : String
    let capital : String
    let latlng : [Double]
}


