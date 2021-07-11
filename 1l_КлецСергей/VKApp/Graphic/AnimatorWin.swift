//
//  AnimatorWin.swift
//  VKApp
//
//  Created by KKK on 28.04.2021.
//

import UIKit

class PushAnimation1: NSObject, UIViewControllerAnimatedTransitioning {
    private let animateTime = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
                    
        let translation = CATransform3DMakeTranslation(source.view.bounds.width, 0, 0)
        let rotation = CATransform3DMakeRotation(.pi/2, 0, 1,  0)
        let scale = CATransform3DScale(CATransform3DIdentity, 1.3, 1.3, 0)
        let transform1 = CATransform3DConcat(rotation, scale)
        let transform = CATransform3DConcat(transform1, translation)

//        destination.view.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        destination.view.transform = CATransform3DGetAffineTransform(transform)
     
        UIView.animate(withDuration: animateTime) {
            destination.view.transform = .identity
        } completion: { complete in
            transitionContext.completeTransition(complete)
        }
    }
    
}


class PopAnimation1: NSObject, UIViewControllerAnimatedTransitioning {
    private let animateTime = 1.2
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
//        transitionContext.containerView.insertSubview(destination.view, aboveSubview: source.view) // ‼️
          transitionContext.containerView.insertSubview(destination.view, belowSubview : source.view) // ‼️

        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame

        UIView.animate(withDuration: animateTime) {
//
//
//            source.view.transform = CGAffineTransform(translationX: source.view.bounds.width , y: 0)
//                .concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
//            source.view.alpha = 0.5

            let translation = CATransform3DMakeTranslation(-source.view.bounds.width, 0, 0)
            let rotation = CATransform3DMakeRotation(.pi, 0, 1,  0)
            let scale = CATransform3DScale(CATransform3DIdentity, 1.3, 1.3, 0)
            
            let transform1 = CATransform3DConcat( rotation , scale)
            let transform = CATransform3DConcat(translation, transform1)

            source.view.transform = CATransform3DGetAffineTransform(transform)
         
        } completion: { complete in

            source.removeFromParent()
            transitionContext.completeTransition(complete)
        }

    }
    
    
}

