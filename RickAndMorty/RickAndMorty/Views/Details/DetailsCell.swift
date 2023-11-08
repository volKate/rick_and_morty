//
//  DetailsCell.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 8.11.23.
//

import UIKit

class DetailsCell: UITableViewCell {
  var titleLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 16.0, weight: .bold)

    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  var valueLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 14.0)
    view.textColor = UIColor(named: "gray_dark")

    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    isUserInteractionEnabled = false

    setupSubviews()
    setupConstraints()
  }
  
  private func setupSubviews() {
    titleLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
    valueLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    addSubview(titleLabel)
    addSubview(valueLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40.0),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40.0),

      valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      valueLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
