//
//  HeaderViewMac.swift
//  MoviesApp
//
//  Created by Adinarayana on 20/02/22.
//

import SwiftUI


struct HeaderViewMac: View {
    var title: String = NSLocalizedString("Movies", comment: "")
    var onBackAction: (() -> Void?)? = nil
    var isShowBackButton : Bool = false
    
    var body: some View {
        VStack{
            HStack() {
                if isShowBackButton {
                    Button {
                        onBackAction?()
                    } label: {
                       Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }.padding([.leading, .bottom], 15)
                        .buttonStyle(.plain)
                    
                }
                Spacer()
              Text(title)
                .foregroundColor(.white)
                .font(.system(size: isMacOS() ? 25 : 20))
                .padding(.bottom, 15)
                Spacer()
            }.frame(width: isMacOS() ? getRect().width : nil , height: isMacOS() ? 40 : 44, alignment: .leading)
                .background(ColorTheme.bgColor.color)
                .padding([.leading,.trailing], isMacOS() ? 20 : 16)
        }.frame(width: isMacOS() ? getRect().width : nil , height: isMacOS() ? 40 : 44, alignment: .center)
            .background(ColorTheme.bgColor.color)
        Spacer()
    }
}

