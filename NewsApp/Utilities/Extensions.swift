//
//  Extensions.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 16/04/24.
//


import SwiftUI
import Foundation
///scaled buttib
///
struct scaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}


extension View {
    func safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
    
    ///Scroll View Offset
    func offset(offset: Binding<CGFloat>) -> some View {
        return self
            .overlay {
                GeometryReader {proxy in
                    
                    let minY = proxy.frame(in: .named("Scroll")).minY
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                    
                }
                .onPreferenceChange(OffsetKey.self){ value in
                    offset.wrappedValue = value
                }
            }
    }
}


//offset key

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

