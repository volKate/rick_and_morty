//
//  TabBarViewController.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import UIKit

class TabBarViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
  }

  private func setupViews() {
    let episodesVC = EpisodesViewController()
    let episodesNavVC = UINavigationController(rootViewController: episodesVC)
    episodesNavVC.tabBarItem = UITabBarItem(
      title: nil,
      image: createTabBarIcon(systemName: "house"),
      selectedImage: createTabBarIcon(systemName: "house.fill")
    )

    let favouritesVC = FavouritesViewController()
    let favouritesNavVC = UINavigationController(rootViewController: favouritesVC)
    favouritesNavVC.tabBarItem = UITabBarItem(
      title: nil,
      image: createTabBarIcon(systemName: "heart"),
      selectedImage: createTabBarIcon(systemName: "heart.fill")
    )

    viewControllers = [episodesNavVC, favouritesNavVC]
  }

  private func createTabBarIcon(systemName: String) -> UIImage? {
    UIImage(systemName: systemName)?.withTintColor(.accent, renderingMode: .alwaysOriginal)
  }

}
