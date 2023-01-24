//
//  APIAddress.swift
//  Networking
//
//  Created by Daniel Rostami on 14/8/2022.
//

import Foundation

enum BaseURL {
    static var url: String {
        #if LOCAL
            return "https://api.openweathermap.org/data/2.5/"
        #elseif PROD
            return "https://api.openweathermap.org/data/2.5/"
        #elseif TEST
            return "https://api.openweathermap.org/data/2.5/"
        #endif
    }
}

enum APIAdress {
    case currentWeather(lat: Double, long: Double)
    case sevenDaysWeather

    var url: String {
        switch self {
        case let .currentWeather(lat, long):
            return "\(BaseURL.url)forecast?lat=\(lat)&lon=\(long)&units=metric&appid=\(APIKey.openWeather.key)"
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
