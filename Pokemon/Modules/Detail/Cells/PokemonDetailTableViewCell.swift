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
  
  var isExpanded: Bool = false
  var expandedContent: [String] = []
    
  override func awakeFromNib() {
          super.awakeFromNib()
          downButton.addTarget(self, action: #selector(toggleExpand), for: .touchUpInside)
      }
  @objc func toggleExpand() {
         isExpanded.toggle()
    print("basarili")
         // Expand işlemini delegate veya notification ile üst ViewController'a bildir
     }
     
  func configure(with title: String, value: String?) {
      propertyLabel.text = title
      valueLabel.text = value ?? ""
      downButton.isHidden = true // Bu adımda downButton kullanılmıyor
  }
     
     func configure(with title: String, expandedContent: [String]) {
         propertyLabel.text = title
         valueLabel.isHidden = true
         downButton.isHidden = false
         self.expandedContent = expandedContent
     }
 }


