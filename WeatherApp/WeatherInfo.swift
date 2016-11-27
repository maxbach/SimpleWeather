//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Максим Бачинский on 23.11.16.
//  Copyright © 2016 Max Bachinskiy. All rights reserved.
//

import Foundation

class WeatherInfo {

    var temp : Int;
    var cityName : String;
    
    init(temp : Int, name : String) {
        self.temp = temp;
        self.cityName = name;
    }
    
    init() {
        self.temp = 0;
        self.cityName = "Undefined";
    
    }
    

}
