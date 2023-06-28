//
//  DashboardViewModdl.swift
//  Weder
//
//  Created by Daniel Rostami on 14/8/2022.
//

import Combine
import Foundation
import NetworkProvider

typealias Forecast = ForecastWeather.Forecast

public struct NextDayWeather: Hashable, Identifiable {
    public static func == (lhs: NextDayWeather, rhs: NextDayWeather) -> Bool {
        return lhs.forcast.id == rhs.forcast.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(forcast.id)
    }

    public let forcast: CurrentWeather
    public let weekday: String
    public var id: String {
        return UUID().uuidString
    }
}

class WeatherForecastViewModel: ObservableObject {
    @Published var isFourDayActive = false
    @Published var loading: LoadingStatus = .loading
    @Published var currentWeather: CurrentWeather?
    @Published var tomorrowWeather: CurrentWeather?
    @Published var nextDaysWeather = [NextDayWeather]()
    @Published var error: Error?
    @Published var hasError: Bool = false

    private var weather: ForecastWeather?
    private var groupedWeather = [(forecast: [Forecast], date: Date)]()
    private let networking = Networking.shared
    private var cancellable: AnyCancellable?

    func fetchWeather(lat: Double?, long: Double?) {
        guard let lat = lat, let long = long else { return }
        cancellable = networking.fetchWeather(lat: lat, long: long)
            .sink(receiveCompletion: { errorResponse in
                switch errorResponse {
                case let .failure(error):
                    self.loading = .failed
                    self.error = error
                    self.hasError = true
                case .finished:
                    break
                }
            }, receiveValue: { weatherResponse in

                self.loading = .done
                self.weather = weatherResponse
                self.makeWeatherGroupByDate()
                self.currentWeather = self.makeTodayWeather()
                self.tomorrowWeather = self.makeTomorrowWeather()
                self.makeNextDayswWeather()
            })
    }

    private func makeTodayWeather() -> CurrentWeather {
        guard let today = groupedWeather.first else { return CurrentWeather.sample() }
        return makeWeatherModel(for: today.forecast)
    }

    private func makeTomorrowWeather() -> CurrentWeather {
        let tomorrow = groupedWeather[1]
        return makeWeatherModel(for: tomorrow.forecast)
    }

    private func makeNextDayswWeather() {
        let nextDays = groupedWeather.dropFirst(2)
        nextDays.forEach { forecast, date in
            nextDaysWeather.append(.init(forcast: makeWeatherModel(for: forecast), weekday: getWeekdayNameByDate(date)))
        }
    }

    private func makeWeatherModel(for forecast: [Forecast]) -> CurrentWeather {
        let city = weather?.city?.name ?? ""
        let tempAverage = forecast.compactMap { $0.main }.compactMap { $0.temp }.average
        let tempMinAverage = forecast.compactMap { $0.main }.compactMap { $0.temp_min }.average
        let tempMaxAverage = forecast.compactMap { $0.main }.compactMap { $0.temp_max }.average
        let averageIcon = forecast.compactMap { $0.firstWeather }.compactMap { $0.icon }.mode ?? ""
        let windAverage = forecast.compactMap { $0.wind }.compactMap { $0.speed }.average
        let humidtyAverage = forecast.compactMap { $0.main }.compactMap { $0.humidity }.average
        let descAverage = forecast.compactMap { $0.firstWeather }.compactMap { $0.description }.mode ?? ""
        let rainAverage = 20.0 // we dont have this data
        return CurrentWeather(city: city, temp: tempAverage, icon: averageIcon,
                              windHumidityRain: .init(wind: windAverage, humidity: humidtyAverage, rain: rainAverage),
                              description: descAverage, tempMin: tempMinAverage, tempMax: tempMaxAverage)
    }

    private func makeWeatherGroupByDate() {
        guard let weather = weather, let forecasts = weather.list else { return }
        let dateGroup = Dictionary(grouping: forecasts, by: { $0.dateOnly })
        groupedWeather = dateGroup.map { date, forecasts in
            (forecasts, date)
        }
        groupedWeather.sort(by: { $0.date < $1.date })
        groupedWeather.removeAll(where: { $0.date < Date() }) // removing the forecast which date is past
    }

    private func getWeekdayNameByDate(_ date: Date) -> String {
        let cal = Calendar.current
        let comp = cal.dateComponents([.weekday], from: date)
        let weekDayName = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"]
        return weekDayName[(comp.weekday ?? 0) - 1]
    }

    var debugTitle: String {
        #if DEBUG
            return "debug"
        #else
            return "production"
        #endif
    }
}

public struct CurrentWeather: Identifiable {
    public let city: String
    public let temp: Double
    public let icon: String
    public let windHumidityRain: WindHumidityRainModel
    public let description: String
    public let tempMin: Double
    public let tempMax: Double

    public var id: String {
        return UUID().uuidString
    }

    public static func sample() -> CurrentWeather {
        return CurrentWeather(city: "Tehran", temp: 10, icon: "01d", windHumidityRain: .sample(),
                              description: "Cloudy", tempMin: 10, tempMax: 20)
    }
}

public struct WindHumidityRainModel {
    public let wind: Double
    public let humidity: Int
    public let rain: Double

    public static func sample() -> WindHumidityRainModel {
        return WindHumidityRainModel(wind: 9, humidity: 10, rain: 11)
    }
}
