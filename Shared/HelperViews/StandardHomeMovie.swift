//
//  StandardHomeMovie.swift
//  MoviesApp
//
//  Created by Adinarayana on 15/02/22.
//

import SwiftUI
import Kingfisher

struct StandardHomeMovie: View {
    var movie: Movie
    
    var body: some View {
        VStack{
        KFImage(movie.url)
            .resizable()
            .scaledToFill()
        }
        
//        AsyncImage(url: movie.url) { image in
//            image
//                .resizable()
//                .aspectRatio(contentMode: .fit)
////                .frame(maxWidth: 220, alignment: .center)
//        } placeholder: {
//            ProgressView()
//        }

    }
}

struct StandardHomeMovie_Previews: PreviewProvider {
    static var previews: some View {
        StandardHomeMovie(movie: exampleMovies[0])
    }
}
