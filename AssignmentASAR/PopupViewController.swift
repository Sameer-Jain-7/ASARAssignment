//
//  PopupViewController.swift
//  AssignmentASAR
//
//  Created by Sameer Jain on 24/08/24.
//

import UIKit

class PopupViewController: UIViewController {
    
    
    var event: Event?
    var yesNo: Bool?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var YesNoSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var youPutLabel: UILabel!
    
    @IBOutlet weak var youGetLabel: UILabel!
    
    
    @IBOutlet weak var swipeButton: SwipeButtonView!
    
    @IBOutlet weak var innerView3: UIView!
    
    
    
    @IBAction func swipeButtonAction(_ sender: SwipeButtonView) {
        swipeButton.backgroundColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
        swipeButton.setTitle("Success", for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    var onYesTapped: (() -> Void)?
    var onNoTapped: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cornerRadius: CGFloat = 20.0
        self.view.layer.cornerRadius = cornerRadius
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.view.layer.masksToBounds = true
        
        setupUI()
        
        
    }
    
    private func setupUI() {
        
        if yesNo == true {
            handleYesAction()
        } else {
            handleNoAction()
        }
        
        
        self.innerView3.layer.cornerRadius = 10
        self.innerView3.layer.masksToBounds = true
        
        questionLabel.text = event?.question
        YesNoSegmentControl.addTarget(self, action: #selector(segmentControlChanged(_:)), for: .valueChanged)
        
    }
    
    @objc func segmentControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: // "Yes" selected
            handleYesAction() // Call the function for the "Yes" action
        case 1: // "No" selected
            handleNoAction() // Call the function for the "No" action
        default:
            break
        }
    }
    
    
    func handleYesAction() {
        // Dismiss the popup or perform other actions as needed
        swipeButton.backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        YesNoSegmentControl.selectedSegmentIndex = 0
        YesNoSegmentControl.selectedSegmentTintColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        youPutLabel.text = "Rs 6.5"
        youGetLabel.text = "Rs 10.0"
        swipeButton.setTitle("Swipe for Yes", for: .normal)
    }
    
    func handleNoAction() {
        // Dismiss the popup or perform other actions as needed
        swipeButton.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        YesNoSegmentControl.selectedSegmentIndex = 1
        YesNoSegmentControl.selectedSegmentTintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        youPutLabel.text = "Rs 3.5"
        youGetLabel.text = "Rs 10.0"
        swipeButton.setTitle("Swipe for No", for: .normal)
    }
}
