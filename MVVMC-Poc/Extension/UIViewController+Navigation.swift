//
//  UIVieController + navigation.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 15/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import Foundation
import UIKit

private var actionKeyForLeftButton: Void?
private var actionKeyForRightButton: Void?

extension UIViewController{
    
    private var _actionLeft: (() -> ())? {
        get {
            return objc_getAssociatedObject(self, &actionKeyForLeftButton) as? () -> ()
        }
        set {
            objc_setAssociatedObject(self, &actionKeyForLeftButton, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var _actionRight: (() -> ())? {
        get {
            return objc_getAssociatedObject(self, &actionKeyForRightButton) as? () -> ()
        }
        set {
            objc_setAssociatedObject(self, &actionKeyForRightButton, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func configureNavigationWithAction(_ title:String? ,leftImage: UIImage?, leftTitle: String?, _ willHideBackButton: Bool = true, actionForLeft: (() -> ())?,rightImage: UIImage?, rightTitle: String? ,actionForRight: (() -> ())?){
        self._actionLeft = actionForLeft
        self._actionRight = actionForRight
        self.navigationItem.hidesBackButton = willHideBackButton
        if title != nil{
            self.title = title!
        }
        if leftImage != nil{
            let leftButton = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(leftButtonTappedwithDemo))
            self.navigationItem.leftBarButtonItem = leftButton
        } else if leftTitle != nil {
            let leftButton = UIBarButtonItem(title: leftTitle, style: .plain, target: self, action: #selector(leftButtonTappedwithDemo))
            leftButton.tintColor = .blue
            self.navigationItem.leftBarButtonItem = leftButton
        }
        if rightImage != nil{
            let rightButton = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(rightButtonTappedwithDemo))
            self.navigationItem.rightBarButtonItem = rightButton
        } else if rightTitle != nil {
            let rightButton = UIBarButtonItem(title: rightTitle, style: .plain, target: self, action: #selector(rightButtonTappedwithDemo))
            rightButton.tintColor = .blue
            self.navigationItem.rightBarButtonItem = rightButton
        }
    }
    @objc private func leftButtonTappedwithDemo(){
        if self._actionLeft != nil{
            self._actionLeft!()
        }
    }
    @objc private func rightButtonTappedwithDemo(){
        if self._actionRight != nil{
            self._actionRight!()
        }
    }
}
