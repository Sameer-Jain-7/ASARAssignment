//
//  CategoriesTableViewCell.swift
//  AssignmentASAR
//
//  Created by Sameer Jain on 23/08/24.
//


import UIKit

protocol CategoriesTableViewCellDelegate: AnyObject {
    func didTapShowMore(in cell: CategoriesTableViewCell)
}

class CategoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [String] = []
    var isExpanded = false {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: CategoriesTableViewCellDelegate?  // Add the delegate property
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Register the UICollectionViewCell
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "TabCell")
        
        // Set up the layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5  // Space between cells horizontally
        layout.minimumLineSpacing = 5  // Space between cells vertically
        collectionView.collectionViewLayout = layout
    }
    
    func configure(with items: [String], isExpanded: Bool) {
        self.items = items
        self.isExpanded = isExpanded
        collectionView.reloadData()
    }
}

extension CategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isExpanded ? items.count : min(items.count, 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as! CategoryCollectionViewCell
        let categoryName = items[indexPath.row]
        cell.categoryLabel.text = categoryName
        cell.categoryImageView.image = UIImage(named: categoryName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 15) / 4  // Adjust width for padding (30 = 10 padding on each side + 10 spacing between cells)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if items[indexPath.row] == "Show More" || items[indexPath.row] == "Show Less" {
            delegate?.didTapShowMore(in: self)
        }
    }
}

