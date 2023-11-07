//
//  EpisodesManager.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import Foundation

protocol EpisodesManagerDelegate {
  func didLoadEpisodes(_ episodesManager: EpisodesManager, episodes: [EpisodeModel], pagesInfo: EpisodesData.Info)
  func didEndupWithError(error: Error)
}

struct EpisodesManager {

  var delegate: EpisodesManagerDelegate?

  private let episodeUrl = "https://rickandmortyapi.com/api/episode"
  private var previousPageUrl: String?
  private var characterManager = CharacterManager()

  mutating func loadEpisodes() {
    previousPageUrl = episodeUrl
    fetchData(for: episodeUrl)
  }

  mutating func loadEpisodes(nextPageUrl: String?) {
    if nextPageUrl != nil && nextPageUrl != previousPageUrl {
      previousPageUrl = nextPageUrl
      fetchData(for: nextPageUrl!)
    }
  }

  private func fetchData(for url: String) {
    if let url = URL(string: url) {
      let session = URLSession(configuration: .default)

      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          print("error requesting source")
          delegate?.didEndupWithError(error: error!)
          return
        }

        if let data, let data = parseJSON(episodesData: data) {
          let episodes = data.results.map { data in
            EpisodeModel(
              episode: data.episode,
              name: data.name,
              character: data.characters.randomElement() ?? ""
            )
          }
          delegate?.didLoadEpisodes(self, episodes: episodes, pagesInfo: data.info)
        }
      }

      task.resume()
    }
  }

  private func parseJSON(episodesData: Data) -> EpisodesData? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(EpisodesData.self, from: episodesData)
      return decodedData
    } catch {
      print("error decoding data")
      delegate?.didEndupWithError(error: error)
      return nil
    }
  }

}
