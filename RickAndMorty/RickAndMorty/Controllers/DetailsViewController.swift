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
    view.backgroundColor = .systemBackground

    detailsView.detailsTable.delegate = self
    detailsView.detailsTable.dataSource = self

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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
    let buttonItem = UIBarButtonItem(image: UIImage(named: "mini_logo"), style: .plain, target: nil, action: nil)
    navigationItem.rightBarButtonItem = buttonItem
    navigationController?.navigationBar.tintColor = UIColor(named: "text_main")
  }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    6
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = detailsView.detailsTable.dequeueReusableCell(withIdentifier: "details_cell") as! DetailsCell
    let titles = ["Gender", "Status", "Species", "Origin", "Type", "Location"]
    let values = [character.gender, character.status, character.species, character.origin, character.type, character.location]
    if titles.indices.contains(indexPath.row) && values.indices.contains(indexPath.row) {
      let value = values[indexPath.row]

      cell.titleLabel.text = titles[indexPath.row]
      cell.valueLabel.text = value == "" ? "Unknown" : value
    }

    return cell
  }

}
