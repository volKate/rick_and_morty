//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import UIKit

class DetailsViewController: UIViewController {
  var character: CharacterModel!
  var characterImage: UIImage?

  var detailsView = DetailsView()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(false, animated: false)
    view.backgroundColor = .systemBackground

    setupSubviews()
    updateUI()
  }

  private func setupSubviews() {
    view.addSubview(detailsView)

    NSLayoutConstraint.activate([
      detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  private func updateUI() {
    detailsView.detailsHeader.characterImage.image = characterImage
    detailsView.detailsHeader.characterName.text = character.name
  }

  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

}
