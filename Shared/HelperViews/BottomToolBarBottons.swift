//
//  BottomToolBarBottons.swift
//  MoviesApp (macOS)
//
//  Created by Adinarayana-M on 22/2/2565 BE.
//

import SwiftUI

struct BottomToolBarBottons: View {
   
    @Binding var isHomeSelected: Bool
    @Binding var isFinderSelected: Bool
    @Binding var isDownloadsSelected: Bool
    @Binding var isMyStuffSelected: Bool
    @EnvironmentObject var settings : NavigationSettings
   
    let homeStr: String = NSLocalizedString("Home", comment: "")
    let findStr: String = NSLocalizedString("Find", comment: "")
    let downloadStr: String = NSLocalizedString("Downloads", comment: "")
    let myStuffStr: String = NSLocalizedString("MyStuff", comment: "")
    
    var body: some View {
        VStack{
             HStack{
                 Spacer()
                 Button(action: homeAction) {
                     Label(homeStr, systemImage: "house.fill")
                         .foregroundColor(isHomeSelected ? .blue : .gray)
                         .font(.system(size: 18))
                 }.buttonStyle(.plain)
                 Spacer()
                 
                 Button(action: findAction) {
                     Label(findStr, systemImage: "magnifyingglass")
                         .foregroundColor(isFinderSelected ? .blue : .gray)
                         .font(.system(size: 18))

                 }.buttonStyle(.plain)
     
                 Spacer()
                 Button(action: downloadAction) {
                     Label(downloadStr, systemImage: "arrow.down.circle")
                         .foregroundColor(isDownloadsSelected ? .blue : .gray)
                         .font(.system(size: 18))

                 }.buttonStyle(.plain)
                 Spacer()
                 Button(action: myStuffAction) {
                     Label(myStuffStr, systemImage: "person.circle.fill")
                         .foregroundColor(isMyStuffSelected ? .blue : .gray)
                         .font(.system(size: 18))
                 }.buttonStyle(.plain)
                 Spacer()
             }.frame(width: isMacOS() ? getRect().width : nil , height: 40, alignment: .center)
         }.frame(width: isMacOS() ? getRect().width : nil , height: 40, alignment: .center)
             .background(.black)
             .onAppear {
                 homeAction()
             }
    }
    
    func homeAction() {
        self.isHomeSelected = true
        self.isFinderSelected = false
        self.isDownloadsSelected = false
        self.isMyStuffSelected = false
        self.settings.navigationItem = .home
    }
    func findAction() {
        self.isHomeSelected = false
        self.isFinderSelected = true
        self.isDownloadsSelected = false
        self.isMyStuffSelected = false
        self.settings.navigationItem = .find
    }
    func downloadAction() {
        self.isHomeSelected = false
        self.isFinderSelected = false
        self.isDownloadsSelected = true
        self.isMyStuffSelected = false
        self.settings.navigationItem = .downloads
    }
    func myStuffAction() {
        self.isHomeSelected = false
        self.isFinderSelected = false
        self.isDownloadsSelected = false
        self.isMyStuffSelected = true
        self.settings.navigationItem = .mystuff
    }
}
