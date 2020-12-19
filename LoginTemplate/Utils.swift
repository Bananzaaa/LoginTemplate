//
//  Utils.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import UIKit

extension UIViewController {
    
    func embedInNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
}

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: self, options: nil)?.first as! T
    }
}

extension String {
    var isReallyEmpty: Bool {
        return trimmingCharacters(in: .whitespaces).isEmpty
    }
}

extension UITextField {
    var isEmpty: Bool {
        return (text ?? "").isReallyEmpty
    }
}
