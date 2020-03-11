//
//  DetailViewController.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 23/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //@IBOutlet private var textLabel: TriangleLabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var titreView: UIView!
    
    var viewModel: DetailViewModel!
    private var films = [Film]()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.color = UIColor.gray
        activityIndicator.startAnimating()
        navigationItem.title = viewModel.person.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidLoad()
    }

}

extension DetailViewController: DetailViewInput {
    func showDetailUserInfo(text: String) {
        self.activityIndicator.stopAnimating()
        //self.textLabel.text = text
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: titreView.frame.size.width, height: titreView.frame.size.height))
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = UIFont(name: "Star Jedi Rounded", size: 14)
        label.textColor = .yellow
        label.layer.transform = CATransform3DRotate(label.layer.transform, .pi/4, 1, 0, 0)
        
        titreView.addSubview(label)
        
        //animation()
        
        var animations = [CABasicAnimation]()
        
        let animation1 = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation1.fromValue = CGPoint(x: titreView.bounds.width/2, y: titreView.bounds.height)
        animation1.toValue = CGPoint(x: titreView.bounds.width/2, y: -titreView.bounds.height)
        animation1.duration = 15.0
        animation1.autoreverses = false
        
        animations.append(animation1)
        
        let animation2 = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation2.fromValue = 1.0
        animation2.toValue = 0.0
        animation2.beginTime = 10.0
        animation2.duration = 5.0
        animation2.autoreverses = false
        
        animations.append(animation2)
        
        let group = CAAnimationGroup()
        
        group.duration = 15.0
        group.animations = animations
        label.layer.add(group, forKey: nil)
    }
}

extension DetailViewController {
    func animation() {
//        textLabel.layer.transform = CATransform3DRotate(textLabel.layer.transform, .pi/4, 1, 0, 0)
//
//        var animations = [CABasicAnimation]()
//
//        let animation1 = CABasicAnimation(keyPath: #keyPath(CALayer.position))
//        animation1.fromValue = CGPoint(x: view.bounds.width/2, y: view.bounds.height)
//        animation1.toValue = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
//        animation1.duration = 15.0
//        animation1.autoreverses = false
//
//        animations.append(animation1)
//
//        let animation2 = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
//        animation2.fromValue = 1.0
//        animation2.toValue = 0.0
//        animation2.beginTime = 10.0
//        animation2.duration = 5.0
//        animation2.autoreverses = false
//
//        animations.append(animation2)
//
//        let group = CAAnimationGroup()
//
//        group.duration = 15.0
//        group.animations = animations
//        textLabel.layer.add(group, forKey: nil)
    }
}
