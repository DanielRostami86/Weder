//
//  DashboardView.swift
//  WeDer
//
//  Created by Daniel Rostami on 6/8/2022.
//

import SwiftUI

enum LoadingStatus {
    case loading, done, failed
    
    var updatingTitle: String {
        switch self {
        case .loading:
            return "Updating"
        case .done:
            return "Live"
        case .failed:
            return "Not live"
        }
    }
}

struct DashboardView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                DashboardHeaderView(city: "Tehran")
                DashboardStatusView(status: .failed)
                    .frame(height:50)
                Spacer()
                
            }
            .padding()
        }
    }
}

struct DashboardHeaderView: View {
    
    var city: String
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.clear, strokeBorder: .tertiary)
                    .frame(width: 45, height: 45)
                Image(systemName: "circle.grid.2x2")
                    .frame(width: 30, height: 30)
            }
            Spacer()
            HStack {
                Image(systemName: "location.circle.fill")
                    .frame(width: 25, height: 25)
                Text(city)
                    .font(.title)
                    .bold()
            }
            .offset(x: -8)
            Spacer()
            Image(systemName: "ellipsis")
                .frame(width: 45, height: 45)
                .rotationEffect(.degrees(90))
        }
        .foregroundColor(.white)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

extension Shape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: Double = 1) -> some View {
        self
            .stroke(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}

extension InsettableShape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: Double = 1) -> some View {
        self
            .strokeBorder(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}
