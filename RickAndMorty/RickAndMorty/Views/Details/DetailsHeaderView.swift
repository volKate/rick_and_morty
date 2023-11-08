//
//  DetailsHeaderView.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 8.11.23.
//

import UIKit

class DetailsHeaderView: UIView {
  var characterImage: UIImageView = {
    let image = UIImage(named: "img_placeholder")
    let view = UIImageView(image: image)
    view.layer.cornerRadius = 50.0
    view.layer.borderWidth = 5.0
    view.layer.borderColor = UIColor(named: "gray_main")?.cgColor
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  var characterName: UILabel = {
    var label = UILabel()
    label.text = ""
    label.font = .systemFont(ofSize: 32.0)
    label.textAlignment = .center
    label.numberOfLines = 2
    label.adjustsFontSizeToFitWidth = true

    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false

    setupSubviews()
    setupConstraints()
  }

  private func setupSubviews() {
    addSubview(characterImage)
    addSubview(characterName)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      characterImage.topAnchor.constraint(equalTo: topAnchor),
      characterImage.centerXAnchor.constraint(equalTo: centerXAnchor),
      characterImage.heightAnchor.constraint(lessThanOrEqualToConstant: 150.0),
      characterImage.widthAnchor.constraint(lessThanOrEqualToConstant: 150.0),

      characterName.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 24.0),
      characterName.leadingAnchor.constraint(equalTo: leadingAnchor),
      characterName.trailingAnchor.constraint(equalTo: trailingAnchor),
      characterName.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    characterImage.layer.cornerRadius = characterImage.bounds.height / 2
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
