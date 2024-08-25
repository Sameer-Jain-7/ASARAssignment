//
//  AdCollectionViewCell.swift
//  AssignmentASAR
//
//  Created by Sameer Jain on 24/08/24.
//

import UIKit

class AdCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var AdImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
        
        self.innerView.layer.cornerRadius = 10
        self.innerView.layer.masksToBounds = true
    }
}
