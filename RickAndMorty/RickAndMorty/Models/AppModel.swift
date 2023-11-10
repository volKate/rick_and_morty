//
//  AppModel.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 9.11.23.
//

import Foundation

struct AppModel {
  private(set) var favouriteEpisodes: Set<Int>
  let userDefaults = UserDefaults()

  init() {
    if let favourites = userDefaults.array(forKey: "favourites") as? [Int] {
      favouriteEpisodes = Set(favourites)
    } else {
      favouriteEpisodes = Set()
    }
  }

  func persistData() {
    userDefaults.set(Array(favouriteEpisodes), forKey: "favourites")
  }

  mutating func addEpisodeToFavourites(id: Int) {
    favouriteEpisodes.insert(id)
    persistData()
  }

  mutating func removeEpisodeFromFavourites(id: Int) {
    favouriteEpisodes.remove(id)
    persistData()
  }
}

class AppManager {
  private var app = AppModel()

  var favourites: Set<Int> {
    app.favouriteEpisodes
  }

  func addEpisodeToFavourites(id: Int) {
    app.addEpisodeToFavourites(id: id)
  }

  func removeEpisodeFromFavourites(id: Int) {
    app.removeEpisodeFromFavourites(id: id)
  }
}
