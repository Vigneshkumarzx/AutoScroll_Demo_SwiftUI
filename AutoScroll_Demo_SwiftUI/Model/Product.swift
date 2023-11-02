//
//  Product.swift
//  AutoScroll_Demo_SwiftUI
//
//  Created by vignesh kumar c on 02/11/23.
//

import SwiftUI

struct Product: Identifiable, Hashable {
    var id: UUID = UUID()
    var type: ProductType
    var title: String
    var subTitle: String
    var price: String
    var productImage: String = ""
}

enum ProductType: String, CaseIterable {
    case iPhone = "iPhone"
    case iPad = "iPad"
    case macBook = "macBook"
    case desktop = "Mac desktop"
    case appleWatch = "Apple watch"
    case airpods = "airpods"
    
    var tabID: String {
        return self.rawValue + self.rawValue.prefix(4)
    }
}

var products: [Product] = [

    Product(type: .appleWatch, title: "apple watch", subTitle: "ultra Alphone loop", price: "$999", productImage: "watch1"),
    Product(type: .appleWatch, title: "apple watch", subTitle: "ultra Alphone loop", price: "$899", productImage: "watch2"),
    Product(type: .appleWatch, title: "apple watch", subTitle: "ultra Alphone loop", price: "$799", productImage: "watch3"),
    Product(type: .appleWatch, title: "apple watch", subTitle: "ultra Alphone loop", price: "$999", productImage: "watch4"),
    
    Product(type: .iPhone, title: "iphone11", subTitle: "iphone11 - white", price: "$1199", productImage: "iphone11"),
    Product(type: .iPhone, title: "iphone11pro", subTitle: "iphone11pro - white", price: "$1399", productImage: "iphone11pro"),
    Product(type: .iPhone, title: "iphone14", subTitle: "iphone14 - green", price: "$1399", productImage: "iphone14"),
    Product(type: .iPhone, title: "iphone14pro", subTitle: "iphone14pro - Blue", price: "$1499", productImage: "iphone14pro"),
    Product(type: .iPhone, title: "iphone15", subTitle: "iphone15 - green", price: "$1899", productImage: "iphone15"),
    Product(type: .iPhone, title: "iphone15pro", subTitle: "iphone15pro - gray", price: "$2299", productImage: "iphone15pro"),
    
    Product(type: .macBook, title: "macbook air", subTitle: "macbook - air", price: "$2299", productImage: "mac1"),
    Product(type: .macBook, title: "macbook pro", subTitle: "macbook - pro", price: "$3299", productImage: "mac2"),
    
    Product(type: .iPad, title: "i pad pro", subTitle: "ipad - pro", price: "$2299", productImage: "ipad1"),
    Product(type: .iPad, title: "i pad ", subTitle: "ipad - basic", price: "$2299", productImage: "ipad2"),
    Product(type: .iPad, title: "i pad ", subTitle: "ipad - basic", price: "$2299", productImage: "ipad"),
    
    Product(type: .desktop, title: "mac studio ", subTitle: "mac studio", price: "$3299", productImage: "imac"),
    Product(type: .desktop, title: "mac mini ", subTitle: "mac mini", price: "$3199", productImage: "imac1"),
    
    Product(type: .airpods, title: "airpods", subTitle: "pro 2nd gen", price: "$1199", productImage: "pod2"),
    Product(type: .airpods, title: "airpods", subTitle: "pro 3rd gen", price: "$1199", productImage: "pod3"),
]
