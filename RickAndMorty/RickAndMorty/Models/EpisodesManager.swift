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
          var episodesWithCharacters: [EpisodeModel] = []
          episodes.forEach { episode in
            if let characterUrl = episode.characters.randomElement() {
              characterManager.loadCharacter(with: characterUrl) { character, error in
                if error != nil {
                  print("error loading character")
                }

                if let character {
                  episodesWithCharacters.append(
                    EpisodeModel(
                      episode: episode.episode,
                      name: episode.name,
                      character: character
                    )
                  )
                }

              }
            }
          }

          delegate?.didLoadEpisodes(self, episodes: episodesWithCharacters)
        }
      }

      task.resume()
    }
  }

  private func parseJSON(episodesData: Data) -> [Episode]? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(EpisodesData.self, from: episodesData)
      return decodedData.results
    } catch {
      print("error decoding data")
      delegate?.didEndupWithError(self, error: error)
      return nil
    }
  }
  
}
