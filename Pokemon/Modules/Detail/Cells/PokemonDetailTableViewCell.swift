//
//  PokemonDetailTableViewCell.swift
//  Pokemon
//
//  Created by Adem Mergen on 26.08.2024.
//

import UIKit

class PokemonDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var innerTableView: UITableView!

    var isExpanded: Bool = false
    var expandedContent: [String] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        downButton.addTarget(self, action: #selector(toggleExpand), for: .touchUpInside)
        innerTableView.delegate = self
        innerTableView.dataSource = self
        innerTableView.isHidden = true
    }

    @objc func toggleExpand() {
        isExpanded.toggle()
        innerTableView.isHidden = !isExpanded
        innerTableView.reloadData()
      print("basarili")
    }

    func configure(with title: String, value: String?) {
        propertyLabel.text = title
        valueLabel.text = value ?? ""
        downButton.isHidden = true
        innerTableView.isHidden = true
    }

    func configure(with title: String, expandedContent: [String]) {
        propertyLabel.text = title
        valueLabel.isHidden = true
        downButton.isHidden = false
        self.expandedContent = expandedContent
        innerTableView.isHidden = !isExpanded
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
}




