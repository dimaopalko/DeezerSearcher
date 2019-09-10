//
//  ViewController.swift
//  DeezerSearcher
//
//  Created by Dima Opalko on 9/4/19.
//  Copyright © 2019 Dima Opalko. All rights reserved.
//

import UIKit



class ViewController: UIViewController, DeezerDownloadDelegate {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var deezerAPI = DeezerAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deezerAPI.downloadDelegate = self
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let text = searchTextField.text else { return }
        if text != "" {
            deezerAPI.searchAlbum(named: text)
        }
    }
    
    func didFinishDownload(artistName: String, albumTitle: String, coverImage: UIImage) {
        DispatchQueue.main.async {
        self.artistNameLabel.text = artistName
        self.albumTitleLabel.text = albumTitle
        self.albumCoverImageView.image = coverImage
        }
    }
    
}

