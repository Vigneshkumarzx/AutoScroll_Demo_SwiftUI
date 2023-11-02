//
//  Home.swift
//  AutoScroll_Demo_SwiftUI
//
//  Created by vignesh kumar c on 02/11/23.
//

import SwiftUI

struct Home: View {
    @State private var activeTab: ProductType = .iPhone
    @Namespace private var animation
    @State private var productsBasedType: [[Product]] = []
    @State var animationProgress: CGFloat = 0
    @State private var scrollableTabOffset: CGFloat = 0
    @State private var initialTabOffset: CGFloat = 0
    
    var body: some View {
        ScrollViewReader { proxy in
            
            ScrollView(.vertical, showsIndicators: false) {
//                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
//                    Section {
//                        ForEach(productsBasedType, id: \.self) { products in
//                            productSectionView(products)
//                        }
//                    } header: {
//                        scrollabelTabs(proxy)
//                    }
//
//                }
                VStack(spacing: 15) {
                    ForEach(productsBasedType, id: \.self) { products in
                        productSectionView(products)
                    }
                }
                .offSet("CONTENTVIEW") { rect in
                    scrollableTabOffset = rect.minY - initialTabOffset
                }
            }
            .offSet("CONTENTVIEW", completion: { rect in
                initialTabOffset = rect.minY
            })
            .safeAreaInset(edge: .top) {
                scrollabelTabs(proxy)
                    .offset(y: scrollableTabOffset > 0 ? scrollableTabOffset : 0 )
            }
        }
        .coordinateSpace(name: "CONTENTVIEW")
        .navigationTitle("Apple store")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.blue), for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .background {
            Rectangle()
                .fill(Color.white)
                .ignoresSafeArea()
        }
        .onAppear {
            guard productsBasedType.isEmpty else { return }
            
            for type in ProductType.allCases {
                let products = products.filter{ $0.type == type }
                productsBasedType.append(products)
            }
        }
    }
    
    @ViewBuilder
    
    func productSectionView(_ products: [Product]) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            if let firstProduct = products.first {
                Text(firstProduct.type.rawValue)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            ForEach(products) { product in
                productRowView(product)
            }
        }
        .padding(15)
        .id(products.type)
        .offSet("CONTENTVIEW") { rect in
            let minY = rect.minY
            
            if (minY < 30 && -minY < (rect.midY / 2) && activeTab != products.type) && animationProgress == 0 {
                withAnimation(.easeInOut(duration: 0.3)) {
                    activeTab =  (minY < 30 && -minY < (rect.midY / 2) && activeTab != products.type) ? products.type : activeTab
                }
            }
        }
    }
    
    @ViewBuilder
    
    func productRowView(_ product: Product) -> some View {
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.gray.opacity(0.09))
                }
            
            VStack(alignment:.leading, spacing: 8) {
                Text(product.title)
                    .font(.title3)
                Text(product.subTitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
                Text(product.price)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func scrollabelTabs(_ proxy: ScrollViewProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(ProductType.allCases, id: \.rawValue) { type in
                    Text(type.rawValue)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .background(alignment: .bottom, content: {
                            if activeTab == type {
                                Capsule()
                                    .fill(Color.white)
                                    .frame(height: 5)
                                    .padding(.horizontal, -5)
                                    .offset(y: 15)
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            }
                        })
                        .padding(.horizontal, 15)
                        .contentShape(Rectangle())
                        .id(type.tabID)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                activeTab = type
                                animationProgress = 1.0
                                //scrolling to the selected content
                                
                                proxy.scrollTo(type, anchor: .topLeading)
                            }
                        }
                }
            }
            .padding(.vertical, 15)
            .onChange(of: activeTab) { newValue in
                withAnimation(.easeInOut(duration: 0.3)) {
                    proxy.scrollTo(newValue.tabID, anchor: .center)
                }
            }
            .checkAnimationEnd(for: animationProgress) {
                animationProgress = 0.0
            }
        }
        .background {
            Rectangle()
                .fill(Color.blue)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
        }
    }
}

#Preview {
    ContentView()
}
