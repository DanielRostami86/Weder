//
//  WindHumidityRainView.swift
//  Weder
//
//  Created by Daniel Rostami on 13/8/2022.
//

import NetworkProvider
import SwiftUI

public enum WindHumidityRain {
    case wind(Int?)
    case humidity(Int?)
    case rain(Int?)

    var title: String {
        switch self {
        case .wind:
            return "Wind"
        case .humidity:
            return "Humidity"
        case .rain:
            return "Rain"
        }
    }

    var imageName: String {
        switch self {
        case .wind:
            return "wind.snow"
        case .humidity:
            return "drop.fill"
        case .rain:
            return "cloud.rain"
        }
    }

    var displayValue: String {
        switch self {
        case let .wind(wind):
            return "\(wind ?? 0) km/h"
        case let .humidity(humidity):
            return "\(humidity ?? 0)%"
        case let .rain(rain):
            return "\(rain ?? 0)%"
        }
    }

    var foreGroundColor: Color {
        switch self {
        case .wind, .rain:
            return .primary
        case .humidity:
            return .blue
        }
    }
}

struct WindHumidityRainView: View {
    var weather: WindHumidityRainModel?

    var body: some View {
        HStack(spacing: 35) {
            WindHumidityRainChild(data: .wind(Int(weather?.wind ?? 0)))
            HorizontalSeparator()
            WindHumidityRainChild(data: .humidity(weather?.humidity ?? 0))
            HorizontalSeparator()
            WindHumidityRainChild(data: .rain(14)) // Fixme no api for it
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 16)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.rectangleCornerRadious)
                .foregroundColor(.gray)
                .opacity(0.15)
        )
    }

    enum Constants {
        static let statusSize: CGFloat = 10
        static let rectangleCornerRadious: CGFloat = 25
        static let rectangleLineWidth: CGFloat = 0.5
    }
}

struct HorizontalSeparator: View {
    var height: CGFloat = 40

    var body: some View {
        Rectangle()
            .frame(width: 1, height: height)
            .opacity(0.3)
    }
}

struct WindHumidityRainChild: View {
    var data: WindHumidityRain

    var body: some View {
        VStack {
            Image(systemName: data.imageName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(data.foreGroundColor)
            Text(data.displayValue)
                .font(.callout)
                .bold()
            Text(data.title)
                .foregroundColor(.gray)
                .font(.callout)
        }
        .foregroundColor(.primary)
    }
}

struct WindHumidityRainView_Previews: PreviewProvider {
    static var previews: some View {
        WindHumidityRainView(weather: .sample())
            .preferredDevice(.iPhone8, colorScheme: .dark)
        WindHumidityRainView(weather: .sample())
            .preferredColorScheme(.light)
    }
}
