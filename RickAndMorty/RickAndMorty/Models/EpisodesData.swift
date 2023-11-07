//
//  EpisodesData.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import Foundation

struct EpisodesData: Decodable {
  let results: [Episode]
  let info: Info

  struct Info: Decodable {
    let pages: Int
    let next: String?
  }
}

struct Episode: Decodable {
  let id: Int
  let name: String
  let episode: String
  let characters: [String]
}

