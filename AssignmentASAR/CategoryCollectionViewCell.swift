//
//  CategoryCollectionViewCell.swift
//  AssignmentASAR
//
//  Created by Sameer Jain on 23/08/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var ContentUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Make sure your cell's contentView is rounded
        ContentUIView.layer.cornerRadius = 5  // Adjust radius as needed
        ContentUIView.layer.masksToBounds = true
        
        // If you are using an image view
        categoryImageView.layer.cornerRadius = 5  // Ensure the image view also has rounded corners if needed
        categoryImageView.layer.masksToBounds = true
    }
}
