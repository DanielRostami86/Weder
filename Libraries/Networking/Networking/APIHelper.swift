//
//  APIHelper.swift
//  Weder
//
//  Created by Daniel Rostami on 14/8/2022.
//

import Combine
import Foundation

public protocol APIHelper {
    func fetchWeather(lat: Double, long: Double) -> AnyPublisher<ForecastWeather, Error>
    func fetchSevenDaysWeather() -> AnyPublisher<ForecastWeather, Error>
}
