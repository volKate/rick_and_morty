//
//  CharacterData.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import Foundation

struct CharacterData: Decodable {
  let id: Int
  let name: String
  let image: String
  let gender: String
  let species: String
  let status: String
  let origin: Origin
  let location: Location
  let type: String
}

struct Origin: Decodable {
  let name: String
  let url: String
}

struct Location: Decodable {
  let name: String
  let url: String
}
