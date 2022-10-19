//
//  ContentView.swift
//  Musicapp
//
//  Created by dat on 08/09/2022.
//

import SwiftUI

struct Album : Hashable{
    var id = UUID()
    var name : String
    var image : String
    var songs : [Song]
}

struct Song: Hashable{
    var id = UUID()
    var name : String
    var time : String
}

struct ContentView: View {
    var albums = [Album(name: "Rap music", image: "rap",
                        songs: [Song(name: "Song 1", time: "2:30"),
                                Song(name: "Song 2", time: "2:30"),
                                Song(name: "Song 3", time: "2:30"),
                                Song(name: "Song 4", time: "2:30"),
                                Song(name: "Song 5", time: "2:30")]),
                  Album(name: "Pop music", image: "pop",
                                      songs: [Song(name: "Song 11", time: "2:30"),
                                              Song(name: "Song 12", time: "2:30"),
                                              Song(name: "Song 13", time: "2:30"),
                                              Song(name: "Song 14", time: "2:30"),
                                              Song(name: "Song 15", time: "2:30")]),
                  Album(name: "Chill music", image: "chill",
                                      songs: [Song(name: "Song 16", time: "2:30"),
                                              Song(name: "Song 27", time: "2:30"),
                                              Song(name: "Song 38", time: "2:30"),
                                              Song(name: "Song 49", time: "2:30"),
                                              Song(name: "Song 50", time: "2:30")]),
                  Album(name: "Sad music", image: "sad",
                                      songs: [Song(name: "Song 51", time: "2:30"),
                                              Song(name: "Song 52", time: "2:30"),
                                              Song(name: "Song 53", time: "2:30"),
                                              Song(name: "Song 54", time: "2:30"),
                                              Song(name: "Song 55", time: "2:30")])]
                
    @State private var currentAlbum : Album?
    
    var body: some View {
        NavigationView {
            ScrollView{
                ScrollView(.horizontal, showsIndicators: false, content:{
                    LazyHStack{
                    ForEach(self.albums, id: \.self, content: {
                        album in
                        AlbumArt(album: album,isWithText: true).onTapGesture{          self.currentAlbum = album
                        }
                    })
                    }
                })
                LazyVStack{
                    ForEach((self.currentAlbum?.songs ?? self.albums.first?.songs) ?? [Song(name: "Song 1", time: "2:30"),
                            Song(name: "Song 2", time: "2:30"),
                            Song(name: "Song 3", time: "2:30"),
                            Song(name: "Song 4", time: "2:30"),
                            Song(name: "Song 5", time: "2:30")],
                            id: \.self,
                            content: {song in
                        SongCell(album: currentAlbum ?? albums.first!, song: song)
                    })
                }
            }
        }
        
    }
}

struct AlbumArt : View{
    var album : Album
    var isWithText : Bool
    var body: some View{
        ZStack(alignment: .bottom, content: {
            Image(album.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 200, alignment: .center)
            if isWithText == true{
            ZStack{
                Blur(style: .dark)
                Text(album.name).foregroundColor(.white)
            }.frame(height: 60, alignment: .bottom)
            }
        }).frame(width: 170, height: 200, alignment: .center).clipped().cornerRadius(20).shadow(radius: 10).padding(20)
    }
}

struct SongCell: View{
    var album : Album
    var song: Song
    var body: some View{
        NavigationLink(
            destination: PlayView(album: album, song: song), label:{
            HStack{
            Image("musicimg").frame(width: 65, height: 50, alignment: .center).foregroundColor(.white)
            Text(song.name).bold()
            Spacer()
            Text(song.time)
        }.padding(20)
        }).buttonStyle(PlainButtonStyle())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
