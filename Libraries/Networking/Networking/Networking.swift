//
//  Networking.swift
//  Weder
//
//  Created by Daniel Rostami on 14/8/2022.
//

import Foundation
import Combine

public class Networking: APIHelper {

    public static let shared = Networking()
    
    public func fetchWeather(lat: Double, long: Double) -> AnyPublisher<CurrentWeather, Error> {
        return requestCall(requestURL: APIAdress.currentWeather(lat: lat, long: long))
    }
    
    public func fetchSevenDaysWeather() -> AnyPublisher<CurrentWeather, Error> {
        return requestCall(requestURL: APIAdress.sevenDaysWeather)
    }
}

private extension Networking {
    func requestCall<RES: Decodable>(requestURL: APIAdress) -> AnyPublisher<RES, Error> {
        
        guard let url = URL.init(string: requestURL.url) else {
            fatalError("invalid error")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url).map({ $0.data })
            .print()
            .decode(type: RES.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
