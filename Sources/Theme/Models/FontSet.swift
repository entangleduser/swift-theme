//
//  File.swift
//  
//
//  Created by neutralradiance on 11/9/20.
//

import Foundation

public struct FontSet: Codable {
    public var name: String = "Menlo"
    public var size: Float = 13
    public init(name: String = "Menlo", size: Float = 13) {
        self.name = name
        self.size = size
    }
}

#if canImport(SwiftUI)
import SwiftUI
#if os(macOS)
public typealias NativeFont = NSFont
#elseif os(iOS)
public typealias NativeFont = UIFont
#endif

extension FontSet {
    public var font: NativeFont {
        NativeFont(name: name, size: CGFloat(size)) ?? .systemFont(ofSize: CGFloat(size))
    }
}
#endif
