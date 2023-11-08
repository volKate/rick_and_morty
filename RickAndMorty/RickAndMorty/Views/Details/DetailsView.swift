//
//  DetailsView.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 8.11.23.
//

import UIKit

class DetailsView: UIView {
  let detailsHeader = DetailsHeaderView()

  var informationsLabel: UILabel = {
    var label = UILabel()
    label.text = "Informations"
    label.font = .systemFont(ofSize: 20.0, weight: .medium)
    label.textColor = UIColor(named: "gray_dark")

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
    addSubview(detailsHeader)
    addSubview(informationsLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      detailsHeader.topAnchor.constraint(equalTo: topAnchor, constant: 64.0),
      detailsHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
      detailsHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0),

      informationsLabel.topAnchor.constraint(equalTo: detailsHeader.bottomAnchor, constant: 16.0),
      informationsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
      informationsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
