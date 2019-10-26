//
//  Protocols.swift
//  DeezerSearcher
//
//  Created by Dima Opalko on 9/10/19.
//  Copyright © 2019 Dima Opalko. All rights reserved.
//

import Foundation
import UIKit

protocol DeezerDownloadDelegate {
    func didFinishDownload(artistName: String, albumTitle: String, coverImage: UIImage)
}

protocol HistoryTableViewDelegate {
    func didSelectHistoryItem(request: String)
}
