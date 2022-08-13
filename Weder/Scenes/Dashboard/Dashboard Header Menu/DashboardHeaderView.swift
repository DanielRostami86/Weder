//
//  DashboardHeaderView.swift
//  Weder
//
//  Created by Daniel Rostami on 13/8/2022.
//

import SwiftUI

struct DashboardHeaderView: View {
    
    var city: String
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.clear, strokeBorder: .tertiary)
                    .frame(width: 45, height: 45)
                Image(systemName: Constant.circleGridIcon)
                    .frame(width: 30, height: 30)
            }
            Spacer()
            HStack {
                Image(systemName: Constant.locationCircle)
                    .frame(width: 25, height: 25)
                Text(city)
                    .font(.title)
                    .bold()
            }
            .offset(x: -8)
            Spacer()
            Image(systemName: Constant.ellipsis)
                .frame(width: 45, height: 45)
                .rotationEffect(.degrees(90))
        }
        .foregroundColor(.primary)
    }
    
    enum Constant {
        static let circleGridIcon = "circle.grid.2x2"
        static let locationCircle = "location.circle.fill"
        static let ellipsis = "ellipsis"
    }
}


struct DashboardHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardHeaderView(city: "Tehran")
            .padding()
            .preferredColorScheme(.dark)
        
        DashboardHeaderView(city: "Tehran")
            .padding()
            .preferredColorScheme(.light)
    }
}
