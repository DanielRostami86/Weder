//
//  View+Ext.swift
//  Weder
//
//  Created by Daniel Rostami on 13/8/2022.
//

import Foundation
import SwiftUI

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

struct DevicePreferences: ViewModifier {
    var device: SimulatorDevice
    var colorScheme: ColorScheme

    func body(content: Content) -> some View {
       content
            .preferredColorScheme(colorScheme)
            .previewDevice(PreviewDevice(rawValue: device.displayName))
            .previewDisplayName(device.displayName)
    }
}

extension View {
    func preferredDevice(_ device: SimulatorDevice, colorScheme: ColorScheme) -> some View {
        modifier(DevicePreferences(device: device, colorScheme: colorScheme))
    }
}

public enum SimulatorDevice {
    case iPodTouch
    case iPhone8
    case iPhoneSE
    case iPhone12Mini
    case iPhone12
    case iPhone12Pro
    case iPhone12ProMax

    var displayName: String {
        switch self {
        case .iPodTouch:
            return "iPod Touch"
        case .iPhone8:
            return "iPhone 8"
        case .iPhoneSE:
            return "iPhone SE"
        case .iPhone12Mini:
            return "iPhone 12 Mini"
        case .iPhone12:
            return "iPhone 12"
        case .iPhone12Pro:
            return "iPhone 12 Pro"
        case .iPhone12ProMax:
            return "iPhone 12 Pro Max"
        }
    }
}
