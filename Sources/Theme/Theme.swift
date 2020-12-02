//
//  File.swift
//  
//
//  Created by William on 9/12/20.
//

import Foundation
import Light
import Yams

/// base16 theme
public struct Theme: Codable, Hashable, Identifiable {
    public var scheme: String
    public var author: String

    /// Default Background
    public var base00: String
    /// Lighter Background (Used for status bars)
    public var base01: String
    /// Selection Background
    public var base02: String
    /// Comments, Invisibles, Line Highlighting
    public var base03: String
    /// Dark Foreground (Used for status bars)
    public var base04: String
    /// Default Foreground, Caret, Delimiters, Operators
    public var base05: String
    /// Light Foreground (Not often used)
    public var base06: String
    /// Light Background (Not often used)
    public var base07: String
    /// Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    public var base08: String
    /// Integers, Boolean, Constants, XML Attributes, Markup Link Url
    public var base09: String
    /// Classes, Markup Bold, Search Text Background
    public var base0A: String
    /// Strings, Inherited Class, Markup Code, Diff Inserted
    public var base0B: String
    /// Support, Regular Expressions, Escape Characters, Markup Quotes
    public var base0C: String
    /// Functions, Methods, Attribute IDs, Headings
    public var base0D: String
    /// Keywords, Storage, Selector, Markup Italic, Diff Changed
    public var base0E: String
    /// Deprecated, Opening/Closing Embedded Language Tags, e.g. `<?php ?>`
    public var base0F: String
}

public extension Theme {
    init?(path: String) throws {
        do {
            guard let data = FileManager.default.contents(atPath: path) else { return nil }
            self = try YAMLDecoder().decode(Self.self, from: data)
        } catch {
            print(String(describing: error))
            return nil
        }
    }
    subscript(_ key: CodingKeys) -> String! {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self),
           let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: String] {
            return dictionary.first { $0.key == key.rawValue }?.value
        }
        return nil
    }
    subscript(_ index: Int?) -> NativeColor? {
        guard let index = index, (0..<15).contains(index) else { return nil }
        switch index {
            case 0: return background
            case 1: return secondaryBackground
            case 2: return tertiaryBackground
            case 3: return tertiaryForeground
            case 4: return secondaryForeground
            case 5: return foreground
            case 6: return quartenaryForeground
            case 7: return quartenaryBackground
            case 8: return variable
            case 9: return literal
            case 10: return type
            case 11: return string
            case 12: return support
            case 13: return function
            case 14: return keyword
            case 15: return deprecated
            default: return nil
        }
    }
    var id: UUID { UUID() }
    
    enum CodingKeys: String, CodingKey, CaseIterable, CustomStringConvertible {
        case
            scheme,
            author,
            base00,
            base01,
            base02,
            base03,
            base04,
            base05,
            base06,
            base07,
            base08,
            base09,
            base0A,
            base0B,
            base0C,
            base0D,
            base0E,
            base0F
        public var description: String {
            switch self {
                case .scheme: return "Scheme"
                case .author: return "Author"
                case .base00: return "Default Background"
                case .base01: return "Lighter Background (Used for status bars)"
                case .base02: return "Selection Background"
                case .base03: return "Comments, Invisibles, Line Highlighting"
                case .base04: return "Dark Foreground (Used for status bars)"
                case .base05: return "Default Foreground, Caret, Delimiters, Operators"
                case .base06: return "Light Foreground (Not often used)"
                case .base07: return "Light Background (Not often used)"
                case .base08: return "Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted"
                case .base09: return "Integers, Boolean, Constants, XML Attributes, Markup Link Url"
                case .base0A: return "Classes, Markup Bold, Search Text Background"
                case .base0B: return "Strings, Inherited Class, Markup Code, Diff Inserted"
                case .base0C: return "Support, Regular Expressions, Escape Characters, Markup Quotes"
                case .base0D: return "Functions, Methods, Attribute IDs, Headings"
                case .base0E: return "Keywords, Storage, Selector, Markup Italic, Diff Changed"
                case .base0F: return "Deprecated, Opening/Closing Embedded Language Tags, e.g. `<?php ?>`"
            }
        }
    }
}

public extension Theme {
    var background: NativeColor {
        NativeColor(hex: base00)! // 0
    }
    var secondaryBackground: NativeColor {
        NativeColor(hex: base01)! // 1
    }
    var tertiaryBackground: NativeColor {
        NativeColor(hex: base02)! // 2
    }
    var tertiaryForeground: NativeColor {
        NativeColor(hex: base03)! // 3
    }
    var secondaryForeground: NativeColor {
        NativeColor(hex: base04)! // 4
    }
    var foreground: NativeColor {
        NativeColor(hex: base05)! // 4
    }
    var quartenaryForeground: NativeColor {
        NativeColor(hex: base06)! // 6
    }
    var quartenaryBackground: NativeColor {
        NativeColor(hex: base07)! // 7
    }
    var variable: NativeColor {
        NativeColor(hex: base08)! // 8
    }
    var literal: NativeColor {
        NativeColor(hex: base09)! // 9
    }
    var type: NativeColor {
        NativeColor(hex: base0A)! // 10
    }
    var string: NativeColor {
        NativeColor(hex: base0B)! // 11
    }
    var support: NativeColor {
        NativeColor(hex: base0C)! // 12
    }
    var function: NativeColor {
        NativeColor(hex: base0D)! // 13
    }
    var keyword: NativeColor {
        NativeColor(hex: base0E)! // 14
    }
    var deprecated: NativeColor {
        NativeColor(hex: base0F)! // 15
    }
}

