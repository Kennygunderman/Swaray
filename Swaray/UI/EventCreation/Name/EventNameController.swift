//
//  EventNameController.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/8/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

class EventNameController: BaseController<EventNameView, EventNameViewModel> {
    private let viewModel = EventNameViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        subscribeUi()
    }
    
    override func getViewModel() -> EventNameViewModel? {
        return viewModel
    }
    
    private func subscribeUi() {
        _ = viewModel.navigateTrigger.observeNext { doNavigate in
            if doNavigate {
                self.baseView.eventNameTextField.resignFirstResponder()
                self.navigationController?.pushViewController(EventDateController(), animated: true)
            }
        }
    }
    
    fileprivate func setupToolbar() {
        let item = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleNext))
        item.tintColor = .white
        navigationItem.setRightBarButtonItems([item], animated: true)
    }
    
    @objc func handleNext() {
        _ = viewModel.handleNext()
    }
}
