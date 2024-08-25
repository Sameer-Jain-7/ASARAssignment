//
//  ViewController.swift
//  AssignmentASAR
//
//  Created by Sameer Jain on 23/08/24.
//

import UIKit

class ViewController: UIViewController, CategoriesTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = ["Cricket", "Crypto", "Football", "Show More", "Basketball", "News", "Stocks", "Economy", "Youtube"]
    var isExpanded = false
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let categoriesNib = UINib(nibName: "CategoriesTableViewCell", bundle: nil)
        tableView.register(categoriesNib, forCellReuseIdentifier: "CategoriesTableViewCell")
        
        let adNib = UINib(nibName: "AdTableViewCell", bundle: nil)
        tableView.register(adNib, forCellReuseIdentifier: "AdTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        let eventNib = UINib(nibName: "EventTableViewCell", bundle: nil)
        tableView.register(eventNib, forCellReuseIdentifier: "EventTableViewCell")
        
        
        let dataLoader = DataLoader()
        events = dataLoader.loadEvents()
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        footerView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        tableView.tableFooterView = footerView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // Delegate method to handle expansion state
    func didTapShowMore(in cell: CategoriesTableViewCell) {
        isExpanded.toggle()
        updateItemsForExpansion()
        if let indexPath = tableView.indexPath(for: cell) {
            UIView.animate(withDuration: 0.2, animations: {
                self.tableView.beginUpdates()
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
            })
        }
    }
    
    
    func updateItemsForExpansion() {
        if isExpanded {
            items[3] = "Show Less"
        } else {
            items[3] = "Show More"
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
            cell.configure(with: items, isExpanded: isExpanded)
            cell.delegate = self  // Set the delegate
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
            cell.configure(with: ["Ad1", "Ad2", "Ad3"])
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
            let event = events[indexPath.row-2]
            cell.configure(with: event)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            let numberOfRows = isExpanded ? ceil(Double(items.count) / 4.0) : 1
            let rowHeight = tableView.frame.width / 4
            return CGFloat(numberOfRows) * rowHeight + 6
        } else if indexPath.row == 1 {
            guard let firstImage = UIImage(named: "Ad1" ?? "") else {
                return UITableView.automaticDimension
            }
            let aspectRatio = firstImage.size.width / firstImage.size.height
            let collectionViewWidth = tableView.frame.width * 0.9
            let itemHeight = collectionViewWidth / aspectRatio
            return itemHeight + 20 // 20 is for padding
        } else {
            return 180
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = events[indexPath.row-2].question
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let eventDetailsVC = storyboard.instantiateViewController(withIdentifier: "EventDetailsViewController") as? EventDetailsViewController else {
            print("Error: EventDetailsViewController could not be instantiated")
            return
        }
        
        let eventLoader = EventLoader()
        let singleEvent = eventLoader.decodeEventFromFile()
        eventDetailsVC.singleEvent = singleEvent
        eventDetailsVC.event = events[indexPath.row-2]
        self.navigationController?.pushViewController(eventDetailsVC, animated: true)
    }
    
}

extension ViewController: EventTableViewCellDelegate {
    
    
    func presentPopup(for event: Event, yesNo: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let popupVC = storyboard.instantiateViewController(withIdentifier: "PopupViewController") as? PopupViewController else {
            print("Error: PopupViewController could not be instantiated")
            return
        }
        
        popupVC.event = event
        popupVC.yesNo = yesNo
        
        popupVC.modalPresentationStyle = .custom
        popupVC.transitioningDelegate = self
        self.present(popupVC, animated: true, completion: nil)
    }
    
}

extension UIViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

