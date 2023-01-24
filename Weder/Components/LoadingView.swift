//
//  LoadingView.swift
//  Weder
//
//  Created by Daniel Rostami on 19/1/2023.
//

import Foundation
import SwiftUI

struct DashboardPlaceholder: View {
    public var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("23dfasdf")
                .font(.system(size: 35))
            WeatherPlaceholder()
            HStack {
                WeatherPlaceholder()
                WeatherPlaceholder()
                WeatherPlaceholder()
            }
        }

        .padding(.top, 100)
        .redacted(reason: .placeholder)
    }
}

struct DashboardPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        DashboardPlaceholder()
            .previewLayout(.sizeThatFits)
    }
}

struct WeatherPlaceholder: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center, spacing: 0) {
                Image(systemName: "ellipsis")
                    .resizable()
                    .accessibilityHidden(true)
                    .frame(width: proxy.size.width * 0.4, height: proxy.size.width * 0.4)
                    .shimmer()
                    .padding(.bottom, 6)


                Group {
                    Text("23")
                        .font(.system(size: 40))
                        .padding(.vertical, 8.0)
                        .dynamicTypeSize(.medium)
                        .accessibilityHidden(true)


                    Text("really")
                        .font(.system(size: 28))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                        .accessibilityHidden(true)

                }
            }
        }
        .padding()
    }
}
