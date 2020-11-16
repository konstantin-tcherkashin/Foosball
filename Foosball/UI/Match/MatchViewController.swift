//
//  MatchViewController.swift
//  Foosball
//
//  Created by Константин on 11.11.2020.
//

import Foundation
import UIKit

final class MatchViewController: UIViewController {

    private var matchView: MatchViewProtocol {
        view as! MatchViewProtocol
    }

    private lazy var match = Match()
    private lazy var dataProvider: GameDataProvider = ServiceLocator.shared.gameDataProvider

    private lazy var dateFormatter: DateFormatter = {
        let instance = DateFormatter()
        instance.dateStyle = .short
        instance.timeStyle = .short
        return instance
    }()

    var contactsWrapper: ContactPickerWrapper?

    override func viewDidLoad() {
        super.viewDidLoad()
        matchView.delegate = self
        updateViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.view.addSubview(ConfettiView(frame: self.view.bounds))

    }

    private func updateViewModel() {
        matchView.viewModel = .init(match, dateFormatter: dateFormatter)
    }

    @IBAction func mainTapped(_ sender: UIButton) {

        switch match.state {

        case .configuring:
            guard match.firstPlayer != nil && match.secondPlayer != nil else {
                UIAlertController.present(
                    title: "Select players",
                    actions: UIAlertAction.init(title: "OK", style: .default, handler: nil),
                    on: self
                )
                return
            }
            match.state = .started
            updateViewModel()

        case .started:
            UIAlertController.present(
                title: "Are you sure you want to finish current match?",
                actions:
                    .init(title: "Finish", style: .destructive, handler: { _ in
                        self.match.state = .finished
                        self.dataProvider.add(match: self.match)
                        self.updateViewModel()
                        self.matchView.set(state: .finished)
                    }),
                .cancel,
                on: self)

        case .finished:
            match = Match(firstPlayer: match.firstPlayer, secondPlayer: match.secondPlayer)
            match.state = .configuring
            updateViewModel()
            matchView.set(state: .normal)
        }
    }

}

extension MatchViewController: MatchViewDelegate {

    func plusTapped(firstPlayer: Bool) {
        guard match.state == .started else { return }

        if firstPlayer {
            match.result.firstPlayerGoals += 1
        } else {
            match.result.secondPlayerGoals += 1
        }
        updateViewModel()
    }

    func minusTapped(firstPlayer: Bool) {
        guard match.state == .started else { return }

        if firstPlayer {
            match.result.firstPlayerGoals = max(0, match.result.firstPlayerGoals - 1)
        } else {
            match.result.secondPlayerGoals = max(0, match.result.secondPlayerGoals - 1)
        }

        updateViewModel()
    }

    func avatarTapped(firstPlayer: Bool) {
        contactsWrapper = ContactPickerWrapper(presentOn: self) { [weak self] player in
            if let player = player {
                self?.dataProvider.add(player: player)
            }
            if firstPlayer {
                self?.match.firstPlayer = player
            } else {
                self?.match.secondPlayer = player
            }
            self?.updateViewModel()
        }
    }

}
