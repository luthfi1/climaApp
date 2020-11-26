//
//  ViewController.swift
//  Clima
//
//  Created by M.LUTHFI FARIZQI on 23/11/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//


import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
   
   
}

extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchButton(_ sender: UIButton) {
           searchTextField.endEditing(true)
           print(searchTextField.text!)
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           searchTextField.endEditing(true)
           print(searchTextField.text!)
           return true
       }
       
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           if textField.text != ""{
               return true
           }else{
               textField.placeholder = "Wajib isi"
               return false
           }
       }
       
       func textFieldDidEndEditing(_ textField: UITextField) {
           if let city = searchTextField.text{
               weatherManager.fetchWeather(cityName: city)
           }
           searchTextField.text = ""
       }
       
}

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager,  weather: WeatherModel){
           DispatchQueue.main.async {
               self.temperatureLabel.text = weather.temperatureString
               self.conditionImageView.image =  UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName//untuk label kota
            
           }
           
       }
       
       func didFailWithError(error: Error){
           print(error)
       }
}


    

