//
//  NavigationConfigurator.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 10/07/25.
//

import SwiftUI

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let navController = uiViewController.navigationController {
            configure(navController)
        }
    }
}
