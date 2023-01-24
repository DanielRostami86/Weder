//
//  DashboardHeaderView.swift
//  Weder
//
//  Created by Daniel Rostami on 13/8/2022.
//

import SwiftUI

public enum Page {
    case dashboard
    case nextFourDays

    var titleIconName: String {
        switch self {
        case .dashboard:
            return "location.circle.fill"
        case .nextFourDays:
            return "calendar"
        }
    }

    var leftIconName: String {
        switch self {
        case .dashboard:
            return "circle.grid.2x2"
        case .nextFourDays:
            return "chevron.left"
        }
    }
}

struct NavigationBarView: View {
    var title: String
    var page: Page
    var hasRightIcon: Bool = true

    var leftButtonPressed: (() -> Void)?

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.clear, strokeBorder: .tertiary)
                    .frame(width: 45, height: 45)
                Image(systemName: page.leftIconName)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        leftButtonPressed?()
                    }
            }

            Spacer()
            NavigationTitleView(title: title, page: page)
                .offset(x: -8)
            Spacer()

            Image(systemName: Constant.ellipsis)
                .frame(width: 45, height: 45)
                .rotationEffect(.degrees(90))
                .disabled(!hasRightIcon)
                .opacity(hasRightIcon ? 1 : 0)
                .hidden()
        }
        .foregroundColor(.primary)
    }

    enum Constant {
        static let ellipsis = "ellipsis"
    }
}

struct NavigationTitleView: View {
    var title: String
    var page: Page

    var body: some View {
        HStack {
            Image(systemName: page.titleIconName)
                .frame(width: 25, height: 25)
            Text(title)
                .font(.title)
                .bold()
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(title: "Tehran", page: .dashboard)
            .padding()
            .preferredColorScheme(.dark)

        NavigationBarView(title: "Tehran", page: .nextFourDays)
            .padding()
            .preferredColorScheme(.light)
    }
}
