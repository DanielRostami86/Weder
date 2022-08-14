//
//  APIAddress.swift
//  Networking
//
//  Created by Daniel Rostami on 14/8/2022.
//

import Foundation

enum APIAdress {
    
    case currentWeather(lat: Double, long: Double)
    case sevenDaysWeather
    
    var url: String {
        
        switch self {
        case .currentWeather(let lat, let long):
            return "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(APIKey.openWeather.key)"
        case .sevenDaysWeather:
            return ""
        }
    }
}

enum APIKey {
    case openWeather
    
    var key: String {
        switch self {
        case .openWeather:
            return "7ce44279b4d5b64bc1cd29ab327beaa4"
        }
    }
}
