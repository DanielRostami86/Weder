//
//  APIHelper.swift
//  Weder
//
//  Created by Daniel Rostami on 14/8/2022.
//

import Foundation
import Combine

public protocol APIHelper {
    func fetchWeather(lat: Double, long: Double) -> AnyPublisher<CurrentWeather, Error>
    func fetchSevenDaysWeather() -> AnyPublisher<CurrentWeather, Error>
}
