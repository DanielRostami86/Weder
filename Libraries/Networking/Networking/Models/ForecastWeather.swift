//
//  Weather.swift
//  Networking
//
//  Created by Daniel Rostami on 14/8/2022.
//

import Combine
import Foundation

public struct ForecastWeather: Decodable {
    public let list: [Forecast]?
    public let city: City?

    public struct Forecast: Decodable {
        public let main: WeatherMain?
        public let weather: [Weather]?
        public let wind: Wind?
        public let clouds: Clouds?
        public let dt_txt: String?

        public var firstWeather: Weather? {
            return weather?.first
        }

        public var dateHourly: Date {
            guard let stringDate = dt_txt else { return Date() }
            guard let finalDate = stringDate.dateFromString(from: .YYYY_MM_DD_HH_MM_SS, to: .dd_MMM_yyyy_hh_mm) else { return Date() }
            return finalDate
        }

        public var dateOnly: Date {
            guard let stringDate = dt_txt else { return Date() }
            guard let finalDate = stringDate.dateFromString(from: .YYYY_MM_DD_HH_MM_SS, to: .YYYY_MM_DD) else { return Date() }
            return finalDate
        }
    }
}

public struct Clouds: Decodable {
    public let all: Double?
}

public struct City: Decodable {
    public let name: String?
}

public struct Wind: Decodable {
    public let speed: Double?
    public let deg: Int?

    public static func sample() -> Wind {
        return Wind(speed: 12, deg: 30)
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
