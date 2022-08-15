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
    
    @Published var loading: LoadingStatus = .loading
    @Published var weather: ForecastWeather?
    @Published var error: Error?
    @Published var hasError: Bool = false
    private let networking = Networking.shared
    private var cancellable: AnyCancellable?
    
    init() {
        fetchWeather(lat: -33.922520, long: 151.204100)
    }
    
    func fetchWeather(lat: Double, long: Double) {
        cancellable = networking.fetchWeather(lat: lat, long: long)
            .sink(receiveCompletion: { errorResponse in
                switch errorResponse {
                case .failure(let error):
                    self.loading = .failed
                    self.error = error
                    self.hasError = true
                case .finished:
                    break
                }
            }, receiveValue: { weatherResponse in
                self.loading = .done
                self.weather = weatherResponse
            })
    }
}
