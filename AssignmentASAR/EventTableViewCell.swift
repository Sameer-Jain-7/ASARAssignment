//
//  EventTableViewCell.swift
//  AssignmentASAR
//
//  Created by Sameer Jain on 24/08/24.
//

import UIKit

protocol EventTableViewCellDelegate: AnyObject {
    func presentPopup(for event: Event, yesNo: Bool)
}



class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tradersLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var innerView: UIView!
    
    weak var delegate: EventTableViewCellDelegate?
    
    var yesButtonTapped: (() -> Void)?
    var noButtonTapped: (() -> Void)?
    
    @IBAction func yesButtonAction(_ sender: UIButton) {
        yesButtonTapped?()
    }
    
    @IBAction func noButtonAction(_ sender: UIButton) {
        noButtonTapped?()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButtons()
    }
    
    private func setupButtons() {
        yesButton.setTitle("Yes", for: .normal)
        yesButton.layer.cornerRadius = 5
        
        noButton.setTitle("No", for: .normal)
        noButton.layer.cornerRadius = 5
    }
    
    func configure(with event: Event) {
        tradersLabel.text = "\(event.number_of_traders) traders"
        questionLabel.text = event.question
        informationLabel.text = event.information
        
        innerView.layer.cornerRadius = 10
        innerView.layer.masksToBounds = true
        
        eventImageView.image = UIImage(named: "Event")
        
        yesButtonTapped = {
            self.delegate?.presentPopup(for: event, yesNo: true)
        }
        
        noButtonTapped = {
            self.delegate?.presentPopup(for: event, yesNo: false)
        }
    }
    
    
    
}
