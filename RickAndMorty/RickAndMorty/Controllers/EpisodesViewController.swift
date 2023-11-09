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
  private var nextPageUrl: String?
  var appManager: AppManager?

  var episodes: [EpisodeModel] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    episodesManager.delegate = self
    episodesView.collection.dataSource = self
    episodesView.collection.delegate = self

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
    cell.navVC = navigationController
    let episode = episodes[indexPath.row]
    let name = "\(episode.name) | \(episode.episode)"
    cell.updateEpisodeName(name)
    cell.updateCharacterUrl(episode.character)

    cell.indexPathForCell = indexPath
    cell.id = episode.id
    if let favourites = appManager?.favourites {
      cell.card.episodeInfoPanel.isFavourite = favourites.contains(episode.id)
    }
    cell.card.episodeInfoPanel.delegate = self

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if (indexPath.row == episodes.count - 4) {
      episodesManager.loadEpisodes(nextPageUrl: nextPageUrl)
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: false)
    navigationItem.backButtonTitle = "Go back".uppercased()
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
    UIEdgeInsets(top: 5, left: 0, bottom: 24, right: 0)
  }
}

extension EpisodesViewController: EpisodesManagerDelegate {
  func didLoadEpisodes(_ episodesManager: EpisodesManager, episodes: [EpisodeModel], pagesInfo: EpisodesData.Info) {
    nextPageUrl = pagesInfo.next
    DispatchQueue.main.async {
      self.episodes += episodes
      self.episodesView.collection.reloadData()
    }
  }

  func didEndupWithError(error: Error) {
    // handle error
  }

}


extension EpisodesViewController: FavouriteIconDelegate {
  func didTapFavouriteIcon(id: Int, indexPath: IndexPath) {
    if let appManager {
      let isFavourite = appManager.favourites.contains(id)
      if isFavourite {
        appManager.removeEpisodeFromFavourites(id: id)
      } else {
        appManager.addEpisodeToFavourites(id: id)
      }
    }

    // this code works, but reload is visible
    episodesView.collection.reloadItems(at: [indexPath])

    //    Code below updates the value, but not UI, why?

    //    let cell = episodesView.collection.dequeueReusableCell(withReuseIdentifier: "episode_cell", for: indexPath) as? EpisodeCell
    //    cell?.card.episodeInfoPanel.isFavourite = !isFavourite

  }
}
