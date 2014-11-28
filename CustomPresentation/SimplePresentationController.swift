//
//  SimplePresentationController.swift
//  CustomPresentation
//
//  Created by RoBeRt on 14/11/25.
//  Copyright (c) 2014年 Fresh App Factory. All rights reserved.
//

import UIKit

class SimplePresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate {
  var dimmingView: UIView = UIView()
  
  override init(presentedViewController: UIViewController!, presentingViewController: UIViewController!) {
    super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
    dimmingView.alpha = 0.0
  }
  
  override func presentationTransitionWillBegin() {
    dimmingView.frame = self.containerView.bounds
    dimmingView.alpha = 0.0
    containerView.insertSubview(dimmingView, atIndex: 0)
    
    let coordinator = presentedViewController.transitionCoordinator()
    if (coordinator != nil) {
      coordinator!.animateAlongsideTransition({
        (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
          self.dimmingView.alpha = 1.0
      }, completion: nil)
    } else {
      dimmingView.alpha = 1.0
    }
  }
  
  override func dismissalTransitionDidEnd(completed: Bool) {
    let coordinator = presentedViewController.transitionCoordinator()
    if (coordinator != nil) {
      coordinator!.animateAlongsideTransition({
        (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
        self.dimmingView.alpha = 0.0
      }, completion: nil)
    } else {
      dimmingView.alpha = 0.0
    }
  }
  
  override func containerViewWillLayoutSubviews() {
    dimmingView.frame = containerView.bounds
    presentedView().frame = containerView.bounds
  }
  
  override func shouldPresentInFullscreen() -> Bool {
    return true
  }
  
  func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
    return UIModalPresentationStyle.OverFullScreen
  }
}
