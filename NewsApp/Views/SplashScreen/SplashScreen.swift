//
//  SplashScreen.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
<<<<<<< HEAD
                CustomTabBar()
=======
                Home()
>>>>>>> bd2b336 (Fix: Replaced Old API service with the new one)
            } else {
                ZStack {

                    
                    LinearGradient(colors: [.black,  Color(#colorLiteral(red: 0.1647058824, green: 0.1333333333, blue: 0.2509803922, alpha: 1))], startPoint: .bottom, endPoint: .top)
                        .ignoresSafeArea()
                      
                    
                    Image("logo")
                        .resizable().scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(.rect(cornerRadius: 20))
                        .shadow(color: .white,radius: 1)
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
