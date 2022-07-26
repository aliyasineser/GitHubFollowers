//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 26.07.2022.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
