//
//  GFItemInfoVC.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 21.07.2022.
//

import UIKit

class GFItemInfoVC: UIViewController {

    let stackView       =  UIStackView()
    let itemInfoOne     = GFItemInfoView()
    let itemInfoTwo     = GFItemInfoView()
    let actionButton    = GFButton()
    
    weak var delegate: UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureStackview()
        configureBackgroundView()
        configureActionButton()
    }
  
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackview() {
        stackView.addArrangedSubview(itemInfoOne)
        stackView.addArrangedSubview(itemInfoTwo)
        
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
    }
    
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {}
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
