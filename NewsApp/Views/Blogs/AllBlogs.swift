//
//  AllBlogs.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import SwiftUI

struct AllBlogs: View {
    
    @State private var search: String = ""
    @StateObject private var vm = BlogsViewModel()
    
    var filteredBlogs: [BlogResults] {
        guard !search.isEmpty else { return vm.allBlogs?.results ?? [] }
        return vm.allBlogs?.results.filter { $0.title.localizedCaseInsensitiveContains(search) } ?? []
    }
    
    
    
    //animation properties
    
    @State var currentItem: BlogResults?
    @State var showDetailPage: Bool = false
    
    @Namespace var animation
    
    @State var animateView: Bool = false
    @State var animateContent: Bool = false
    @State var scrollOffset: CGFloat = 0
    
    let date = Date()
    
    var body: some View {
        
        if filteredBlogs.isEmpty {
            ProgressView()
        } else {
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(date.formatted(.dateTime.day().month(.wide))), \(date.formatted(.dateTime.weekday(.wide)))")
                                .font(.callout)
                                .foregroundStyle(.gray)
                            
                            Text("Blogs")
                                .multilineTextAlignment(.leading)
                                .font(.largeTitle.bold())
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .opacity(showDetailPage ? 0 : 1)
                    ForEach(filteredBlogs){ item in
                        
                        Button(action: {
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                currentItem = item
                                showDetailPage  = true
                            }
                        }, label: {
                            CardView(blogs: item)
                                .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.93)
                        })
                        .cornerRadius(50)
                        .buttonStyle(scaledButtonStyle())
                        .opacity(showDetailPage ?  (((currentItem?.id) == nil) && showDetailPage ? 1: 0) : 1)
                        
                    }
                }
                .padding(.vertical)
            }
            .environmentObject(vm)
            .overlay {
                if let currentItem = currentItem, showDetailPage {
                    detailView(blogs: currentItem)
                        .ignoresSafeArea(.container, edges: .top)
                }
            }
            .background(alignment: .top) {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color("black"))
                    .frame(height: animateView ? nil : 350, alignment: .top)
                    .opacity(animateView ? 1 : 0)
                    .ignoresSafeArea()
            }
        }
        
    }
    
    ///Mark: cardView
    @ViewBuilder
    func CardView(blogs: BlogResults) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            ZStack (alignment: .topLeading) {
                GeometryReader{ proxy in
                    
                    
                    let size = proxy.size
                    
                    BlogsImageView(blogs: blogs)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 15))
                    
                    
                    
                }
                .frame(height: 300)
                
                
                LinearGradient(colors: [.black.opacity(0.5), .black.opacity(0.2), .clear], startPoint: .top, endPoint: .bottom)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(blogs.news_site)
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text(blogs.title)
                        .font(.title2.bold())
                }
                .padding()
                .offset(y: currentItem?.id == blogs.id && animateView ? safeArea().top : 0)
            }
            .foregroundStyle(.white)
        }

    }
    
    func detailView(blogs: BlogResults) -> some View {
        ScrollView(.vertical, showsIndicators: false ) {
            LazyVStack {
                CardView(blogs: blogs)
                    .scaleEffect(animateView ? 1 :  0.93)
                
                VStack(alignment: .leading, spacing: 15) {
                    //DETAILED TEXT
                    
                    Text(blogs.summary)
                        .font(.callout)
                    
                    Text("Blog by : \(blogs.news_site)")
                        .bold()
                    
                    
                    Text("Published At: \(convertTimestampToReadableDate(blogs.published_at))")
                    
                    Text("Updated At: \(convertTimestampToReadableDate(blogs.updated_at)) ")
                    
                    Link("Blog URL", destination: URL(string: blogs.url)!)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.blue)
                }
                .multilineTextAlignment(.leading)
                .padding()
                .offset(y: scrollOffset > 0 ? scrollOffset : 0)
                .opacity(animateContent ? 1 : 0)
                .scaleEffect(animateView ? 1 : 0, anchor: .top)
            }
            .offset(y: scrollOffset > 0 ? -scrollOffset: 0)
            .offset(offset: $scrollOffset)
        }
        .overlay(alignment: .topTrailing, content: {
            Button(action: {
                //closing
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animateView = false
                    animateContent = false
                }
                
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)) {
                    currentItem = nil
                    showDetailPage = false
                }
                
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(.white)
            })
            .padding()
            .padding(.top, safeArea().top)
            .offset(y: -10)
            .opacity(animateView ? 1 : 0)
        })
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                animateView = true
            }
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.1)) {
                animateContent = true
            }
        }
        .transition(.identity)
    }
}

#Preview {
    AllBlogs()
        .preferredColorScheme(.dark)
}
