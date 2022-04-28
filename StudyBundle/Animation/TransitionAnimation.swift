//
//  TransitionAnimation.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/28.
//

import UIKit

class TransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       if let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
          let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) {
        let fromVCRect = transitionContext.initialFrame(for: fromVC)
        let toVCRect = CGRect(x: 0, y: fromVCRect.size.height * 2, width: fromVCRect.width, height: fromVCRect.height)
           let fromView = fromVC.view!
           let toView = toVC.view!
           fromView.frame = fromVCRect
           toView.frame = toVCRect
           transitionContext.containerView.addSubview(fromView)
           transitionContext.containerView.addSubview(toView)
           
           UIView.animate(withDuration: 2) {
               toView.frame = fromVCRect
               toView.alpha = 1
           } completion: { _ in
               transitionContext.completeTransition(true)
           }

       }
    }
    

    
}
