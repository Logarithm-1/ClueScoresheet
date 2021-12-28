//
//  Color+Ext.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

extension Color {
    init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
            }

            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue:  Double(b) / 255,
                opacity: Double(a) / 255
            )
        }
    
    public static var shadow: Color {
        return Color(.sRGBLinear, white: 0, opacity: 0.13)
    }
    
    //MARK: - Yellow
    public static var amber: Color {
        return Color(red: 255.0/255.0, green: 193.0/255.0, blue: 7.0/255.0, opacity: 1)
    }
    
    public static var khaki: Color {
        return Color(hex: "f0e68c")
    }
    
    public static var lime: Color {
        return Color(hex: "cddc39")
    }
    
    public static var paleYellow: Color {
        return Color(hex: "ffffcc")
    }
    
    //MARK: - Blue
    public static var aqua: Color {
        return Color(red: 0.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, opacity: 1)
    }
    
    public static var blueGray: Color {
        return Color(hex: "607d8b")
    }
    
    public static var cyan: Color {
        return Color(hex: "00bcd4")
    }
    
    public static var indigo: Color {
        return Color(hex: "3f51b5")
    }
    
    public static var lightBlue: Color { //87 ce eb
        return Color(red: 135.0/255.0, green: 206.0/255.0, blue: 235.0/255.0, opacity: 1)
    }
    
    public static var midnightBlue: Color { //87 ce eb
        return Color(hex: "191970")
    }
    
    public static var paleBlue: Color {
        return Color(hex: "ddffff")
    }
    
    public static var teal: Color {
        return Color(hex: "009688")
    }
    
    //MARK: - Brown
    public static var brown: Color {
        return Color(hex: "795548")
    }
    
    //MARK: - Green
    public static var lightGreen: Color {
        return Color(hex: "8bc34a")
    }
    
    public static var paleGreen: Color {
        return Color(hex: "ddffdd")
    }
    
    //MARK: - Orange
    public static var deepOrange: Color {
        return Color(hex: "ff5722")
    }
    
    //MARK: - Purple
    public static var deepPurple: Color {
        return Color(hex: "673ab7")
    }
    
    //MARK: - White
    public static var sand: Color {
        return Color(hex: "fdf5e6")
    }
    
    public static var lightGrey: Color {
        return Color(hex: "f1f1f1")
    }
    
    public static var darkGrey: Color {
        return Color(hex: "616161")
    }
    
    public static var nightGrey: Color {
        return Color(hex: "1A1A1A")
    }
    
    //MARK: - Red
    public static var paleRed: Color {
        return Color(hex: "ffdddd")
    }
}
