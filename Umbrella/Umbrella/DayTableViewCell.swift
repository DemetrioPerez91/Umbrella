//
//  DayTableViewCell.swift
//  Umbrella
//
//  Created by User on 9/17/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet weak var DayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
}
