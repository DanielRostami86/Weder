//
//  HourlyWeatherView.swift
//  Weder
//
//  Created by Daniel Rostami on 13/8/2022.
//

import SwiftUI

public enum WeatherCondtion {
    
    case sunny
    case rainy
    case cloudy
    case slow
    case thunder
    case storm
    
    var title: String {
        switch self {
        case .sunny:
            return "Sunny"
        case .rainy:
            return "Rainy"
        case .cloudy:
            return "Cloudy"
        case .slow:
            return "Slow"
        case .thunder:
            return "Thunder"
        case .storm:
            return "Storm"
        }
    }
    
    var imageName: String {
        switch self {
        case .sunny:
            return ""
        case .rainy:
            return "rainy"
        case .cloudy:
            return "cloudy"
        case .slow:
            return ""
        case .thunder:
            return "thundery"
        case .storm:
            return ""
        }
    }
    

    static func getCondition(condition: String) -> WeatherCondtion {
        switch condition {
        case "rainy":
            return .rainy
        case "cloudy":
            return.cloudy
        case "thunder":
            return .thunder
        default:
            return .sunny
        }
    }
}

struct HourlyWeatherView: View {
    
    var temp: Double
    var condition: String
    var hour: Int
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(Int(temp)) °")
                    .font(.body)
                    .bold()
                    .foregroundColor(.primary)
                Image(WeatherCondtion.getCondition(condition: condition).imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("\(hour):00")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.gray)
                    .opacity(0.15)
            }
        }
    }
}

struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            HourlyWeatherView(temp: 21, condition: "rainy", hour: 11)
            HourlyWeatherView(temp: 27, condition: "cloudy", hour: 13)
            HourlyWeatherView(temp: -3, condition: "rainy", hour: 15)
            HourlyWeatherView(temp: 31, condition: "thunder", hour: 18)
        }
        .preferredColorScheme(.dark)
    }
}
