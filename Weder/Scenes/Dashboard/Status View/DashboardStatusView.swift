//
//  DynamicWidthView.swift
//  Weder
//
//  Created by Behnam on 8/8/22.
//

import SnapKit
import SwiftUI

public enum LoadingStatus {
    case loading, done, failed

    var updatingTitle: String {
        switch self {
        case .loading:
            return "Updating"
        case .done:
            return "Live"
        case .failed:
            return "Offline"
        }
    }

    var statusColor: Color {
        switch self {
        case .loading:
            return Color.yellow
        case .done:
            return Color.green
        case .failed:
            return Color.red
        }
    }
}

struct DashboardLoadingStatus: View {
    var loadingStatus: LoadingStatus

    var body: some View {
        HStack {
            Circle()
                .frame(width: Constants.statusSize, height: Constants.statusSize)
                .foregroundColor(loadingStatus.statusColor)
            Text(loadingStatus.updatingTitle)
        }
        .font(.system(size: 18)) // FixMe Font Class needed
        .padding(.vertical, 5)
        .padding(.horizontal, 16)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.rectangleCornerRadious)
                .stroke(Color.primary, lineWidth: Constants.rectangleLineWidth)
        )
    }

    enum Constants {
        static let statusSize: CGFloat = 10
        static let rectangleCornerRadious: CGFloat = 25
        static let rectangleLineWidth: CGFloat = 0.5
    }
}

struct DashboardLoadingStatus_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DashboardLoadingStatus(loadingStatus: .done)
            DashboardLoadingStatus(loadingStatus: .loading)
            DashboardLoadingStatus(loadingStatus: .failed)
        }
        .preferredColorScheme(.dark)

        VStack {
            DashboardLoadingStatus(loadingStatus: .done)
            DashboardLoadingStatus(loadingStatus: .loading)
            DashboardLoadingStatus(loadingStatus: .failed)
        }
        .preferredColorScheme(.light)
    }
}
