//
//  CustomTransition.swift
//  VKApp
//
//  Created by KKK on 27.04.2021.
//

import UIKit

class PushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let animateTime: TimeInterval = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.frame = transitionContext.containerView.frame
        
        destination.view.transform = CGAffineTransform(translationX: source.view.bounds.width,
                                                       y: 0)
        
        UIView.animateKeyframes(withDuration: animateTime, delay: 0, options: .calculationModePaced) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
                let translation = CGAffineTransform(translationX: -200, y: 0)
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                source.view.transform = translation.concatenating(scale)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4) {
                let translation = CGAffineTransform(translationX: source.view.bounds.width / 2,
                                                    y: 0)
                let scale = CGAffineTransform(scaleX: 1.2,
                                              y: 1.2)
                destination.view.transform = translation.concatenating(scale)
                
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                destination.view.transform = .identity
            }
        } completion: { complete in
            transitionContext.completeTransition(complete)
        }
    }
}


class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let animateTime: TimeInterval = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.insertSubview(destination.view, belowSubview: source.view) // ‼️
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        destination.view.transform = CGAffineTransform(translationX: -200, y: 0)
            .concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
        
        UIView.animateKeyframes(withDuration: animateTime,
                                delay: 0,
                                options: .calculationModePaced) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                let translation = CGAffineTransform(translationX: source.view.bounds.width / 2,
                                                    y: 0)
                let scale = CGAffineTransform(scaleX: 1.2,
                                              y: 1.2)
                source.view.transform = translation.concatenating(scale)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4) {
                source.view.transform = CGAffineTransform(translationX: source.view.bounds.width,
                                                          y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75) {
                destination.view.transform = .identity
            }
        } completion: { complete in
            if complete && !transitionContext.transitionWasCancelled {
                source.removeFromParent()
                transitionContext.completeTransition(complete)
            }
            
            transitionContext.completeTransition(complete)
        }
    }
}
