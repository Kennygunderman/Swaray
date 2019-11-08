//
//  HomeView.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/16/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HomeView: BaseControllerView<HomeViewModel> {
    lazy var homeBg: UIView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let view = UIView(frame: frame)
        view.backgroundColor = .appPrimary
        return view
    }()
    
    // This is the magic view that creates the diagonal in the layout
    let triangle: TriangleView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let color = UIColor.white.cgColor
        let triangle = TriangleView(color: color, frame: frame)
        triangle.backgroundColor = .appPrimary
        return triangle
    }()
    
    let actionLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.hostingOrJoiningLabel
        label.font = FontUtil.loadFont(font: .light, size: DimenConsts.headerFontSize)
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let hostingBtn: SwarayButton = {
        let button = SwarayButton()
        button.setTitle(title: StringConsts.hostingLabel)
        button.backgroundColor = .appPrimary
        return button
    }()

    //default button width
    private let buttonWidth = UIScreen.main.bounds.width - (64 * 2)
    
    override func addSubViews() {
        addSubview(homeBg)
        addSubview(triangle)
        addSubview(actionLabel)
        addSubview(hostingBtn)
    }
    
    override func setupConstraints() {
        homeBg.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(0)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            
            //set the height to 50% of the screen height
            make.height.equalTo(
                (UIScreen.main.bounds.height * 0.5)
            )
        }
        
        triangle.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.bottom.equalTo(self.homeBg.snp.bottom).offset(0)
            make.height.equalTo(DimenConsts.triangleCutHeight)
        }
        
        actionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.homeBg.snp.top).offset(-DimenConsts.triangleCutHeight)
            make.bottom.equalTo(self.homeBg.snp.bottom)
            make.left.equalTo(self.homeBg.snp.left)
            make.right.equalTo(self.homeBg.snp.right)
        }
        
        hostingBtn.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(buttonWidth)
            make.top.equalTo(self.triangle.snp.bottom).offset(64)
        }
    }
    
    override func transitionInViews() -> [UIView] {
        return [actionLabel, hostingBtn]
    }
}

extension HomeView {
    
    func handleExitAnimation(animationFinished: @escaping () -> Void) {
        triangle.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0)
        }
        
        homeBg.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(
                (UIScreen.main.bounds.height * 0.6)
            )
        }
        
        setNeedsUpdateConstraints()
        startAnimation(duration: 0.5, anim: {
            self.hostingBtn.alpha = 0
            self.actionLabel.alpha = 0
            self.layoutIfNeeded()
        }, finished: {
            self.handleExitAnimShrink(animationFinished: animationFinished)
        })
    }
    
    private func handleExitAnimShrink(animationFinished: @escaping () -> Void) {
        triangle.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(DimenConsts.triangleCutHeight)
        }
        
        homeBg.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(0)
        }
        
        setNeedsUpdateConstraints()
        startAnimation(duration: 0.25, anim: {
            self.layoutIfNeeded()
        }, finished: {
            animationFinished()
        })
    }
}
