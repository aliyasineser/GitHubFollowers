//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 26.07.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
