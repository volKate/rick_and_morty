//
//  FilterSelectButton.swift
//  RickAndMorty
//
//  Created by Kate Volkova on 11.11.23.
//

import UIKit

protocol FilterSelectDelegate {
  func didUpateFilter(_ filter: String)
}

class FilterSelectButton: UIButton {
  var delegate: FilterSelectDelegate?

  var selectedFilter: FilterOption = FilterOption.episode {
    didSet {
      let title = "Filter by " + selectedFilter.rawValue
      var menuChildren: [UIMenuElement] = []
      menu?.children.forEach {
        menuChildren.append(
          UIAction(title: $0.title, state: $0.title == selectedFilter.rawValue ? .on : .off, handler: filterAction)
        )
      }
      menu = UIMenu(children: menuChildren)
      setTitle(title, for: .normal)
    }
  }

  func filterAction(action: UIAction) {
    delegate?.didUpateFilter(action.title)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false

    setupView()
  }

  private func setupView() {
    backgroundColor = UIColor(named: "bg_tint")
    setTitleColor(UIColor.accent, for: .normal)
    layer.cornerRadius = 8.0

    setImage(
      UIImage(systemName: "line.3.horizontal.decrease")?
        .withTintColor(UIColor(named: "gray_dark") ?? UIColor.gray)
        .withRenderingMode(.alwaysOriginal),
      for: .normal
    )

    showsMenuAsPrimaryAction = true


    var menuChildren: [UIMenuElement] = []
    FilterOption.allCases.forEach {
      let action = UIAction(title: $0.rawValue, handler: filterAction)
      if selectedFilter == $0 {
        action.state = .on
      }
      menuChildren.append(action)
    }
    menu = UIMenu(children: menuChildren)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
