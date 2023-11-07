//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 6.11.23.
//

import UIKit

class EpisodeCell: UICollectionViewCell {
  var card = EpisodeCardView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupSubviews()
  }

  func updateEpisodeName(_ name: String) {
    card.episodeInfoPanel.episodeName.text = name
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
