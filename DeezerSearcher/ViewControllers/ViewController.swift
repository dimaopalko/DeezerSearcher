//
//  ViewController.swift
//  DeezerSearcher
//
//  Created by Dima Opalko on 9/4/19.
//  Copyright © 2019 Dima Opalko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DeezerDownloadDelegate, HistoryTableViewDelegate {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    let deezerAPI = DeezerAPI()
    let persistanceManager = PersistanceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deezerAPI.downloadDelegate = self
        searchButton.layer.cornerRadius = searchButton.frame.height / 4
        hideKeyboardWhenTappedAround()
    }
    
    // IBActions

    @IBAction func historyButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "HistorySegue", sender: nil)
    }
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let text = searchTextField.text else { return }
        if text != "" {
            saveRequest(requestToSave: text)
            deezerAPI.searchAlbum(named: text)
            searchTextField.resignFirstResponder()
        } else {
            displayMessage(title: nil, userMessage: "Please enter artist and album title")
        }
    }
    
    // Delegate methods
    
    func didFinishDownload(artistName: String, albumTitle: String, coverImage: UIImage) {
        DispatchQueue.main.async {
        self.artistNameLabel.text = artistName
        self.albumTitleLabel.text = albumTitle
        self.albumCoverImageView.image = coverImage
        }
    }
    
    func didSelectHistoryItem(request: String) {
        searchTextField.text = ""
        deezerAPI.searchAlbum(named: request)
    }
    // Core Data Methods
    
    func getRequests() -> [Request] {
        let requests = persistanceManager.fetch(Request.self)
        return requests
    }
    
    func saveRequest(requestToSave: String) {
        let request = Request(context: persistanceManager.context)
        request.text = requestToSave
        persistanceManager.save()
    }
    
    // Alert Controller
    
    func displayMessage(title: String?, userMessage: String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: title, message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistorySegue" {
            if let historyVC = segue.destination as? HistoryTableViewController {
                historyVC.historyTableViewDelegate = self
                historyVC.savedRequests = getRequests().reversed()
            }
        }
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
