//
//  Extensions.swift
//  DeezerSearcher
//
//  Created by Dima Opalko on 24.10.2019.
//  Copyright © 2019 Dima Opalko. All rights reserved.
//

import UIKit

fileprivate var activityView : UIView?

extension UIViewController {
    
    func showActivityIndicator() {
        activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = UIColor.init(white: 0.7, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        self.view.addSubview(activityView!)
    }
    
    func removeActivityIndicator() {
        activityView?.removeFromSuperview()
        activityView = nil
    }
    
}
