//
//  TriangleView.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 10.03.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class TriangleView: UIView {

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX * 3.0 / 4.0), y: rect.minY))
        context.addLine(to: CGPoint(x: (rect.maxX / 4.0), y: rect.minY))
        context.closePath()

        context.setFillColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.60)
        context.fillPath()
    }
}
