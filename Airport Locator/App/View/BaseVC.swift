//
//  BaseVC.swift
//  Airport Locator
//
//  Created by Mohd Taha on 22/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation Bar
    func setRightButtonItem(type: UIBarButtonItem.SystemItem) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: type, target: self, action: #selector(onClickRightButtonItem))
        //self.navigationItem.rightBarButtonItem?.accessibilityLabel = "rightBarButtonItem"
    }
    
    // To intialize a loader in right bar button
    func setRightButtonLoader() {
        let indicator = UIActivityIndicatorView.init(frame: self.navigationItem.rightBarButtonItem?.customView?.frame ?? CGRect.init())
        if #available(iOS 13.0, *) {
            indicator.style = .medium
        } else {
            indicator.style = .gray
        }
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
    }
    
    func setPageTitle(_ title: String) {
        navigationItem.title = title
        //navigationItem.titleView?.accessibilityLabel = "navigationTitleLabel"
    }
    
    private func initBarButton(image: UIImage, tintColor: UIColor = .white) -> UIButton {
        let newImage = image.withRenderingMode(.alwaysTemplate)
        let button = UIButton.init(type: .system)
        button.frame = .init(origin: .zero, size: .init(width: 40, height: 40))
        button.setImage(newImage, for: [])
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = tintColor
        
        return button
    }
    
    // Only for overriding
    @objc func onClickRightButtonItem() {
        // Only for overriding
    }
}
