//
//  AlbumDbAPI.swift
//  DeezerSearcher
//
//  Created by Dima Opalko on 9/5/19.
//  Copyright © 2019 Dima Opalko. All rights reserved.
//

import Foundation
import UIKit

class DeezerAPI {
    
    var downloadDelegate: DeezerDownloadDelegate!
    
    func searchAlbum(named: String) {
        let splitedName = named.components(separatedBy: ["-", ":", "|", #"\"# , "/", "~"])
        let artistName = splitedName[0].dropLast().replacingOccurrences(of: " ", with: "%20")
        var albumName = " "
        if splitedName.count > 1 {
        albumName = splitedName[1].dropFirst().replacingOccurrences(of: " ", with: "%20")
        }
        let url = "https://api.deezer.com/search/album?q=\(artistName)%20\(albumName)"
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { ( data, responce, error) in
                if let data = data {
                    do {
                        let album = try JSONDecoder().decode(Album.self, from: data)
                        let artistName = album.data[0].artist.name
                        let albumTitle = album.data[0].albumTitle
                        let imageURL = album.data[0].coverImageLink
                        let coverImage = self.downloadImageFromURL(url: imageURL)
                        self.downloadDelegate.didFinishDownload(artistName: artistName, albumTitle: albumTitle, coverImage: coverImage)
                        print(album)
                    } catch {
                        print("Ah sh*t, here we go again: \(error)")
                        let artistName = "Could not found that album"
                        let albumTitle = ""
                        let coverImage = UIImage(named: "no-image-png-3")
                        self.downloadDelegate.didFinishDownload(artistName: artistName, albumTitle: albumTitle, coverImage: coverImage!)
                    }
                }
                }.resume()
        }
    }
    
    func downloadImageFromURL(url: String?) -> UIImage {
        var image: UIImage = UIImage()
        if let imageUrlString = url {
        if let imageUrl = URL(string: imageUrlString) {
            if let imageData = try? Data(contentsOf: imageUrl) {
                image = UIImage(data: imageData) ?? UIImage(named: "no-image-png-3")! // this force unwrap is safe because this image in assets folder.
            }
        }
        }
        return image
    }
}
