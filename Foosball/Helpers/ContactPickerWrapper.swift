//
//  ContactPickerWrapper.swift
//  Foosball
//
//  Created by Константин on 16.11.2020.
//

import Foundation
import ContactsUI

final class ContactPickerWrapper: NSObject {

    private var completion: ((Player?) -> Void)

    init(presentOn viewController: UIViewController, completion block: @escaping (Player?) -> Void) {
        completion = block
        super.init()

        let peoplePicker = CNContactPickerViewController()
        peoplePicker.delegate = self
        viewController.present(peoplePicker, animated: true, completion: nil)
    }

}

extension ContactPickerWrapper: CNContactPickerDelegate {

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        var player: Player = .init(identifier: contact.identifier, name: "", avatarPath: nil)

        let name = [contact.givenName, contact.familyName].filter({ !$0.isEmpty }).joined(separator: " ")
        player.name = name

        if let data = contact.thumbnailImageData {
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileName = "\(player.identifier).jpg"
                let path = documentsDirectory.appendingPathComponent(fileName).path
                if FileManager.default.fileExists(atPath: path) {
                    try? FileManager.default.removeItem(atPath: path)
                }
                FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
                player.avatarPath = fileName
            }

        }

        completion(player)
        picker.dismiss(animated: true, completion: nil)
    }

}
