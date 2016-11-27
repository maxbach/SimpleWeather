//
//  ViewController.swift
//  WeatherApp
//
//  Created by Максим Бачинский on 14.11.16.
//  Copyright © 2016 Max Bachinskiy. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    var weather = WeatherInfo();
    let key = "71139f2aa1d7de532658813d2a67dfee"
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    func updateWeather(lat: Double, lon : Double) {
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(key)"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let cityName = json["name"].stringValue;
                let temp = json["main"]["temp"].stringValue;
                let tempD = Double(temp)! - 273.15
                self.weather = WeatherInfo(temp: Int(tempD), name: cityName)
                
                
            case .failure(let error):
                print("Request failed with error: \(error)")
                self.cityLabel.text = "0º";
                self.temperatureLabel.text = "Not found";
            }
        }
        updateUi()
        
    }
    
    func updateUi() {
        self.cityLabel.text = "City: " + self.weather.cityName;
        self.temperatureLabel.text = String(self.weather.temp) + "ºC";
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            updateWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        }
        //Do What ever you want with it
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }


}

