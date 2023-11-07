//
//  EpisodeInfoPanel.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 7.11.23.
//

import UIKit

class EpisodeInfoPanel: UIView {
  var bgColor: UIColor? = UIColor(named: "gray_main")
  var cornerRadius: CGFloat = 16.0
  var insetX: CGFloat = 18.0
  var insetY: CGFloat = 14.0

  var tvIcon: UIImageView = {
    let icon = UIImage(systemName: "play.tv")?
      .withTintColor(UIColor(named: "gray_dark") ?? UIColor.gray, renderingMode: .alwaysOriginal)
    let view = UIImageView(image: icon)
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  var episodeName: UITextView = {
    let view = UITextView()
    view.text = ""
    view.font = .systemFont(ofSize: 16.0, weight: .regular)
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  var heartIcon: UIImageView = {
    let icon = UIImage(systemName: "heart")
    let view = UIImageView(image: icon)
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = bgColor
    layer.cornerRadius = cornerRadius
    layoutMargins = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)

    setupSubviews()
    setupConstraints()
  }

  private func setupSubviews() {
    addSubview(tvIcon)
    addSubview(episodeName)
    addSubview(heartIcon)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tvIcon.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
      tvIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
      tvIcon.widthAnchor.constraint(equalToConstant: 32.0),
      tvIcon.heightAnchor.constraint(equalToConstant: 32.0),

      episodeName.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
      episodeName.leadingAnchor.constraint(equalTo: tvIcon.trailingAnchor, constant: 10.0),
      episodeName.trailingAnchor.constraint(equalTo: heartIcon.leadingAnchor, constant: -16.0),
      episodeName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),

      heartIcon.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
      heartIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
      heartIcon.widthAnchor.constraint(equalToConstant: 32.0),
      heartIcon.heightAnchor.constraint(equalToConstant: 32.0)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
