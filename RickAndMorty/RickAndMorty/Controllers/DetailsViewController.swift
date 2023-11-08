//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import UIKit

class DetailsViewController: UIViewController {
  var character: CharacterModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(false, animated: false)
    view.backgroundColor = .systemBackground
  }

  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

}
