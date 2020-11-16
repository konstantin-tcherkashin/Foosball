//
//  UIAlert+Helpers.swift
//  Foosball
//
//  Created by Константин on 16.11.2020.
//

import UIKit

extension UIAlertController {

    static func present(title: String?, message: String?=nil, actions: UIAlertAction..., on viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach({ alert.addAction($0) })
        viewController.present(alert, animated: true, completion: nil)
    }

}

extension UIAlertAction {

    static let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

}
