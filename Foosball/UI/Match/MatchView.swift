//
//  MatchView.swift
//  Foosball
//
//  Created by Константин on 16.11.2020.
//

import UIKit

protocol MatchViewDelegate: AnyObject {

    func plusTapped(firstPlayer: Bool)
    func minusTapped(firstPlayer: Bool)
    func avatarTapped(firstPlayer: Bool)

}

enum MatchViewStates {
    case normal, finished
}

protocol MatchViewProtocol where Self: UIView {

    var viewModel: MatchViewModel! { get set }
    var delegate: MatchViewDelegate? { get set }

    typealias States = MatchViewStates
    func set(state: States)
}


final class MatchView: UIView, MatchViewProtocol {

    @IBOutlet private weak var firstPlayerView: PlayerMatchView! {
        didSet {
            firstPlayerView.delegate = self
        }
    }
    @IBOutlet private weak var secondPlayerView: PlayerMatchView! {
        didSet {
            secondPlayerView.delegate = self
        }
    }
    @IBOutlet private weak var mainButton: UIButton! {
        didSet {
            mainButton?.layer.cornerRadius = 8
        }
    }

    private lazy var confetti: ConfettiView = {
        let instance = ConfettiView(frame: bounds)
        addSubview(instance)
        return instance
    }()

    var delegate: MatchViewDelegate?

    var viewModel: MatchViewModel! {
        didSet {
            guard let model = viewModel else { return }

            updateChildViewModels()
            mainButton.setTitle(model.actionTitle, for: .normal)
            mainButton.backgroundColor = viewModel.actionColor
        }
    }



    func set(state: MatchViewProtocol.States) {
        if state == .finished {
            confetti.start(duration: 3)
        }
        animatePlayerViews(
            firstWon: viewModel.result.state == .firstWon,
            secondWon: viewModel.result.state == .secondWon
        )
    }

}

extension MatchView: PlayerMatchViewDelegate {

    func minusTapped(in matchView: PlayerMatchView) {
        delegate?.minusTapped(firstPlayer: matchView == firstPlayerView)
    }

    func plusTapped(in matchView: PlayerMatchView) {
        delegate?.plusTapped(firstPlayer: matchView == firstPlayerView)
    }

    func avatarTapped(in matchView: PlayerMatchView) {
        delegate?.avatarTapped(firstPlayer: matchView == firstPlayerView)
    }

}


private extension MatchView {

    func updateChildViewModels() {
        guard let model = viewModel else { return }

        var color: UIColor = .lightGray

        switch model.result.state {
        case .firstWon:
            color = .systemGreen
        case .secondWon:
            color = .systemRed
        default:
            break
        }

        firstPlayerView.update(
            model.firstPlayer,
            goals: model.result.firstPlayerGoals,
            color: color
        )

        switch model.result.state {
        case .firstWon:
            color = .systemRed
        case .secondWon:
            color = .systemGreen
        default:
            break
        }

        secondPlayerView.update(
            model.secondPlayer,
            goals: model.result.secondPlayerGoals,
            color: color
        )
    }

    func animatePlayerViews(firstWon: Bool, secondWon: Bool) {
        let winnerTransform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: 0, y: 64)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: []) {
            self.firstPlayerView.isHidden = secondWon
            self.firstPlayerView.transform = firstWon ?  winnerTransform : .identity

            self.secondPlayerView.isHidden = firstWon
            self.secondPlayerView.transform = secondWon ? winnerTransform : .identity
        }
    }

}
