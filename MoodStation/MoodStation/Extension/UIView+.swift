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
    
    func drawEmptyImageView(color: UIColor?) {
        self.do { view in
            let layer = CAShapeLayer().then { layer in
                color.flatMap { layer.strokeColor = $0.cgColor }
                layer.lineDashPattern = [6.5, 7]
                layer.frame = view.bounds
                layer.fillColor = nil
                layer.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: 6).cgPath
            }
            view.layer.addSublayer(layer)
        }
        self.layoutIfNeeded()
    }
    
    func drawGradientUserInfo() {
        self.do { view in
            let gradient = CAGradientLayer()
            gradient.do {
                $0.colors = UIColor.crewInfo.compactMap { $0?.cgColor }
                $0.type = .radial
                $0.startPoint = CGPoint(x: 0.5, y: 0.5)
                $0.endPoint = CGPoint(x: 1.0, y: 1.0)
                $0.frame = view.bounds
            }
            view.layer.addSublayer(gradient)
        }
    }
}
