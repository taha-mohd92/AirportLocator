//
//  Routing.swift
//  Airport Locator
//
//  Created by Mohd Taha on 21/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import UIKit

class Routing {
    
    public static func launch(window: UIWindow) {
        window.openMapVC()
        window.makeKeyAndVisible()
    }
}

extension UIWindow {
    
    func openMapVC() {
        let vc = AirportMapVC()
        self.changeRootViewController(to: UINavigationController(rootViewController: vc))
    }
    
    func changeRootViewController(to desiredViewController: UIViewController) {
        if rootViewController != nil,
            let snapshot = self.snapshotView(afterScreenUpdates: true) {
            
            desiredViewController.view.addSubview(snapshot)
            
            for view in subviews {
                view.removeFromSuperview()
            }
            
            rootViewController = desiredViewController
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    
                    snapshot.layer.opacity = 0
                    
            }, completion: { (finished) in
                snapshot.removeFromSuperview()
            })
        } else {
            rootViewController = desiredViewController
        }
    }
}
