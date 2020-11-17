//
//  PlayerView.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import UIKit

final class PlayerView: UIView {

    @IBOutlet private weak var avatarView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    func update(_ viewModel: PlayerViewModel) {
        avatarView.layer.cornerRadius = avatarView.bounds.width/2
        avatarView.contentMode = .scaleAspectFill
        avatarView.tintColor = .lightGray

        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            if let path = viewModel.avatarImagePath,
               let image = UIImage(
                contentsOfFile: documentsDirectory.appendingPathComponent(path).path
               ) {
                avatarView.image = image
            } else {
                avatarView.image = UIImage(systemName: "person.circle")
            }
        }


        nameLabel.text = viewModel.name
    }

}
