//
//  CountryManager.swift
//  Learning App
//
//  Created by Richard Lam on 29/10/20.
//

import Foundation

protocol CountryManagerDelegate {
    func didUpdate(_ countryManager: CountryManager, country: CountryModel)
    func didFailWithError(error: Error)
}


struct CountryManager {
    
    let countryRestUrl = "https://restcountries.eu/rest/v2/name"
    
    var delegate: CountryManagerDelegate?
    
    func fetchCountryDetails(countryName : String) {
        let url = "\(countryRestUrl)/\(countryName)"
        print("calling url " + url)
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let country = self.parseJSON(safeData) {
                        self.delegate?.didUpdate(self, country: country)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ countryJSONData: Data) -> CountryModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Country].self, from: countryJSONData)
            let name = decodedData[0].name
            let capital = decodedData[0].capital
            let lat = decodedData[0].latlng[0]
            let long = decodedData[0].latlng[1]

            let country = CountryModel(countryName: name, capitalCityName: capital, latitude: lat, longitude: long)
            return country
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
