//
//  SearchView.swift
//  MoviesApp
//
//  Created by Adinarayana on 19/02/22.
//

import SwiftUI

struct FinderView: View {
    @EnvironmentObject var settings : NavigationSettings

    var body: some View {
        NavigationView{
            ZStack {
                ColorTheme.bgColor.color
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    if isMacOS() {
                        HeaderViewMac(title: "Find")
                    }
                }
                .conditionalView(isMacOS() ? true : false, title: "Find")
            }
        }
    }
}

extension View {
    func conditionalView(_ value: Bool, title:String) -> some View {
        self.modifier(ConditionalModifier(isBold: value, title: title))
  }
}
struct ConditionalModifier: ViewModifier {
    var isBold: Bool
    var title: String
    func body(content: Content) -> some View {
    Group {
        if self.isBold {
            content.navigationTitle(Text(title))
        }else{
            #if os(iOS)
            content.navigationBarTitle(Text(title), displayMode: .inline)
            #endif
          
           #if os(tvOS)
            content.navigationTitle(Text(title))
             #endif
            }
        }
    }
  }

