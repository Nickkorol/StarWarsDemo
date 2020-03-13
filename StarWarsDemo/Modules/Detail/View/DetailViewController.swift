//
//  DetailViewController.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 23/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
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
        titreView.clipsToBounds = true
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: titreView.frame.size.width, height: titreView.frame.size.height))
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = UIFont(name: "Star Jedi Rounded", size: 14)
        label.textColor = .yellow
        label.clipsToBounds = true
        
        titreView.addSubview(label)
        
        configureAnimation(label: label)
    }
}

extension DetailViewController {
    func configureAnimation(label: UILabel) {
        label.layer.transform = CATransform3DRotate(label.layer.transform, .pi/4, 1, 0, 0)
        var animations = [CABasicAnimation]()
        
        let positionAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        positionAnimation.fromValue = CGPoint(x: titreView.bounds.width/2, y: titreView.bounds.height*1.5)
        positionAnimation.toValue = CGPoint(x: titreView.bounds.width/2, y: -titreView.bounds.height/2)
        positionAnimation.duration = 15.0
        positionAnimation.autoreverses = false
        
        animations.append(positionAnimation)
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        opacityAnimation.beginTime = 7.0
        opacityAnimation.duration = 8.0
        opacityAnimation.autoreverses = false
        
        animations.append(opacityAnimation)
        
        let group = CAAnimationGroup()
        
        group.duration = 15.0
        group.animations = animations
        label.layer.add(group, forKey: nil)
    }
}
