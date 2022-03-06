//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    @EnvironmentObject var settings : NavigationSettings
    var navigationItem: NavigationItem
   @State var selectedMovie : Movie!
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            ColorTheme.bgColor.color
                .edgesIgnoringSafeArea(.all)
            VStack{
                if isMacOS(){
                    HeaderViewMac(title: "Movie Details",onBackAction: backButton, isShowBackButton: true)
                }
                //Imageview
                LazyVStack{
                StandardHomeMovie(movie: selectedMovie)
                        .frame(width: isMacOS() ? getRect().width : getRect().width , height: 200)
                }.frame(width: isMacOS() ? getRect().width : getRect().width , height: 200)
                    .padding(.bottom, 16)
                
                LazyVStack{
                    Text(selectedMovie.title ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer().frame(height: 15, alignment: .center)
                    Button("Play"){
                    }.frame(width: getRect().width-32, height: 48)
                        .background(.blue)
                }.padding()

            }.navigationTitle(Text("Movie Details"))
            .onAppear {
                print(selectedMovie.title ?? "")
            }.onDisappear {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func backButton() {
        settings.navigationItem = settings.selectedNavigationItem.last ?? .home
    }
}

//struct MovieDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsView()
//    }
//}
