//
//  NetworkProvider.swift
//  Weder
//
//  Created by Daniel Rostami on 14/8/2022.
//

import Combine
import Foundation

public class Networking: APIHelper {
    public static let shared = Networking()

    public func fetchWeather(lat: Double, long: Double) -> AnyPublisher<ForecastWeather, Error> {
        return requestCall(requestURL: APIAdress.currentWeather(lat: lat, long: long))
    }

    public func fetchSevenDaysWeather() -> AnyPublisher<ForecastWeather, Error> {
        return requestCall(requestURL: APIAdress.sevenDaysWeather)
    }
}

private extension Networking {
    func requestCall<RES: Decodable>(requestURL: APIAdress) -> AnyPublisher<RES, Error> {
        guard let url = URL(string: requestURL.url) else {
            fatalError("invalid error")
        }

        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
            .print()
            .decode(type: RES.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .delay(for: .seconds(3), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
