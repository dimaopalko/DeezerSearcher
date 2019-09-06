//
//  ViewController.swift
//  DeezerSearcher
//
//  Created by Dima Opalko on 9/4/19.
//  Copyright © 2019 Dima Opalko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    let deezerAPI = DeezerAPI()
    
    var imageUrl = ""
    var album: Album = Album(data: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deezerAPI.searchAlbum(named: "fink Resurgam")
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
    }
    
    func searchAlbum(named: String) {
        let artistName = String(named.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)[0])
        let albumName = String(named.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)[1])
        let url = "https://api.deezer.com/search/album?q=\(artistName)%20\(albumName)"
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { ( data, responce, error) in
                if let data = data {
                    do {
                        let album = try JSONDecoder().decode(Album.self, from: data)
                        self.imageUrl = album.data[0].coverImageLink
                        self.updateUI()
                    } catch {
                        print("Ah sh*t, here we go again: \(error)")
                    }
                }
                }.resume()
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async  {
            self.albumCoverImageView.dowloadFromServer(link: self.imageUrl)
            self.artistNameLabel.text = self.deezerAPI.album.data[0].artist.name
            self.albumTitleLabel.text = self.deezerAPI.album.data[0].albumTitle
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        searchAlbum(named: searchTextField.text!)
    }
    
}

