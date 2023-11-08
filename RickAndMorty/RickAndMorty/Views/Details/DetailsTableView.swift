//
//  DetailsTableView.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 8.11.23.
//

import UIKit

class DetailsTableView: UITableView {

  init() {
    super.init(frame: .zero, style: .plain)
    translatesAutoresizingMaskIntoConstraints = false
    register(DetailsCell.self, forCellReuseIdentifier: "details_cell")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
