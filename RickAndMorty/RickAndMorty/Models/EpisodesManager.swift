//
//  EpisodesManager.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import Foundation

protocol EpisodesManagerDelegate {
  func didLoadEpisodes(_ episodesManager: EpisodesManager, episodes: [EpisodeModel], pagesInfo: EpisodesData.Info?)
  func didEndupWithError(error: Error)
}

enum FilterOption: String, CaseIterable {
  case name, episode
}

struct EpisodesManager {

  var delegate: EpisodesManagerDelegate?

  private let episodeUrl = "https://rickandmortyapi.com/api/episode"
  private var previousPageUrl: String?
  private var characterManager = CharacterManager()

  mutating func loadEpisodes() {
    previousPageUrl = episodeUrl
    fetchExtendedData(for: episodeUrl)
  }

  mutating func loadEpisodes(filter: FilterOption, str: String) {
    previousPageUrl = episodeUrl
    fetchExtendedData(for: "\(episodeUrl)/?\(filter.rawValue)=\(str)")
  }

  mutating func loadEpisodes(ids: [Int]) {
    if ids.isEmpty {
      delegate?.didLoadEpisodes(self, episodes: [], pagesInfo: nil)
      return
    }
    previousPageUrl = episodeUrl
    let urlString = episodeUrl + "/[\(ids.map { "\($0)" }.joined(separator: ","))]"
    fetchSimplifiedData(for: urlString)
  }

  mutating func loadEpisodes(nextPageUrl: String?) {
    if nextPageUrl != nil && nextPageUrl != previousPageUrl {
      previousPageUrl = nextPageUrl
      fetchExtendedData(for: nextPageUrl!)
    }
  }

  private func fetchExtendedData(for url: String) {
    if let url = URL(string: url) {
      let session = URLSession(configuration: .default)

      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          print("error requesting source")
          delegate?.didEndupWithError(error: error!)
          return
        }

        if let data, let data: EpisodesData = parseJSON(episodesData: data) {
          let episodes = data.results.map { data in
            EpisodeModel(
              id: data.id,
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

  private func fetchSimplifiedData(for url: String) {
    if let url = URL(string: url) {
      let session = URLSession(configuration: .default)

      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          print("error requesting source")
          delegate?.didEndupWithError(error: error!)
          return
        }

        if let data, let data: [Episode] = parseJSON(episodesData: data) {
          let episodes = data.map { data in
            EpisodeModel(
              id: data.id,
              episode: data.episode,
              name: data.name,
              character: data.characters.randomElement() ?? ""
            )
          }

          delegate?.didLoadEpisodes(self, episodes: episodes, pagesInfo: nil)
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
      print("error decoding extended data")
      delegate?.didEndupWithError(error: error)
      return nil
    }
  }

  private func parseJSON(episodesData: Data) -> [Episode]? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode([Episode].self, from: episodesData)
      return decodedData
    } catch {
      print("error decoding simplified data")
      delegate?.didEndupWithError(error: error)
      return nil
    }
  }

}
