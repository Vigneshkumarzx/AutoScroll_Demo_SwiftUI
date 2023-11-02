//
//  Extension.swift
//  AutoScroll_Demo_SwiftUI
//
//  Created by vignesh kumar c on 02/11/23.
//

import SwiftUI

extension [Product] {
    var type: ProductType {
        if let firstProduct = self.first  {
            return firstProduct.type
        }
        return .iPhone
    }
}

struct offSetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    
    func offSet(_ CoordinateSpace: AnyHashable, completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .named(CoordinateSpace))
                    
                    Color.clear
                        .preference(key: offSetKey.self, value: rect)
                        .onPreferenceChange(offSetKey.self, perform: completion)
                    
                }
            }
    }
}

extension View {
    @ViewBuilder
    func checkAnimationEnd<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> ()) -> some View {
        self
            .modifier(AnimationEndCallback(for: value, onEnd: completion))
    }
}

fileprivate struct AnimationEndCallback<Value: VectorArithmetic>: Animatable, ViewModifier {
    
    var animatableData: Value {
        didSet {
            checkIfFinished()
        }
    }
    
    var endValue: Value
    var onEnd : () -> ()
    
    init(for value: Value, onEnd: @escaping () -> Void) {
        self.animatableData = value
        self.endValue = value
        self.onEnd = onEnd
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    private func checkIfFinished() {
        if endValue == animatableData {
            DispatchQueue.main.async {
                onEnd()
            }
        }
    }
}

