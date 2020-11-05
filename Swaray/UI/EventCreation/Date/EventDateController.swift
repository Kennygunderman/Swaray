//
//  EventDateController.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/10/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

import FirebaseFirestore

class EventDateController: BaseController<EventDateView, EventDateViewModel> {
    var eventName: String = ""
    private let viewModel = EventDateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        viewModel.eventName = eventName
        subscribeUi()
    }
    
    private func subscribeUi() {
        _ = viewModel.alert.observeNext { alertDialog in
            if let alert = alertDialog {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func getViewModel() -> EventDateViewModel? {
        return viewModel
    }
    
    // Override but doesn't call super to
    // enable back navigation.
    override func disableBackNavigation() {
    }
    
    fileprivate func setupToolbar() {
        // Setup Back button
        let navbar = navigationController?.navigationBar
        let backBtn = UIImage(named: "back-button")?.withRenderingMode(.alwaysOriginal)
        navbar?.topItem?.title = ""
        navbar?.backIndicatorImage = backBtn
        navbar?.backIndicatorTransitionMaskImage = backBtn
        
        // Setup Done button
        let item = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleNext))
        item.tintColor = .white
        navigationItem.setRightBarButtonItems([item], animated: true)
    }
    
    @objc func handleNext() {
        baseView.eventDateTextField.resignFirstResponder()
        viewModel.saveEvent()
    }
}
