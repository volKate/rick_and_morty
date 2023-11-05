//
//  LaunchScreenView.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import UIKit

class LaunchScreenView: UIView {

  let logoImage: UIImageView = {
    let img = UIImage(named: "logo")
    let view = UIImageView(image: img)
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  let loadingImage: UIImageView = {
    let img = UIImage(named: "loading")
    let view = UIImageView(image: img)
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
    addSubview(logoImage)
    addSubview(loadingImage)
  }

  private func setupConstraints() {
    // logo constraints
    NSLayoutConstraint.activate([
      logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 48),
      logoImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
      logoImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24)
    ])

    NSLayoutConstraint.activate([
      loadingImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      loadingImage.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
      loadingImage.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
      loadingImage.heightAnchor.constraint(lessThanOrEqualToConstant: 200)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
