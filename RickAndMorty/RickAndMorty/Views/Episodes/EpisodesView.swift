//
//  EpisodesView.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import UIKit

class EpisodesView: UIView {
  let logo: UIImageView = {
    let img = UIImage(named: "logo")
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
    addSubview(logo)
  }

  private func setupConstraints() {
    // logo constraints
    NSLayoutConstraint.activate([
      logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 48),
      logo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
      logo.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
