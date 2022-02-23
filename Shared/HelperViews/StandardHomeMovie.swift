//
//  StandardHomeMovie.swift
//  MoviesApp
//
//  Created by Adinarayana on 15/02/22.
//

import SwiftUI
import Kingfisher

struct StandardHomeMovie: View {
    var movie: Movie!
    
    var body: some View {
        VStack{
        KFImage(movie.url)
            .resizable()
            .scaledToFill()
        }
    }
}
