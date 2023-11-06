//
//  EpisodesManager.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import Foundation

protocol EpisodesManagerDelegate {
  func didLoadEpisodes(_ episodesManager: EpisodesManager, episodes: [EpisodeModel])
  func didEndupWithError(_ episodesManager: EpisodesManager, error: Error)
}

struct EpisodesManager {

  var delegate: EpisodesManagerDelegate?

  private let episodeUrl = "https://rickandmortyapi.com/api/episode"
  private var characterManager = CharacterManager()

  func loadEpisodes() {
    if let url = URL(string: episodeUrl) {
      let session = URLSession(configuration: .default)

      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          print("error requesting source")
          delegate?.didEndupWithError(self, error: error!)
          return
        }

        if let data, let episodes = parseJSON(episodesData: data) {
          delegate?.didLoadEpisodes(self, episodes: episodes)
        }
      }

      task.resume()
    }
  }

  private func parseJSON(episodesData: Data) -> [EpisodeModel]? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(EpisodesData.self, from: episodesData)
      return decodedData.results.map { data in
        EpisodeModel(
          episode: data.episode,
          name: data.name,
          character: data.characters.randomElement() ?? ""
        )
      }
    } catch {
      print("error decoding data")
      delegate?.didEndupWithError(self, error: error)
      return nil
    }
  }
  
}
