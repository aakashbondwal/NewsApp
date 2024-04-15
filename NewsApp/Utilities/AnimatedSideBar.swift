//
//  AnimatedSideBar.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 16/04/24.
//


import SwiftUI

@available(iOS 17.0, *)
struct AnimatedSideBar<Content: View, MenuView: View, Background: View>: View {
    
    var rotatesWhenExpands: Bool = true
    var disablesInteraction: Bool = true
    var sideMenuWidth: CGFloat = 200
    var cornerRadius: CGFloat = 25
    
    @Binding var showMenu: Bool
    @ViewBuilder var content: (UIEdgeInsets) -> Content
    @ViewBuilder var menuView: (UIEdgeInsets) -> MenuView
    @ViewBuilder var background: Background
    @GestureState private var isDragging: Bool = false
    @State private var offsetX: CGFloat = 0
    @State private var lastoffsetX: CGFloat = 0
    @State private var progress: CGFloat = 0
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets ?? .zero
            
            
            HStack(spacing: 0) {
                GeometryReader {_ in
                    
                    menuView(safeArea)
                    
                }
                .frame(width: sideMenuWidth)
                .contentShape(.rect)
                
                GeometryReader {_ in
                    
                    content(safeArea)
                    
                }
                .frame(width: size.width)
                .overlay {
                    if disablesInteraction && progress > 0 {
                        Rectangle()
                            .fill(.black.opacity(progress * 0.2))
                            .onTapGesture {
                                withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                                    reset()
                                }
                            }
                    }
                }
                .mask {
                    RoundedRectangle(cornerRadius: progress * cornerRadius)
                }
                .scaleEffect(rotatesWhenExpands ? 1 - (progress * 0.1) : 1 ,anchor: .trailing)
                .rotation3DEffect(
                    .init(degrees: rotatesWhenExpands ? (progress * -15) : 0),
                                          axis: (x: 0.0, y: 1.0, z: 0.0)
                )
            }
            .frame(width: size.width + sideMenuWidth, height: size.height)
            .offset(x: -sideMenuWidth)
            .offset(x: offsetX)
        }
        .ignoresSafeArea()
        .onChange(of: showMenu, initial: true) { oldValue, newValue in
        
            withAnimation(.snappy(duration: 0.3, extraBounce:  0)) {
                if newValue {
                    showSideBar()
                } else {
                    reset()
                }
            }
            
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .updating($isDragging) {_ , out, _  in
                
                out = true
                
            }.onChanged { value in
                
                guard value.startLocation.x > 10 else { return }
                
                let translationX = isDragging ? max(min(value.translation.width + lastoffsetX, sideMenuWidth), 0) : 0
                offsetX = translationX
                calculateProgress()
            }.onEnded { value in
                withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                    let velocityX = value.velocity.width / 8
                    let total = velocityX + offsetX
                    
                    if total > (sideMenuWidth * 0.5) {
                        showSideBar()
                    } else {
                        reset()
                    }
                    
                }
            }
    }
    
    func showSideBar() {
        offsetX = sideMenuWidth
        lastoffsetX = offsetX
        showMenu = true
        calculateProgress()
    }
    
    func reset() {
        offsetX = 0
        lastoffsetX = 0
        showMenu = false
        calculateProgress()
    }
    
    
    func calculateProgress() {
        progress = max(min(offsetX / sideMenuWidth , 1), 0)
    }
}

#Preview {
    Home()
}
