//
//  FavouritesViewController.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import UIKit

class FavouritesViewController: UIViewController {  
  private let collection = EpisodesCollectionView()
  private var episodesManager = EpisodesManager()
  private var latestFavs: Set<Int> = Set()
  var appManager: AppManager?

  var episodes: [EpisodeModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collection.register(EpisodeCell.self, forCellWithReuseIdentifier: "fav_episode_cell")

    episodesManager.delegate = self
    collection.dataSource = self
    collection.delegate = self

    setupSubviews()
  }

  private func setupSubviews() {
    view.addSubview(collection)

    NSLayoutConstraint.activate([
      collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collection.topAnchor.constraint(equalTo: view.topAnchor),
      collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationItem.backButtonTitle = "Go back".uppercased()
    navigationItem.title = "Favourite Episodes"

    // uncomment to keep characters from changing after going back from details page
//    if appManager?.favourites != nil && latestFavs != appManager?.favourites {
//      latestFavs = appManager!.favourites
//      episodesManager.loadEpisodes(ids: Array(appManager!.favourites))
//    }
    episodesManager.loadEpisodes(ids: Array(appManager?.favourites ?? []))
  }

}

extension FavouritesViewController: EpisodesManagerDelegate {
  func didLoadEpisodes(_ episodesManager: EpisodesManager, episodes: [EpisodeModel], pagesInfo: EpisodesData.Info?) {
    DispatchQueue.main.async {
      self.episodes = episodes
      self.collection.reloadData()
    }
  }
  
  func didEndupWithError(error: Error) {
    //
  }
  

}

extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    episodes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collection.dequeueReusableCell(withReuseIdentifier: "fav_episode_cell", for: indexPath) as! EpisodeCell
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
  

}

extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
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

extension FavouritesViewController: FavouriteIconDelegate {
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
    collection.reloadItems(at: [indexPath])

    //    Code below updates the value, but not UI, why?

    //    let cell = episodesView.collection.dequeueReusableCell(withReuseIdentifier: "episode_cell", for: indexPath) as? EpisodeCell
    //    cell?.card.episodeInfoPanel.isFavourite = !isFavourite

  }
}

