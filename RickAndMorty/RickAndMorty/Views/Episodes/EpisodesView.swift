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

  let collection = EpisodesCollectionView()
  let searchView = SearchView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    
    setupSubviews()
    setupConstraints()
  }

  private func setupSubviews() {
    addSubview(logo)
    addSubview(searchView)
    addSubview(collection)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      // logo constraints
      logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 48),
      logo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
      logo.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),

      // search
      searchView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 48),
      searchView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
      searchView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),


      // collection constraints
      collection.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 24),
      collection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      collection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      collection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
