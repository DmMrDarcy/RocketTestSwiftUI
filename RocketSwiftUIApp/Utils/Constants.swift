//
//  Constants.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import SwiftUI

enum CustomFonts {
    case title
    case title2
    case title3
    case callout
    case caption
    case caption2
    case subheadline
    case headline
    case custom(size: CGFloat)
    
    var font: Font {
        switch self {
        case .title:
            return .custom("LabGrotesque-Regular", size: 30, relativeTo: .title)
        case .title2:
            return .custom("LabGrotesque-Regular", size: 24, relativeTo: .title2)
        case .title3:
            return .custom("LabGrotesque-Regular", size: 20, relativeTo: .title3)
        case .callout:
            return .custom("LabGrotesque-Regular", size: 16, relativeTo: .callout)
        case .caption:
            return .custom("LabGrotesque-Regular", size: 12, relativeTo: .caption)
        case .caption2:
            return .custom("LabGrotesque-Regular", size: 10, relativeTo: .caption2)
        case .subheadline:
            return .custom("LabGrotesque-Regular", size: 14, relativeTo: .subheadline)
        case .headline:
            return .custom("LabGrotesque-Regular", size: 18, relativeTo: .headline)
        case .custom(let size):
            return .custom("LabGrotesque-Regular", size: size)
        }
    }
    
    var medium: Font {
        switch self {
        case .title:
            return .custom("LabGrotesque-Medium", size: 30, relativeTo: .title)
        case .title2:
            return .custom("LabGrotesque-Medium", size: 24, relativeTo: .title2)
        case .title3:
            return .custom("LabGrotesque-Medium", size: 20, relativeTo: .title3)
        case .callout:
            return .custom("LabGrotesque-Medium", size: 16, relativeTo: .callout)
        case .caption:
            return .custom("LabGrotesque-Medium", size: 12, relativeTo: .caption)
        case .caption2:
            return .custom("LabGrotesque-Medium", size: 10, relativeTo: .caption2)
        case .subheadline:
            return .custom("LabGrotesque-Medium", size: 14, relativeTo: .subheadline)
        case .headline:
            return .custom("LabGrotesque-Medium", size: 18, relativeTo: .headline)
        case .custom(let size):
            return .custom("LabGrotesque-Medium", size: size)
        }
    }
    
    var bold: Font {
        switch self {
        case .title:
            return .custom("LabGrotesque-Bold", size: 30, relativeTo: .title)
        case .title2:
            return .custom("LabGrotesque-Bold", size: 24, relativeTo: .title2)
        case .title3:
            return .custom("LabGrotesque-Bold", size: 20, relativeTo: .title3)
        case .callout:
            return .custom("LabGrotesque-Bold", size: 16, relativeTo: .callout)
        case .caption:
            return .custom("LabGrotesque-Bold", size: 12, relativeTo: .caption)
        case .caption2:
            return .custom("LabGrotesque-Bold", size: 10, relativeTo: .caption2)
        case .subheadline:
            return .custom("LabGrotesque-Bold", size: 14, relativeTo: .subheadline)
        case .headline:
            return .custom("LabGrotesque-Bold", size: 18, relativeTo: .headline)
        case .custom(let size):
            return .custom("LabGrotesque-Bold", size: size)
        }
    }
    
    var light: Font {
        switch self {
        case .title:
            return .custom("LabGrotesque-Light", size: 30, relativeTo: .title)
        case .title2:
            return .custom("LabGrotesque-Light", size: 24, relativeTo: .title2)
        case .title3:
            return .custom("LabGrotesque-Light", size: 20, relativeTo: .title3)
        case .callout:
            return .custom("LabGrotesque-Light", size: 16, relativeTo: .callout)
        case .caption:
            return .custom("LabGrotesque-Light", size: 12, relativeTo: .caption)
        case .caption2:
            return .custom("LabGrotesque-Light", size: 10, relativeTo: .caption2)
        case .subheadline:
            return .custom("LabGrotesque-Light", size: 14, relativeTo: .subheadline)
        case .headline:
            return .custom("LabGrotesque-Light", size: 18, relativeTo: .headline)
        case .custom(let size):
            return .custom("LabGrotesque-Light", size: size)
        }
    }
}
