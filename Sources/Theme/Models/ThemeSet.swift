//
//  File.swift
//  
//
//  Created by neutralradiance on 11/9/20.
//

public struct ThemeSet: Codable, Equatable {
    public var light: Theme = .styriLight
    public var dark: Theme = .styri
    public init(light: Theme = .styriLight, dark: Theme = .styri) {
        self.light = light
        self.dark = dark
    }
}

public extension ThemeSet {
    static var styri: ThemeSet { ThemeSet() }
    static var tommorow: ThemeSet {
        ThemeSet(light: .tommorow, dark: .tommorowNight)
    }
    static var tommorowNightEighties: ThemeSet {
        ThemeSet(light: .tommorow, dark: .tommorowNightEighties)
    }
}
