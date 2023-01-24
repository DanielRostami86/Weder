//
//  ShimmeringView.swift
//  Weder
//
//  Created by Daniel Rostami on 19/1/2023.
//

import Foundation
import SwiftUI

public struct ShimmerView: View {
    private enum Constants {
        static let duration: Double = 0.9
        static let minOpacity: Double = 0.25
        static let maxOpacity: Double = 1.0
        static let cornerRadius: CGFloat = 2.0
    }

    @State private var opacity: Double = Constants.minOpacity

    public init() {}

    public var body: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color.gray)
            .opacity(opacity)
            .transition(.opacity)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: Constants.duration)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = Constants.maxOpacity
                }
            }
    }
}

// public struct ShimmerModifier: ViewModifier {
//    public func body(content: Content) -> some View {
//
//    }
// }

public struct ShimmerModifier: ViewModifier {
    public func body(content _: Content) -> some View {
        ShimmerView()
    }
}

public extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}
