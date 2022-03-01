//
//  UINavigationController+.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import SwiftUI

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
  override open func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.isHidden = true
    interactivePopGestureRecognizer?.delegate = self
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
