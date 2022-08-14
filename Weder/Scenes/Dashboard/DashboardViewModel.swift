//
//  DashboardViewModdl.swift
//  Weder
//
//  Created by Daniel Rostami on 14/8/2022.
//

import Foundation
import Networking
import Combine

class DashboardViewModel: ObservableObject {
    
    @Published var weather: CurrentWeather?
    @Published var error: Error?
    private let networking = Networking.shared
    private var cancellable: AnyCancellable?
    
    init() {
        fetchWeather(lat: -33.922520, long: 151.204100)
    }
    
    func fetchWeather(lat: Double, long: Double) {
                
        cancellable = networking.fetchWeather(lat: lat, long: long)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { weatherResponse in
                self.weather = weatherResponse
            })
    }
}
