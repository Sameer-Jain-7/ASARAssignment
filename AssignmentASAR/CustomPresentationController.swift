//
//  CustomPresentationController.swift
//  AssignmentASAR
//
//  Created by Sameer Jain on 24/08/24.
//

import Foundation
import UIKit

class CustomPresentationController: UIPresentationController {
    
    private let dimmingView = UIView()
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        // Setup and add dimming view
        dimmingView.frame = containerView!.bounds
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView?.addSubview(dimmingView)
        
        // Add tap gesture recognizer to dimming view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDimmingViewTap))
        dimmingView.addGestureRecognizer(tapGestureRecognizer)
        
        // Animate dimming view appearance
        dimmingView.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.dimmingView.alpha = 1
        }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        // Animate dimming view disappearance
        UIView.animate(withDuration: 0.25, animations: {
            self.dimmingView.alpha = 0
        }) { _ in
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let containerBounds = containerView!.bounds
        let height = containerBounds.height * 0.4
        return CGRect(x: 0, y: containerBounds.height - height, width: containerBounds.width, height: height)
    }
    
    @objc private func handleDimmingViewTap() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
