//
//  SwiftUIView.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 08/03/24.
//

import SwiftUI

struct Articles: View {
    
    @State private var search: String = ""
    @StateObject private var vm = ArticlesViewModel()
    
    var filteredArticles: [Results] {
        guard !search.isEmpty else { return vm.allArticles?.results ?? [] }
        return vm.allArticles?.results.filter { $0.title.localizedCaseInsensitiveContains(search) } ?? []
    }
    
    
    
    //animation properties
    
    @State var currentItem: Results?
    @State var showDetailPage: Bool = false
    
    @Namespace var animation
    
    @State var animateView: Bool = false
    @State var animateContent: Bool = false
    @State var scrollOffset: CGFloat = 0
    
    let date = Date()
    
    var body: some View {
       
        if filteredArticles.isEmpty {
            ProgressView()
        } else {

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("\(date.formatted(.dateTime.day().month(.wide))), \(date.formatted(.dateTime.weekday(.wide)))")
                                    .font(.callout)
                                    .foregroundStyle(.gray)
                                
                                Text("Articles")
                                    .multilineTextAlignment(.leading)
                                    .font(.largeTitle.bold())
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .opacity(showDetailPage ? 0 : 1)
                        ForEach(filteredArticles){ item in
                            
                            Button(action: {
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    currentItem = item
                                    showDetailPage  = true
                                }
                            }, label: {
                                CardView(result: item)
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
                        detailView(result: currentItem)
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
    func CardView(result: Results) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            ZStack (alignment: .topLeading) {
                GeometryReader{ proxy in
                    
                    
                    let size = proxy.size
                    
                    ImageView(articles: result)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 15))
                 
                    
                    
                    
                }
                .frame(height: 300)
                
                
                LinearGradient(colors: [.black.opacity(0.5), .black.opacity(0.2), .clear], startPoint: .top, endPoint: .bottom)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(result.news_site)
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text(result.title)
                        .font(.title2.bold())
                }
                .padding()
                .offset(y: currentItem?.id == result.id && animateView ? safeArea().top : 0)
            }
            .foregroundStyle(.white)
        }

    }
    
    func detailView(result: Results) -> some View {
        ScrollView(.vertical, showsIndicators: false ) {
            VStack {
                CardView(result: result)
                    .scaleEffect(animateView ? 1 :  0.93)
            
                
                VStack(alignment: .leading, spacing: 15) {
                    //DETAILED TEXT
                    
                    
                    if result.featured {
                        Text("Featured")
                            .font(.caption2)
                            .bold()
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(20)
                    } else {
                        Text("Not Featured")
                            .font(.caption2)
                            .bold()
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(20)
                    }
                    
                    Text(result.summary)
                        .font(.callout)
                    
                    Text("Article by : \(result.news_site)")
                        .bold()
                    
                    
                    Text("Published At: \(convertTimestampToReadableDate(result.published_at))")
                    
                    Text("Updated At: \(convertTimestampToReadableDate(result.updated_at)) ")
                    
                    Link("Article URL", destination: URL(string: result.url)!)
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
    Articles()
        .preferredColorScheme(.dark)
}


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
