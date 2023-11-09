//
//  AppModel.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 9.11.23.
//

import Foundation

struct AppModel {
  private(set) var favouriteEpisodes: Set<Int> = Set()

  mutating func addEpisodeToFavourites(id: Int) {
    favouriteEpisodes.insert(id)
  }

  mutating func removeEpisodeFromFavourites(id: Int) {
    favouriteEpisodes.remove(id)
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
