//
//  AdTableViewCell.swift
//  AssignmentASAR
//
//  Created by Sameer Jain on 24/08/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    
    @IBOutlet weak var adCollectionView: UICollectionView!
    
    var imageNames = ["Ad1", "Ad2", "Ad3"]
    var imageAspectRatios: [String: CGFloat] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: "AdCollectionViewCell", bundle: nil)
        adCollectionView.register(nib, forCellWithReuseIdentifier: "AdCollectionViewCell")
        
        adCollectionView.dataSource = self
        adCollectionView.delegate = self
        adCollectionView.showsHorizontalScrollIndicator = false
        
        if let layout = adCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    func configure(with imageNames: [String]) {
        self.imageNames = imageNames
        calculateAspectRatios()
        adCollectionView.reloadData()
    }
    
    private func calculateAspectRatios() {
        for imageName in imageNames {
            if let image = UIImage(named: imageName) {
                let aspectRatio = image.size.width / image.size.height
                imageAspectRatios[imageName] = aspectRatio
            }
        }
    }
}

extension AdTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCollectionViewCell", for: indexPath) as! AdCollectionViewCell
        let imageName = imageNames[indexPath.row]
        cell.AdImageView.image = UIImage(named: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.9
        let imageName = imageNames[indexPath.row]
        let aspectRatio = imageAspectRatios[imageName] ?? 1
        let height = width / aspectRatio
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10  // Spacing between the cells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 15)
    }
    
}
