//
//  DashboardView.swift
//  WeDer
//
//  Created by Daniel Rostami on 6/8/2022.
//

import SwiftUI
import UIKit

struct DashboardView: View {
    
    @ObservedObject var viewModel: WeatherForecastViewModel
    @ObservedObject var locationManager = LocationManager()
    
    @ViewBuilder var dashboardContent: some View {
        if locationManager.lastLocation != nil {
            GeometryReader { geometry in
                ZStack {
                    Color.primary
                        .edgesIgnoringSafeArea(.all)
                        .colorInvert()
                    VStack(alignment: .center, spacing: 10) {
                        NavigationBarView(title: viewModel.currentWeather?.city ?? "", page: .dashboard)
                        DashboardLoadingStatus(loadingStatus: viewModel.loading)
                        if let icon = viewModel.currentWeather?.icon {
                            Image(WeatherCondtion.getConditionFromIcon(icon).imageName)
                                .resizable()
                                .frame(width: weatherImageWidth(size: geometry.size),
                                       height: weatherImageWidth(size: geometry.size))
                                .shadow(color: .primary, radius: 100, x: 0, y: 0)
                        }
                        VStack(spacing: 0) {
                            HStack(alignment: .top) {
                                if let temp = viewModel.currentWeather?.temp {
                                    Text(String(Int(temp)))
                                        .font(.system(size: 90))
                                        .bold()
                                    Text("°")
                                        .font(.largeTitle)
                                        .offset(x: -8, y: 8)
                                }
                            }
                            .offset(x: 8)
                            if let desc = viewModel.currentWeather?.description {
                                Text(desc.capitalized)
                                    .foregroundColor(.gray)
                                    .font(.title2)
                            }
                        }
                        Spacer()
                        WindHumidityRainView(weather: viewModel.currentWeather?.windHumidityRain ?? .sample())
                        NavigationLink(isActive: $viewModel.isFourDayActive) {
                            NextFourDaysView()
                                .environmentObject(viewModel)
                                .navigationBarHidden(true)
                        } label: {
                            NextSevenDayLinkView {
                                self.viewModel.isFourDayActive.toggle()
                            }
                        }
                        
                        HStack {
                            HourlyWeatherView(temp: 21, condition: "rainy", hour: 11)
                            HourlyWeatherView(temp: 27, condition: "cloudy", hour: 13)
                            HourlyWeatherView(temp: -3, condition: "rainy", hour: 15)
                            HourlyWeatherView(temp: 31, condition: "thunder", hour: 18)
                        }
                        Spacer()
                    }
                    .foregroundColor(.primary)
                    .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.9))
                    .padding()
                }
            }
        } else {
            Text("Location Neded")
                .onTapGesture {
                    locationManager.requestForLocation()
                }
        }
    }
    
    var body: some View {
        dashboardContent
        .onReceive(locationManager.$lastLocation, perform: { lastLocation in
            if let lastLocation = lastLocation {
                viewModel.fetchWeather(lat: lastLocation.coordinate.latitude, long: lastLocation.coordinate.longitude)
            }
        })
        .alert("Enexpected Error", isPresented: $viewModel.hasError) { }
    }
    
    private func weatherImageWidth(size: CGSize) -> CGFloat {
        return size.height * 0.2
    }
}

struct NextSevenDayLinkView: View {
    
    var tapped: (() -> Void)
    
    var body: some View {
        HStack {
            Text("Today")
                .font(.title2)
                .bold()
            Spacer()
            HStack {
                Text("4 days")
                    .bold()
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.secondary)
            }
            .foregroundColor(.secondary)
            .onTapGesture {
                tapped()
            }
        }
        .padding()
    }
}

struct DashboardView_Previews: PreviewProvider {
    
    static var viewModel: WeatherForecastViewModel {
        let viewModel = WeatherForecastViewModel()
        viewModel.currentWeather = .sample()
        return viewModel
    }
    
    static var previews: some View {
        Group {
            DashboardView(viewModel: viewModel)
                .preferredDevice(.iPhoneSE, colorScheme: .dark)
            DashboardView(viewModel: viewModel)
                .preferredDevice(.iPhone12Pro, colorScheme: .light)
        }
    }
}
