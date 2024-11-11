//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Mohamed Salah on 16/08/2024.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    // MARK: - UIViewController Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainNavigationViewController()
    }
    
    private func setupMainNavigationViewController() {
        let navigationController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mainNavigationController")
        
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
        
        navigationController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationController.view.topAnchor.constraint(equalTo: view.topAnchor),
            navigationController.view.heightAnchor.constraint(equalToConstant: 600),
            navigationController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
