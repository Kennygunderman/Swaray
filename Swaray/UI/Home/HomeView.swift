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

class HomeView: BaseControllerView {
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
    
    override func addSubViews() {
        addSubview(homeBg)
        addSubview(triangle)
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
    }
}
