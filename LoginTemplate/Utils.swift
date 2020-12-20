//
//  Utils.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import UIKit
import SnapKit

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

extension UIButton {
    static func loginButton(title: String, color: UIColor, action: Selector) -> UIButton {
        let btn = UIButton()
        let attr: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .semibold),
            .foregroundColor: UIColor.white,
        ]
        let attrString = NSAttributedString(string: title, attributes: attr)
        btn.setAttributedTitle(attrString, for: .normal)
        btn.backgroundColor = color
        btn.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        btn.layer.cornerRadius = 8
        btn.addTarget(nil, action: action, for: .touchUpInside)
        return btn
    }
}
