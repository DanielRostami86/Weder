//
//  APIHelper.swift
//  Weder
//
//  Created by Daniel Rostami on 14/8/2022.
//

import Foundation
import Combine

public protocol APIHelper {
    func fetchWeather(lat: Double, long: Double) -> AnyPublisher<ForecastWeather, Error>
    func fetchSevenDaysWeather() -> AnyPublisher<ForecastWeather, Error>
}
