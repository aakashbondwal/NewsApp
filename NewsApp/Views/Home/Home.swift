//
//  Home.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 16/04/24.
//


import SwiftUI

struct Home: View {
    
    @StateObject private var vm = ArticlesViewModel(selectData: "articles")
    @State private var showMenu: Bool = false
    @State private var selectedCategory: String = "Articles"
    
    var body: some View {
        VStack {
            AnimatedSideBar(
                rotatesWhenExpands: true,
                disablesInteraction: true,
                sideMenuWidth: 200 ,
                cornerRadius: 25,
                showMenu: $showMenu
            ) { safeArea in
                NavigationStack {
                    ZStack {
                        
                        //main news feed
                        GeometryReader {
                            let size = $0.size
                            let safeArea = $0.safeAreaInsets
                            
                            BreakingNews(size: size, safeArea: safeArea, title: selectedCategory)
                                .ignoresSafeArea(.container, edges: .all)
                                .environmentObject(vm)
                        }
                        
                        VStack {
                            
                            HStack {
                                Button(action: {
                                    showMenu.toggle()
                                }
                                       , label: {
                                    Image(systemName: showMenu ? "xmark" : "line.3.horizontal")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                    
                                })
                                .foregroundStyle(.white)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                        }
                    }
                }
            } menuView: { safeArea in
                //side menu ui
                VStack {
                    Text("Menu")
                        .bold()
                        .font(.title)
                    
                    
                    Button(action: {
                        
                        
                        vm.updateData(for: "articles")
                        selectedCategory = "Articles"
                        showMenu.toggle()
                        
                    }, label: {
                        
                        Text("Articles")
                        
                            .padding()
                            .padding(.horizontal, 30)
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    })
                    
                    
                    Button(action: {
                        
                        
                        vm.updateData(for: "blogs")
                        selectedCategory = "Blogs"
                        showMenu.toggle()
                        
                    }, label: {
                        
                        Text("Blogs")
                        
                            .padding()
                            .padding(.horizontal, 30)
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                    })
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .padding(.top, safeArea.top)
                .padding(.bottom, safeArea.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            } background: {
                Rectangle()
                    .fill(.black)
            }
            
        }
        
    }
    
}

#Preview {
    Home()
}
