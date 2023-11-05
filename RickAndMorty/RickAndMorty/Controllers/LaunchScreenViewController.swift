//
//  LaunchScreenViewController.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 5.11.23.
//

import UIKit

class LaunchScreenViewController: UIViewController {
  private let launchScreenView = LaunchScreenView()
  private var continueAnimate = true

  override func viewDidLoad() {
    super.viewDidLoad()

    setupSubviews()
  }

  override func viewDidAppear(_ animated: Bool) {
    animateLoading()
    // redirect to root VC after 3 seconds
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
      self.continueAnimate = false
      self.redirectToRootVC()
    })
  }

  private func redirectToRootVC() {
    let rootVC = TabBarViewController()

    rootVC.modalPresentationStyle = .fullScreen
    present(rootVC, animated: true)
  }

  private func animateLoading() {
    UIView.animate(
      withDuration: 1.5,
      delay: 0.0,
      options: [.curveLinear]
    ) {
      let loadingImage = self.launchScreenView.loadingImage
      loadingImage.transform = loadingImage.transform.rotated(by: .pi)
    } completion: { isComplete in
      if isComplete && self.continueAnimate {
        self.animateLoading()
      }
    }
  }

  private func setupSubviews() {
    view.addSubview(launchScreenView)

    NSLayoutConstraint.activate([
      launchScreenView.widthAnchor.constraint(equalTo: view.widthAnchor),
      launchScreenView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
  }

}
