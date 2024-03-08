//
//  UINavigationController+Extension.swift
//  QuotesApp
//
//  Created by Иван Захаров on 08.03.2024.
//

import UIKit

extension UINavigationController {
    var previousViewController: UIViewController? {
        viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
    }
}
