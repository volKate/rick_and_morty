//
//  EpisodeCardView.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 7.11.23.
//

import UIKit

class EpisodeCardView: UIView {
  private var card = CardView()
  var episodeInfoPanel = EpisodeInfoPanel()

  var characterImage: UIImageView = {
    let imagePlaceholder = UIImage(named: "img_placeholder")
    let view = UIImageView(image: imagePlaceholder)
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true

    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  var characterName: UITextView = {
    let view = UITextView()
    view.text = ""
    view.font = .systemFont(ofSize: 20.0, weight: .semibold)
    view.isScrollEnabled = false
    view.isEditable = false
    view.isSelectable = false
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false

    setupSubviews()
    setupConstraints()
  }

  private func setupSubviews() {
    card.addSubview(characterImage)
    card.addSubview(characterName)
    card.addSubview(episodeInfoPanel)
    addSubview(card)
  }

  private func setupConstraints() {
    characterImage.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

    NSLayoutConstraint.activate([
      card.topAnchor.constraint(equalTo: topAnchor),
      card.bottomAnchor.constraint(equalTo: bottomAnchor),
      card.leadingAnchor.constraint(equalTo: leadingAnchor),
      card.trailingAnchor.constraint(equalTo: trailingAnchor),

      characterImage.leadingAnchor.constraint(equalTo: card.leadingAnchor),
      characterImage.trailingAnchor.constraint(equalTo: card.trailingAnchor),
      characterImage.topAnchor.constraint(equalTo: card.topAnchor),

      characterName.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 8),
      characterName.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16.0),
      characterName.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16.0),
      characterName.heightAnchor.constraint(equalToConstant: 36.0),

      episodeInfoPanel.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 16.0),
      episodeInfoPanel.leadingAnchor.constraint(equalTo: card.leadingAnchor),
      episodeInfoPanel.trailingAnchor.constraint(equalTo: card.trailingAnchor),
      episodeInfoPanel.bottomAnchor.constraint(equalTo: card.bottomAnchor),
      episodeInfoPanel.heightAnchor.constraint(greaterThanOrEqualToConstant: 70.0)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