public extension Theme {
    static var styri: Self {
        Self(
            scheme: "Styri",
            author: "chbk (https://atom.io/users/chbk)",
            base00: "31333f", // background
            base01: "383b50", // line background
            base02: "444966", // selection color
            base03: "5e6382", // comment
            base04: "4b4f68", // documentation, invisibles
            base05: "e0e3f5", // caret, operators
            base06: "d5d9f1", // punctuation
            base07: "ffffff",
            base08: "fa526e", // variables, identifiers
            base09: "fc30c9", // literals
            base0A: "f2cd7e", // search background, class foreground
            base0B: "ff7e56", // string
            base0C: "0cebc5", // support
            base0D: "0590fa", // function
            base0E: "12e67c", // keyword
            base0F: "fa526e" // deprecated
        )
    }
    static var styriLight: Self {
        Self(
            scheme: "Styri Light",
            author: "chbk (https://atom.io/users/chbk)",
            base00: "ffffff",
            base01: "ebebeb",
            base02: "e0e0e0",
            base03: "8e908c",
            base04: "969896",
            base05: "5e5e5d",
            base06: "383a3e",
            base07: "1d1f21",
            base08: "e54b65",
            base09: "ee24bc",
            base0A: "fcbf3b",
            base0B: "ff7e56",
            base0C: "00d1ad",
            base0D: "0074cc",
            base0E: "11dd77",
            base0F: "e54b65"
        )
    }
    static var styriDark: Self {
        Self(
            scheme: "Styri Dark",
            author: "chbk (https://atom.io/users/chbk)",
            base00: "1e1e1e",
            base01: "222328",
            base02: "292a33",
            base03: "4C5066",
            base04: "4b4f68",
            base05: "bbbecd",
            base06: "c0c3d9",
            base07: "ffffff",
            base08: "fa526e",
            base09: "fc30c9",
            base0A: "f2cd7e",
            base0B: "ff7e56",
            base0C: "0cebc5",
            base0D: "0590fa",
            base0E: "12e67c",
            base0F: "fa526e"

        )
    }
    static var tommorow: Self {
        Self(
            scheme: "Tomorrow",
            author: "Chris Kempson (http://chriskempson.com)",
            base00: "ffffff",
            base01: "e0e0e0",
            base02: "d6d6d6",
            base03: "8e908c",
            base04: "969896",
            base05: "4d4d4c",
            base06: "282a2e",
            base07: "1d1f21",
            base08: "c82829",
            base09: "f5871f",
            base0A: "eab700",
            base0B: "718c00",
            base0C: "3e999f",
            base0D: "4271ae",
            base0E: "8959a8",
            base0F: "a3685a"
        )
    }
    static var tommorowNight: Self {
        Self(
            scheme: "Tomorrow Night",
            author: "Chris Kempson (http://chriskempson.com)",
            base00: "1d1f21",
            base01: "282a2e",
            base02: "373b41",
            base03: "969896",
            base04: "b4b7b4",
            base05: "c5c8c6",
            base06: "e0e0e0",
            base07: "ffffff",
            base08: "cc6666",
            base09: "de935f",
            base0A: "f0c674",
            base0B: "b5bd68",
            base0C: "8abeb7",
            base0D: "81a2be",
            base0E: "b294bb",
            base0F: "a3685a"
        )
    }
    static var tommorowNightEighties: Self {
        Self(
            scheme: "Tomorrow Night",
            author: "Chris Kempson (http://chriskempson.com)",
            base00: "2d2d2d",
            base01: "393939",
            base02: "515151",
            base03: "999999",
            base04: "b4b7b4",
            base05: "cccccc",
            base06: "e0e0e0",
            base07: "ffffff",
            base08: "f2777a",
            base09: "f99157",
            base0A: "ffcc66",
            base0B: "99cc99",
            base0C: "66cccc",
            base0D: "6699cc",
            base0E: "cc99cc",
            base0F: "a3685a"
        )
    }
}

// Xcode color specs
//        guard let plainText = NativeColor(hex: base05),
//              let comments = NativeColor(hex: base03),
//              let documentation = NativeColor(hex: base03)?.opacity(0.75),
//              let markupKeywords = NativeColor(hex: base0E)?.opacity(0.75),
//              let marks = NativeColor(hex: base0D),
//              let strings = NativeColor(hex: base0B),
//              let characters = NativeColor(hex: base09),
//              let numbers = NativeColor(hex: base09),
//              let keywords = NativeColor(hex: base0E),
//              let preprocessorStatements = NativeColor(hex: base0C),
//              let urls = NativeColor(hex: base09),
//              let attributes = NativeColor(hex: base09),
//              let typeDeclarations = NativeColor(hex: base0A),
//              let otherDeclarations = NativeColor(hex: base0D),
//              let projectClassNames = NativeColor(hex: base0A),
//              let projectFunctionAndMethodNames = NativeColor(hex: base0D),
//              let projectConstants = NativeColor(hex: base09),
//              let projectTypeNames = NativeColor(hex: base0A),
//              let projectInstanceVariablesAndGlobals = NativeColor(hex: base08),
//              let projectPreprocessorMacros = NativeColor(hex: base0C),
//              let otherClassNames = NativeColor(hex: base0A),
//              let otherFunctionAndMethodNames = NativeColor(hex: base0D),
//              let otherConstants = NativeColor(hex: base09),
//              let otherTypeNames = NativeColor(hex: base0A),
//              let otherInstanceVariablesAndGlobals = NativeColor(hex: base08),
//              let otherPreprocessMacros = NativeColor(hex: base0C),
//              let heading = NativeColor(hex: base0F)
//               else { return }
//
