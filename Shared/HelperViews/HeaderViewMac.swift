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
                .font(.system(size: 25))
                .padding(.bottom, 15)
                Spacer()
            }.frame(width: isMacOS() ? getRect().width : nil , height: 40, alignment: .leading)
                .background(ColorTheme.bgColor.color)
                .padding([.leading,.trailing], 20)
        }.frame(width: isMacOS() ? getRect().width : nil , height: 40, alignment: .center)
            .background(ColorTheme.bgColor.color)
        Spacer()
    }
}

//struct HeaderViewMac_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderViewMac()
//    }
//}
