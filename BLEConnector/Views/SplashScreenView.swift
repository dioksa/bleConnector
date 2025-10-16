//
//  SplashScreenView.swift
//  BLEConnector
//
//  Created by Oksana Dionisieva on 16.10.2025.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var angle: Double = 0
    @State private var opacity: Double = 0.0
    @State private var radius: CGFloat = 100
    
    var onFinish: (() -> Void)?
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    Image("ble_icon")
                        .resizable()
                        .frame(width: 170, height: 170)
                        .opacity(opacity)
                        .zIndex(1)
                    ZStack {
                        Image("bigCircle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 170, height: 170)
                            .offset(x: radius)
                            .opacity(opacity)
                            .shadow(radius: 30)
                        Image("smallCircle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .offset(x: -radius)
                            .opacity(opacity)
                    }
                    .rotationEffect(.degrees(angle))
                    VStack {
                        HStack {
                            Image("bigCircle")
                                .resizable()
                                .frame(width: 470, height: 470)
                                .offset(x: -170, y: -170)
                                .opacity(opacity)
                            
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            withAnimation(.easeInOut(duration: 6.0)) {
                opacity = 1.0
                angle = 300
                radius = 250
            }
            Task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    onFinish?()
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
