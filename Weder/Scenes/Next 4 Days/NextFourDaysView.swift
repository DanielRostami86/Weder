//
//  NextSevenDaysView.swift
//  Weder
//
//  Created by Daniel Rostami on 13/8/2022.
//

import SwiftUI

struct NextFourDaysView: View {
    
    @EnvironmentObject var viewModel: WeatherForecastViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.primary
                    .edgesIgnoringSafeArea(.all)
                    .colorInvert()
                VStack {
                    NavigationBarView(title: "4 days", page: .nextFourDays, hasRightIcon: false) {
                        viewModel.isFourDayActive = false
                    }
                    .padding()
                    ScrollView {
                        VStack {
                            NextFourDayHeaderView(tomorrowWeather: viewModel.tomorrowWeather)
                                .frame(height: geometry.size.height * 0.5)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(.gray)
                                .opacity(0.08)
                        )
                        ForEach(viewModel.nextDaysWeather) { nextDay in
                            DailyForecastView(weekdayName: nextDay.weekday, dailyWeather: nextDay.forcast)
                                .listRowBackground(Color.clear)
                                .padding()
                        }
                    }
                }
            }
        }
    }
}

struct NextFourDayHeaderView: View {
    
    var tomorrowWeather: CurrentWeather?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                HStack {
                    if let icon = tomorrowWeather?.icon {
                        Image(WeatherCondtion.getConditionFromIcon(icon).imageName)
                            .resizable()
                            .frame(width: weatherImageWidth(size: geometry.size),
                                   height: weatherImageWidth(size: geometry.size))
                    }
                    Spacer()
                    VStack {
                        Text("Tomorrow")
                            .font(.title)
                        HStack {
                            Text(String(Int(tomorrowWeather?.tempMax ?? 0)))
                                .font(.system(size: 80))
                                .bold()
                            Text("/")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.secondary)
                            Text(String(Int(tomorrowWeather?.tempMin ?? 0)))
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.secondary)
                        }
                        Text(tomorrowWeather?.description.capitalized ?? "Empty")
                            .foregroundColor(.secondary)
                            .font(.body)
                            .bold()
                    }
                }
                .shadow(color: .primary, radius: 100, x: -30, y: 0)
                .padding()
                WindHumidityRainView(weather: tomorrowWeather?.windHumidityRain)
            }
        }
    }
    
    private func weatherImageWidth(size: CGSize) -> CGFloat {
        return size.width * 0.35
    }
}

struct DailyForecastView: View {
    
    var weekdayName: String = "Mon"
    var dailyWeather: CurrentWeather = .sample()
    
    var body: some View {
        HStack {
            Text(weekdayName)
                .bold()
                .foregroundColor(.primary)
                .font(.title3)
            Spacer()
            VStack {
                Image(WeatherCondtion.getConditionFromIcon(dailyWeather.icon).imageName)
                    .resizable()
                    .frame(width: 30, height: 30)
                Text(dailyWeather.description.capitalized)
                    .bold()
                    .font(.subheadline)
            }
            Spacer()
            VStack(spacing: 0) {
                TempratureView(temp: dailyWeather.tempMax)
                    .foregroundColor(.primary)
                TempratureView(temp: dailyWeather.tempMin)
                    .font(.title2)
            }
        }
        .foregroundColor(.secondary)
    }
}

struct TempratureView: View {
    var temp: Double
    var body: some View {
        HStack {
            Text(String(Int(temp)))
                .font(.title3)
                .bold()
            Text("⚬")
                .font(.subheadline)
                .offset(x: -8, y: -8)
        }
    }
}

struct NextFourDaysView_Previews: PreviewProvider {
    
    static var viewModel: WeatherForecastViewModel {
        let viewModel = WeatherForecastViewModel()
        viewModel.tomorrowWeather = .sample()
        viewModel.nextDaysWeather = [.init(forcast: .sample(), weekday: "Mon"),
                                     .init(forcast: .sample(), weekday: "Mon"),
                                     .init(forcast: .sample(), weekday: "Mon")]
        return viewModel
    }
    
    static var previews: some View {
        Group {
            NextFourDaysView()
                .preferredDevice(.iPhoneSE, colorScheme: .dark)
        }
        .environmentObject(viewModel)
    }
}
