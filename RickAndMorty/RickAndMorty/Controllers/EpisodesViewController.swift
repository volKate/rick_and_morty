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

  var episodes: [EpisodeModel] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    episodesManager.delegate = self
    episodesView.collection.dataSource = self
    episodesView.collection.delegate = self

    navigationController?.setNavigationBarHidden(true, animated: false)

    episodesManager.loadEpisodes()

    setupSubviews()
  }

  private func setupSubviews() {
    view.addSubview(episodesView)

    NSLayoutConstraint.activate([
      episodesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      episodesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      episodesView.topAnchor.constraint(equalTo: view.topAnchor),
      episodesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

}

extension EpisodesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return episodes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = episodesView.collection.dequeueReusableCell(withReuseIdentifier: "episode_cell", for: indexPath) as! EpisodeCell
    let episode = episodes[indexPath.row]
    let name = "\(episode.name) | \(episode.episode)"
    cell.updateEpisodeName(name)
    cell.updateCharacterUrl(episode.character)
    return cell
  }

}

extension EpisodesViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let spacing: CGFloat = 24.0
    return CGSize(width: collectionView.bounds.width - spacing * 2.0, height: 357.0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    56.0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      section == 0 ?
        UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0) :
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
}

extension EpisodesViewController: EpisodesManagerDelegate {
  func didLoadEpisodes(_ episodesManager: EpisodesManager, episodes: [EpisodeModel]) {
    DispatchQueue.main.async {
      self.episodes = episodes
      self.episodesView.collection.reloadData()
    }
  }
  
  func didEndupWithError(_ episodesManager: EpisodesManager, error: Error) {
    // handle error
  }

}
