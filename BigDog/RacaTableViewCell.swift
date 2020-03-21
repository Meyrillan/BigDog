//
//  RacaTableViewCell.swift
//  BigDog
//
//  Created by Meyrillan Souza da Silva on 20/03/20.
//  Copyright © 2020 Meyrillan Souza da Silva. All rights reserved.
//

import Foundation
import UIKit

class RacaTableViewCell: UITableViewCell {
    
    @IBOutlet var racaLabel: UILabel!
    
    func configure(nome: String) {
        racaLabel.text = nome
    }
}


