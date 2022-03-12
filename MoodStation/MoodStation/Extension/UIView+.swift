//
//  CustomDrawingView.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/11.
//

import UIKit.UIView

extension UIView {
    func drawMoodRectangle(mood: GradientStyle) {
        self.do { view in
            let gradient = CAGradientLayer()
            gradient.do {
                $0.colors = UIColor.makeGradientColors(by: mood)
                $0.locations = [0.0, 1.0]
                $0.startPoint = CGPoint(x: 0.0, y: 0.0)
                $0.endPoint = CGPoint(x: 0.0, y: 1.0)
                $0.frame = view.bounds
                $0.cornerRadius = 10.5
            }
            view.layer.addSublayer(gradient)
        }
    }
}
