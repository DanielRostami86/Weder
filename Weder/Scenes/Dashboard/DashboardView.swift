//
//  DashboardView.swift
//  WeDer
//
//  Created by Daniel Rostami on 6/8/2022.
//

import SwiftUI
import UIKit

struct DashboardView: View {
    @StateObject var viewModel: WeatherForecastViewModel
    @StateObject var locationManager = LocationManager()

    @ViewBuilder
    var dashboardContent: some View {
        if viewModel.currentWeather != nil {
            GeometryReader { geometry in
                ZStack {
                    Color.primary
                        .edgesIgnoringSafeArea(.all)
                        .colorInvert()
                    VStack {
                        ScrollView {
                            VStack(alignment: .center, spacing: 10) {
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
                                    NextSevenDayLinkView
                                        .padding(.horizontal, 16)
                                }

                                HStack {
                                    HourlyWeatherView(temp: 21, condition: "rainy", hour: 11)
                                    HourlyWeatherView(temp: 27, condition: "cloudy", hour: 13)
                                    HourlyWeatherView(temp: -3, condition: "rainy", hour: 15)
                                    HourlyWeatherView(temp: 31, condition: "thunder", hour: 18)
                                }
                                Spacer()
                            }
                            .offset(y: 10)
                        }
                    }
                    .padding(.top, 75)
                    VStack {
                        NavigationBarView(title: viewModel.currentWeather?.city ?? "", page: .dashboard)
                            .padding()
                        Spacer()
                    }
                    .foregroundColor(.primary)
                    .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.9))
                }
            }
        } else {
            DashboardPlaceholder()
        }
    }

    var body: some View {
        dashboardContent
            .onChange(of: locationManager.lastLocation, perform: { newValue in
                viewModel.fetchWeather(lat: newValue?.coordinate.latitude, long: newValue?.coordinate.longitude)
            })

            .alert("Enexpected Error", isPresented: $viewModel.hasError) {}
    }

    @ViewBuilder
    private var NextSevenDayLinkView: some View {
        HStack {
            Text("Today \(viewModel.debugTitle)")
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
                self.viewModel.isFourDayActive.toggle()
            }
        }
        .padding()
    }

    private func weatherImageWidth(size: CGSize) -> CGFloat {
        return size.height * 0.15
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
            DashboardView(viewModel: viewModel)
                .preferredDevice(.iPhone8, colorScheme: .light)
        }
    }
}
