//
//  ConfettiView.swift
//  Foosball
//
//  Created by Константин on 16.11.2020.
//
///https://github.com/sudeepag/SAConfettiView

import UIKit

final class ConfettiView: UIView {

    private var colors = [UIColor]()

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        colors = [
            UIColor(red: 0.95, green: 0.40, blue: 0.27, alpha: 1.0),
            UIColor(red: 1.00, green: 0.78, blue: 0.36, alpha: 1.0),
            UIColor(red: 0.48, green: 0.78, blue: 0.64, alpha: 1.0),
            UIColor(red: 0.30, green: 0.76, blue: 0.85, alpha: 1.0),
            UIColor(red: 0.58, green: 0.39, blue: 0.55, alpha: 1.0)
        ]
        isUserInteractionEnabled = false
    }

    private lazy var emitter: CAEmitterLayer = {
        let instance = CAEmitterLayer()

        instance.emitterPosition = CGPoint(x: center.x, y: 0)
        instance.emitterShape = .line
        instance.emitterSize = CGSize(width: frame.size.width, height: 1)
        instance.beginTime = CACurrentMediaTime() + 0.3

        var cells = [CAEmitterCell]()
        for color in colors {
            cells.append(confettiWithColor(color: color))
        }

        instance.emitterCells = cells
        instance.birthRate = 0
        layer.addSublayer(instance)
        return instance
    }()

    func start(duration: Double) {
        emitter.birthRate = 1
        emitter.beginTime = CACurrentMediaTime()
        perform(#selector(self.stop), with: nil, afterDelay: duration)
    }

    @objc private func stop() {
        emitter.birthRate = 0
    }

    private func confettiWithColor(color: UIColor) -> CAEmitterCell {
        let intensity: Float = 0.5
        let confetti = CAEmitterCell()
        confetti.birthRate = 12.0 * intensity
        confetti.lifetime = 30 * intensity
        confetti.color = color.cgColor
        confetti.velocity = CGFloat(350 * intensity)
        confetti.velocityRange = CGFloat(80 * intensity)
        confetti.emissionLongitude = .pi
        confetti.emissionRange = .pi
        confetti.spin = CGFloat(3.5 * intensity)
        confetti.spinRange = CGFloat(4.0 * intensity)
        confetti.scaleRange = CGFloat(intensity/10)
        confetti.scaleSpeed = CGFloat(-0.1 * intensity)
        confetti.contents = UIImage(named: "triangle")?.cgImage
        return confetti
    }

}
