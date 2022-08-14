//
//  Weather.swift
//  Networking
//
//  Created by Daniel Rostami on 14/8/2022.
//

import Foundation
import Combine

public struct CurrentWeather: Decodable {
    
    public let cord: Coordinate?
    public let weather: [Weather]?
    public let base : String?
    public let main: WeatherMain?
    public let visibility: Int?
    public let wind: Wind?
    
    static public func sample() -> CurrentWeather {
        return CurrentWeather(cord: nil, weather: [Weather.sample()], base: nil, main: WeatherMain.sample(), visibility: 14, wind: Wind.sample())
    }
}

public struct Clouds: Decodable {
    public let all: Double?
}

public struct Wind: Decodable {
    public let speed: Double?
    public let deg: Int?
    
    public static func sample() -> Wind {
        return Wind.init(speed: 12, deg: 30)
    }
}

public struct WeatherMain: Decodable {
    public let temp: Double?
    public let feels_like: Double?
    public let temp_min: Double?
    public let temp_max: Double?
    public let pressure: Int?
    public let humidity: Int?
    
    public static func sample() -> WeatherMain {
        return WeatherMain(temp: 14, feels_like: 16, temp_min: 10, temp_max: 18, pressure: 14, humidity: 60)
    }
}

public struct Weather: Decodable {
    public let id: Int?
    public let main: String?
    public let description: String?
    public let icon: String?

    public static func sample() -> Weather {
        return Weather(id: 1, main: "Clear", description: "Clear sky", icon: nil)
    }
}

public struct Coordinate: Decodable {
    public let lon: Double?
    public let lat: Double?
}

//public struct Temp: Decodable {
//    let day: Double?
//    let min: Double?
//    let max: Double?
//    let night: Double?
//    let eve: Double?
//    let morn: Double?
//}
