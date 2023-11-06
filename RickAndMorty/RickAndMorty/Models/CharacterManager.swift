//
//  CharacterManager.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import Foundation

protocol CharacterManagerDelegate {
  func didLoadCharacter(_ characterManager: CharacterManager, character: CharacterModel)
  func didEndupwithError(error: Error)
}

struct CharacterManager {
  typealias completionHandler = (CharacterModel?, Error?) -> ()
  var delegate: CharacterManagerDelegate?

  private let characterUrl = "https://rickandmortyapi.com/api/character"

  func loadCharacter(with url: String, completion: completionHandler? = nil) {
    performRequest(with: url) { data, error in
      completion?(data, error)
    }
  }

  func loadCharacter(by id: Int) {
    performRequest(with: "\(characterUrl)/\(id)")
  }

  private func performRequest(with url: String, completion: completionHandler? = nil) {
    if let url = URL(string: url) {
      let session = URLSession(configuration: .default)

      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          print("error requesting source")
          completion?(nil, error)
          delegate?.didEndupwithError(error: error!)
          return
        }

        if let data, let character = parseJSON(characterData: data) {
          completion?(character, nil)
          delegate?.didLoadCharacter(self, character: character)
        }
      }

      task.resume()
    }
  }

  private func parseJSON(characterData: Data) -> CharacterModel? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(CharacterData.self, from: characterData)
      return CharacterModel(
        name: decodedData.name,
        image: decodedData.image,
        gender: decodedData.gender,
        species: decodedData.species,
        status: decodedData.status,
        origin: decodedData.origin.name,
        location: decodedData.location.name,
        type: decodedData.type
      )
    } catch {
      print("error decoding data")
      delegate?.didEndupwithError(error: error)
      return nil
    }
  }

}
