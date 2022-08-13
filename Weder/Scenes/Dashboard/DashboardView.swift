//
//  DashboardView.swift
//  WeDer
//
//  Created by Daniel Rostami on 6/8/2022.
//

import SwiftUI
import UIKit

struct DashboardView: View {
    
    @State private var isSevenDayActive = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.primary
                    .edgesIgnoringSafeArea(.all)
                    .colorInvert()
                VStack(alignment: .center, spacing: 10) {
                    DashboardHeaderView(city: "Tehran")
                    DashboardLoadingStatus(loadingStatus: .done)
                    Image("cloudy")
                        .resizable()
                        .frame(width: weatherImageWidth(size: geometry.size),
                               height: weatherImageWidth(size: geometry.size))
                        .shadow(color: .primary, radius: 100, x: 0, y: 0)
                    VStack(spacing: 0) {
                        HStack(alignment: .top) {
                            Text("20")
                                .font(.system(size: 90))
                                .bold()
                            Text("°")
                                .font(.largeTitle)
                                .offset(x: -8, y: 8)
                        }
                        .offset(x: 8)
                        Text("Weather condition")
                            .foregroundColor(.gray)
                            .font(.title2)
                    }
                    Spacer()
                    WindHumidityRainView(weather: .sample())
                    NavigationLink(isActive: $isSevenDayActive) {
                        NextSevenDaysView()
                    } label: {
                        NextSevenDayLinkView {
                            self.isSevenDayActive.toggle()
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
                .padding()
            }
        }
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
            Spacer()
            HStack {
                Text("7 days")
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 10, height: 10)
            }   .onTapGesture {
                tapped()
            }
        }
        .padding()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
                .preferredColorScheme(.light)
                .previewDevice(PreviewDevice(rawValue: "iPod touch"))
                .previewDisplayName("iPhone SE")
            DashboardView()
                .preferredColorScheme(.dark)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                .previewDisplayName("iPhone 12 Pro Max")
        }
    }
}
