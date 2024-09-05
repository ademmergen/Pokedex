//
//  PokemonDetailTableViewCell.swift
//  Pokemon
//
//  Created by Adem Mergen on 26.08.2024.
//

import UIKit

final class PokemonDetailTableViewCell: UITableViewCell {
  
  @IBOutlet weak var propertyLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!
  @IBOutlet weak var downButton: UIButton!
  @IBOutlet weak var innerTableView: UITableView!
  
  private var expandedContent: [String] = []
  
  func configure(featureName: String, featureValue: String) {
    propertyLabel.text = featureName
    valueLabel.text = featureValue
    valueLabel.isHidden = false
    downButton.isHidden = true
  }
  
  func configure(featureName: String, isExpanded: Bool, expandedContent: [String]) {
    propertyLabel.text = featureName
    valueLabel.isHidden = true
    downButton.isHidden = false
    self.expandedContent = expandedContent
    innerTableView.reloadData()
  }
}

extension PokemonDetailTableViewCell: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return expandedContent.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "InnerCell")
    cell.textLabel?.text = expandedContent[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 45
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    innerTableView.deselectRow(at: indexPath, animated: true)
  }
}
