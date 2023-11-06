//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import UIKit

class EpisodesViewController: UIViewController {
  private let episodesView = EpisodesView()
  private var episodesManager = EpisodesManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    episodesManager.delegate = self
    navigationController?.setNavigationBarHidden(true, animated: false)

    episodesManager.loadEpisodes()

    setupSubviews()
  }

  private func setupSubviews() {
    view.addSubview(episodesView)

    NSLayoutConstraint.activate([
      episodesView.widthAnchor.constraint(equalTo: view.widthAnchor),
      episodesView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
  }
}

extension EpisodesViewController: EpisodesManagerDelegate {
  func didLoadEpisodes(_ episodesManager: EpisodesManager, episodes: [EpisodeModel]) {
    print(episodes)
  }
  
  func didEndupWithError(_ episodesManager: EpisodesManager, error: Error) {
    // handle error
  }
  

}
