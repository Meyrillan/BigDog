//
//  DogCollectionViewCell.swift
//  BigDog
//
//  Created by Meyrillan Souza da Silva on 12/03/20.
//  Copyright © 2020 Meyrillan Souza da Silva. All rights reserved.
//

import UIKit

class DogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var racaLabel: UILabel!
    @IBOutlet var racaImagem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(name: String, image: UIImage) {
        racaImagem.image = image
        racaLabel.text = name
    }

}
