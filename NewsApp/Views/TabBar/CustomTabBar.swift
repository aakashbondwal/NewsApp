//
//  CustomTabBar.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 09/03/24.
//


import SwiftUI

enum TabbedItems: Int, CaseIterable{
    case articles = 0
    case blogs
    case reports
    case more
    
    var iconName: String{
        switch self {
        case .articles:
            return "home"
        case .blogs:
            return "blogs"
        case .reports:
            return "reports"
        case .more:
            return "more"
        }
    }

}

struct CustomTabBar: View {

    @State private var isPremium: Bool = false
    @State var selectedTab = 0
    
    var body: some View {
        ZStack (alignment: .bottom) {
            TabView(selection: $selectedTab) {
                Articles()
                    .tag(0)
                    
                
                AllBlogs()
                    .tag(1)
               
                
                AllReports()
                    .tag(2)
               
                
                More()
                    .tag(3)
                 
                    
            }
            
            ZStack{
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .padding(.top, 20)
            .frame(height: 70)
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }
      
    }
}

extension CustomTabBar {
    func CustomTabItem(imageName: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()

            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(isActive ? .black : .gray)
                .frame(width: 28, height: 28)
      
            Spacer()
        }

    }
}

#Preview {
    CustomTabBar()
}
