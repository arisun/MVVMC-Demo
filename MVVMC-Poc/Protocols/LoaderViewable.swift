//
//  LoaderViewable.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 23/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import RxCocoa
import RxSwift


protocol LoaderViewable {
    
    func showActivityIndicator(in _containerView:UIView?) -> Void
    func hideActivityIndicator(from containerView:UIView?) -> Void
}
extension LoaderViewable where Self: UIViewController {
    
    func showActivityIndicator(in _containerView:UIView? = nil) -> Void {
        let containerView: UIWindow? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        hideActivityIndicator()
        let pct: CGFloat = 150
        let rect = containerView?.frame.inset(by: .init(top: pct, left: pct, bottom: pct, right: pct))
        
        let activityIndicatorView = NVActivityIndicatorView(frame: rect ?? CGRect.zero,
                                                            type: .circleStrokeSpin, color: .orange)
        activityIndicatorView.tag = 101
        containerView?.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator(from _containerView:UIView? = nil) -> Void {
        let containerView: UIWindow? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        for view in containerView?.subviews ?? [] {
            if view.tag == 101, view.isKind(of: NVActivityIndicatorView.self) {
                (view as! NVActivityIndicatorView).stopAnimating()
            }
        }
    }
}

