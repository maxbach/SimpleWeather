//: Playground - noun: a place where people can play

import UIKit
import Alamofire
import SwiftyJSON

var key = "71139f2aa1d7de532658813d2a67dfee"
var coor1 = "59.87"
var coor2 = "30.30"
let parameters: Parameters = ["lat": coor1, "lon" : coor2, "APPID" : "71139f2aa1d7de532658813d2a67dfee"];

let url = "api.openweathermap.org/data/2.5/weather?"
Alamofire.request(url, parameters: parameters).validate().responseJSON { response in
    switch response.result {
    case .success(let data):
        let json = JSON(data)
        print(json)
    case .failure(let error):
        print("Request failed with error: \(error)")
    }
}

