//
//  Weather.swift
//  Weder
//
//  Created by Daniel Rostami on 13/8/2022.
//

import Foundation

public struct Weather {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let moonrise: Int?
    let moonset: Int?
    let moon_phase: Double?
    let temp: Temp?
    let pressure: Int?
    let humidity: Int?
    let dew_point: Double?
    let wind_speed: Double?
    let wind_deg: Int?
    let wind_gust: Double?
    let weather: [Weather]?
    let clouds: Int?
    let pop: Double?
    let rain: Double?
    let uvi: Double?
    
    static func sample() -> Weather {
        return Weather(dt: nil, sunrise: nil, sunset: nil, moonrise: nil, moonset: nil, moon_phase: nil, temp: nil, pressure: nil, humidity: 80, dew_point: nil, wind_speed: 49, wind_deg: nil, wind_gust: nil, weather: nil, clouds: nil, pop: nil, rain: 23, uvi: nil)
    }
}

struct Temp: Codable {
    let day: Double?
    let min: Double?
    let max: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}
