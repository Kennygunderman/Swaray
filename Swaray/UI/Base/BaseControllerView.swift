//
//  BaseView.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/13/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

// Base Controller View is responsible for adding all views to a controller,
// and handling the setup of databinding from view -> viewModel.
class BaseControllerView<T_VIEWMODEL>: UIView {
    
    var viewModel: T_VIEWMODEL? = nil
    
    required init(frame: CGRect, viewModel: T_VIEWMODEL?) {
        super.init(frame: frame)
        backgroundColor = .white
        self.viewModel = viewModel
        addSubViews()
        setupConstraints()
    }
    
    // This method should be used for adding sub views
    // when BaseControllerView is implemented. Hence the name
    // `addSubViews` :D
    func addSubViews() {
        
    }
    
    // Called once the sub views have been added.
    // This method should be used for setting up constraints
    // of said sub views.
    func setupConstraints() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Animation to fade in views provided from `transitionInViews`
    // when controller is first loaded.
    func handleEnterTransition() {
        for v in transitionInViews() {
            v.alpha = 0
        }
        
        startAnimation(duration: 0.25, anim: {
            for v in self.transitionInViews() {
                v.alpha = 1
            }
        })
    }
    
    // Provides views to animate when the corresponding
    // ViewController is first loaded (on Enter).
    func transitionInViews() -> [UIView] {
        return []
    }
    
    //Base Animation logic
    func startAnimation(duration: Double, anim: @escaping () -> Void, finished: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration,
                       delay: 0.1,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
                        anim()
        }, completion: { _ in
            if let f = finished {
                f()
            }
        })
    }
}

