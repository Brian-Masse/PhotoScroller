//
//  Home.swift
//  test
//
//  Created by Brian Masse on 10/31/24.
//

import Foundation
import SwiftUI

struct Home: View {
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    
    var sharedData = SharedData()
    
    var body: some View {
        let minimisedHeight = (size.height + safeArea.top + safeArea.bottom) * 0.4
        let mainOffset = sharedData.mainOffset
        
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                PhotoScrollView(size: size, safeArea: safeArea)
                
                OtherContents()
            }
            .offset(y: sharedData.canPullDown ? 0 : mainOffset < 0 ? -mainOffset : 0)
            .offset(y: mainOffset < 0 ? mainOffset : 0)
        }
        .onScrollGeometryChange(for: CGFloat.self, of: { geo in
            geo.contentOffset.y
        }, action: { oldValue, newValue in
            sharedData.mainOffset = newValue
        })
        
        .scrollDisabled(sharedData.isExpanded)
        .environment(sharedData)
        
        .overlay(content: {
            VStack {
                Text("expanded \(sharedData.isExpanded)")
                Text("progress \(sharedData.progress)")
                Text("offest \(sharedData.mainOffset)")
                
                Text("canPulldown \(sharedData.canPullDown)")
                Text("canPullUp \(sharedData.canPullUp)")
            }
        })
        
        .gesture(
            
            
            
            CustomGesture(isEnabled: true) { gesture in
                
                let state = gesture.state
                let translation = gesture.translation(in: gesture.view).y
                let isScrolling = state == .began || state == .changed
                
                if state == .began {
                    sharedData.canPullDown = translation > -10 && sharedData.mainOffset < 5
                    
                    sharedData.canPullUp = translation < 10 && sharedData.photosScrollOffset < 5
                    
                    print(translation, sharedData.photosScrollOffset)
                }
                
                if isScrolling {
                    
                    
                    if sharedData.canPullDown && !sharedData.isExpanded {
//                        print("canPullDown")
                        
                        let progress = max(min(translation / minimisedHeight, 1), 0)
                        sharedData.progress = progress
                    }
                    
                    if sharedData.canPullUp && sharedData.isExpanded {
//                        print("canPullUp")
                        
                        let progress = max(min(-translation / minimisedHeight, 1), 0)
                        sharedData.progress = 1 - progress
                    }
                    
                } else {
                    
                    withAnimation(.smooth(duration: 0.3, extraBounce: 0)) {
                        if sharedData.canPullDown && !sharedData.isExpanded {
                            if translation > 0 {
                                
                                sharedData.isExpanded = true
                                sharedData.progress = 1
                            }
                        }
                        
                        if sharedData.canPullUp && sharedData.isExpanded {
                            if translation < 0 {
                                
                                sharedData.isExpanded = false
                                sharedData.progress = 0
                            }
                        }
                    }
                }
            }
        )
        .onChange(of: sharedData.mainOffset) {
//            print(sharedData.canPullDown)
        }
    }
}

#Preview {
    
    GeometryReader { geo in
        let size = geo.size
        let safeArea = geo.safeAreaInsets
        
        Home( size: size, safeArea: safeArea )
            .ignoresSafeArea(edges: .top)
    }
}
