//
//  EpisodesCollectionView.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 6.11.23.
//

import UIKit

class EpisodesCollectionView: UICollectionView {

  init() {
    let layout = UICollectionViewFlowLayout()
    super.init(frame: .zero, collectionViewLayout: layout)

    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
