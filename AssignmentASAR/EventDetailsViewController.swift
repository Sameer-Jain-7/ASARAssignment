//
//  EventDetailsViewController.swift
//  AssignmentASAR
//
//  Created by Sameer Jain on 25/08/24.
//

import Foundation
import UIKit
import Charts

class EventDetailsViewController: UIViewController {
    
    @IBOutlet weak var uiScrollView: UIScrollView!
    
    @IBOutlet weak var toggleGraphButton: UIButton!
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var informationLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var probabilityLabel: UILabel!
    
    @IBOutlet weak var informationStackView: UIStackView!
    @IBOutlet weak var outerGraphView: UIView!
    @IBOutlet weak var graphUiView: LineChartView!
    
    @IBOutlet weak var tradersLabel: UILabel!
    
    @IBOutlet weak var startedAtLabel: UILabel!
    
    @IBOutlet weak var volumeLabel: UILabel!
    
    @IBOutlet weak var endingAtLabel: UILabel!
    
    
    @IBOutlet weak var buttonView: UIView!
    
    
    
    
    
    var singleEvent: SingleEvent?// Add this property to receive the event data
    var showingYesGraph = true
    var event: Event?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = singleEvent?.question
        informationLabel.text = singleEvent?.information
        
        setUpGraph(showingYes: showingYesGraph)
        if let yesPercentage = singleEvent?.averageYesPercentage {
            let formattedText = "\(yesPercentage)% Probability of Yes"
            probabilityLabel.text = formattedText
            probabilityLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            toggleGraphButton.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
        
        outerGraphView.layer.cornerRadius = 10
        outerGraphView.layer.masksToBounds = true
        
        informationStackView.layer.cornerRadius = 5
        informationStackView.layer.masksToBounds = true
        
        toggleGraphButton.setTitle("Yes", for: .normal)
        
        if let numberOfTraders = singleEvent?.numberOfTraders {
            tradersLabel.text = "\(numberOfTraders)"
        } else {
            tradersLabel.text = "N/A" // Or any default value you prefer
        }
        
        startedAtLabel.text = singleEvent?.eventDetails.startDate
        endingAtLabel.text = singleEvent?.eventDetails.endDate
        volumeLabel.text = singleEvent?.eventDetails.volumeOfMoney
        
        
        buttonView.layer.shadowColor = UIColor.black.cgColor // Shadow color
        buttonView.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        buttonView.layer.shadowOpacity = 0.5 // Shadow opacity
        buttonView.layer.shadowRadius = 4 // Shadow blur radius
        
        // Optional: To improve performance, you can set masksToBounds to false
        buttonView.layer.masksToBounds = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Show the navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton) {
        presentPopup(for: event!, yesNo: true)
    }
    
    @IBAction func noButtonTapped(_ sender: UIButton) {
        presentPopup(for: event!, yesNo: false)
    }
    
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
    
    func setUpGraph(showingYes: Bool) {
        guard let probabilityHistory = singleEvent?.probabilityHistory else { return }
        
        var dataEntries: [ChartDataEntry] = []
        var xAxisLabels: [String] = []
        
        let dateFormatter = ISO8601DateFormatter()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        for entry in probabilityHistory {
            if let date = dateFormatter.date(from: entry.timestamp) {
                let timeString = timeFormatter.string(from: date)
                xAxisLabels.append(timeString)
                
                let percentage = showingYes ? entry.yesPercentage : entry.noPercentage
                let dataEntry = ChartDataEntry(x: Double(xAxisLabels.count - 1), y: percentage)
                dataEntries.append(dataEntry)
            }
        }
        
        let label = showingYes ? "Yes Probability" : "No Probability"
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: label)
        lineChartDataSet.colors = [NSUIColor.blue]
        lineChartDataSet.valueColors = [NSUIColor.black]
        
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.drawValuesEnabled = false
        
        lineChartDataSet.colors = showingYes ? [NSUIColor.blue] : [NSUIColor.red]
        lineChartDataSet.lineWidth = 3.0
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        // Reset zoom before updating data
        graphUiView.setVisibleXRange(minXRange: Double(dataEntries.count), maxXRange: Double(dataEntries.count))
        graphUiView.zoom(scaleX: 1.0, scaleY: 1.0, x: 0, y: 0)
        graphUiView.moveViewToX(0) // Move the view to the start of the x-axis
        
        graphUiView.data = lineChartData
        
        graphUiView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisLabels)
        graphUiView.xAxis.granularity = 1
        graphUiView.xAxis.labelPosition = .bottom
        graphUiView.rightAxis.enabled = false
        
        graphUiView.chartDescription.text = "Probability Over Time"
        
        // Optional: Add animation for smoother updates
        graphUiView.notifyDataSetChanged() // Refresh chart with animation
    }
    
    
    
    
    @IBAction func toggleGraphButtonTapped(_ sender: UIButton) {
        toggleGraphButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.toggleGraphButton.isEnabled = true
        }
        
        showingYesGraph.toggle()
        setUpGraph(showingYes: showingYesGraph)
        
        let newTitle = showingYesGraph ? "Yes" : "No"
        
        
        if showingYesGraph {
            if let yesPercentage = singleEvent?.averageYesPercentage {
                let formattedText = "\(yesPercentage)% Probability of Yes"
                probabilityLabel.text = formattedText
                probabilityLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
                toggleGraphButton.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            }
        } else {
            if let noPercentage = singleEvent?.averageNoPercentage {
                let formattedText = "\(noPercentage)% Probability of No"
                probabilityLabel.text = formattedText
                probabilityLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                toggleGraphButton.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            }
        }
        
        toggleGraphButton.setTitle(newTitle, for: .normal)
    }
    
    
    
}

