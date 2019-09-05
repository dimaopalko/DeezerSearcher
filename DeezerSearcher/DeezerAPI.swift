//
//  AlbumDbAPI.swift
//  DeezerSearcher
//
//  Created by Dima Opalko on 9/5/19.
//  Copyright © 2019 Dima Opalko. All rights reserved.
//

import Foundation

class DeezerAPI {
    
    var imageUrl = ""
    var album: Album = Album(data: [])
    
    func searchAlbum(named: String) {
        let artistName = String(named.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)[0])
        let albumName = String(named.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)[1])
        let url = "https://api.deezer.com/search/album?q=\(artistName)%20\(albumName)"
        
        print(named.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true))
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { ( data, responce, error) in
                if let data = data {
                    do {
                        let album = try JSONDecoder().decode(Album.self, from: data)
                        self.imageUrl = album.data[0].coverImageLink
                        
                        
                        DispatchQueue.main.async {
                            print(self.album)
                        }
                    } catch {
                        print("Ah sh*t, here we go again: \(error)")
                    }
                }
                }.resume()
        }
        
    }
}
