//
//  MyStuffView.swift
//  MoviesApp
//
//  Created by Adinarayana on 19/02/22.
//

import SwiftUI

struct MyStuffView: View {
    
    @EnvironmentObject var settings : NavigationSettings

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                HeaderViewMac(title: "My Stuff")
            }
        }
        
    }
}
