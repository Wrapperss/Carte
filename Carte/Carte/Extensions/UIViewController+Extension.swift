//
//  UIViewControllerExtension.swift
//  creams
//
//  Created by hasayakey on 8/12/17.
//  Copyright © 2017 Creams.io. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case main = "Main"
    case mine = "Mine"

    func storyboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: self.rawValue, bundle:nil)
        return storyboard
    }
}

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }

    static func initFromStoryboard(name: StoryboardName = .main) -> Self {
        let storyboard = UIStoryboard(name: name.rawValue, bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            return Self()
        }
        return controller
    }
}

// MARK: - For iOS8 crash - http://stackoverflow.com/questions/25149604/are-view-controllers-with-nib-files-broken-in-ios-8-beta-5

extension UIViewController: StoryboardInitializable {

    static func initFromNib() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}
