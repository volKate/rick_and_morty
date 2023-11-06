//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 6.11.23.
//

import UIKit

class EpisodeCell: UICollectionViewCell {
  var characterImage: UIImageView = {
    let imagePlaceholder = UIImage(named: "img_placeholder")
    let view = UIImageView(image: imagePlaceholder)
    view.contentMode = .scaleAspectFill

    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  var characterName: UITextView = {
    let view = UITextView()
    view.text = ""

    return view
  }()

  var episodeStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical

    stack.translatesAutoresizingMaskIntoConstraints = false

    return stack
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupSubviews()
    setupConstraints()
  }

  func updateName(_ name: String) {
    characterName.text = name
  }

  private func setupSubviews() {
    [
      characterImage,
      characterName
    ]
      .forEach { episodeStackView.addArrangedSubview($0) }

    addSubview(episodeStackView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      episodeStackView.topAnchor.constraint(equalTo: topAnchor),
      episodeStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      episodeStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      episodeStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
