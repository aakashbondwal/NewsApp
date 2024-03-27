//
//  ContentView.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 04/01/24.
//
import SwiftUI

struct ContentView: View {
    @State var details = false
    @Namespace var animation
    
    var body: some View {
        ZStack {
            HStack {
                if !details {
                    Rectangle()
                        .matchedGeometryEffect(id: "id1", in: animation)
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            withAnimation {
                                details.toggle()
                            }
                        }
                }
                
                
                Spacer()
            }
            .zIndex(1)
            
            if details {
                AnotherView(details: $details, animation: animation)
                    .zIndex(2)
            }
        }
    }
}


struct AnotherView: View {
    @Binding var details: Bool
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            Color.red
            
            Rectangle()
                .matchedGeometryEffect(id: "id1", in: animation)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    withAnimation {
                        details.toggle()
                    }
                }
        }
    }
}
#Preview {
    ContentView()
}
