//
//  ViewController.swift
//  Learning App
//
//  Created by Richard Lam on 29/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countrySearchTextField: UITextField!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!

    
    var countryManager = CountryManager()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        countryManager.delegate = self
        countrySearchTextField.delegate = self
    }


}

//Mark: - UITextFieldDelegate
extension ViewController : UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        countrySearchTextField.endEditing(true)
        print("searchPressed2")

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        countrySearchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldShouldEndEditing")
        if let country = countrySearchTextField.text {
            countryManager.fetchCountryDetails(countryName: country)
        }
        
        countrySearchTextField.text = ""
        
    }
}

//MARK: - WeatherManagerDelegate


extension ViewController: CountryManagerDelegate {
    
    func didUpdate(_ countryManager: CountryManager, country: CountryModel) {
        DispatchQueue.main.async {
            self.countryNameLabel.text = country.countryName
            self.cityNameLabel.text = country.capitalCityName
            self.latitudeLabel.text = String(format: "%.2f", country.latitude)
            self.longitudeLabel.text = String(format: "%.2f", country.longitude)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
