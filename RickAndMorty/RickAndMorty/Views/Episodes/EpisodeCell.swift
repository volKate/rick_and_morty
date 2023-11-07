//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 6.11.23.
//

import UIKit

class EpisodeCell: UICollectionViewCell {
  var card = EpisodeCardView()
  var characterManager = CharacterManager()
  var character: CharacterModel?

  override init(frame: CGRect) {
    super.init(frame: frame)

    characterManager.delegate = self

    setupSubviews()
  }

  func updateEpisodeName(_ name: String) {
    card.episodeInfoPanel.episodeName.text = name
  }

  func updateCharacterUrl(_ url: String) {
    characterManager.loadCharacter(with: url)
  }

  func updateCharacterUI() {
    DispatchQueue.global().async { [weak self] in
      if let imageUrlString = self?.character?.image,
         let url = URL(string: imageUrlString),
         let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.card.characterImage.image = image
          }
        }
      }
    }

    card.characterName.text = character?.name
  }

  private func setupSubviews() {
    addSubview(card)

    NSLayoutConstraint.activate([
      card.topAnchor.constraint(equalTo: topAnchor),
      card.bottomAnchor.constraint(equalTo: bottomAnchor),
      card.leadingAnchor.constraint(equalTo: leadingAnchor),
      card.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension EpisodeCell: CharacterManagerDelegate {
  func didLoadCharacter(_ characterManager: CharacterManager, character: CharacterModel) {
    DispatchQueue.main.async {
      self.character = character
      self.updateCharacterUI()
    }
  }

  func didEndupwithError(error: Error) {
    //
  }
}
