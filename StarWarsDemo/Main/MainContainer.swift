//
//  MainContainer.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 26/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import UIKit

class MainContainer: UINavigationController {

    override func show(_ vc: UIViewController, sender: Any?) {
        viewControllers = [vc]
        setViewControllers(viewControllers, animated: true)
    }
    
}
