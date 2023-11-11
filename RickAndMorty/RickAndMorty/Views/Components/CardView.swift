//
//  CardView.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 7.11.23.
//

import UIKit

class CardView: UIView {
  private let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  var cornerRadius: CGFloat = 10.0
  var bgColor: UIColor? = UIColor(named: "card_bg")

  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false

    setupLayout()
  }

  override func addSubview(_ view: UIView) {
    if view == containerView {
      super.addSubview(view)
    } else {
      containerView.addSubview(view)
    }
  }

  private func setupLayout() {

    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.2
    layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
    layer.shadowRadius = 5.0
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale

    containerView.backgroundColor = bgColor
    containerView.layer.cornerRadius = cornerRadius
    containerView.layer.masksToBounds = true

    addSubview(containerView)

    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
