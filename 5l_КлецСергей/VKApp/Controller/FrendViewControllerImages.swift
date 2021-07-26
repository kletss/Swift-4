//
//  FrendViewControllerImages.swift
//  VKApp
//
//  Created by KKK on 26.04.2021.
//

import UIKit

class FrendViewControllerImages: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var frendImageOld: UIImageView!
    @IBOutlet weak var frendImage: UIImageView!
    @IBOutlet weak var frendImageLeft: UIImageView!
    
    @IBOutlet var someView: UIView!
   
    
    var indFrendCollectionImag: Int = 0
    var indImage: Int = 0
    
//    var vkPhotos = VKPhotos(count: 0, items: [])
    var vkPhotos = [RealmPhoto]()

//    lazy var indMax = frendCollectionImag[indFrendCollectionImag].images.count - 1
    lazy var indMax = vkPhotos.count - 1

    var originalX: CGFloat = 0.0

    private var propertyAnimator: UIViewPropertyAnimator?
    
    private func urlToImage(urlImage: String) -> UIImage {
        var image = UIImage(named: "noneImage")!
        guard let url = URL(string: urlImage),
              let data = try? Data(contentsOf: url),
              let imageD = UIImage(data: data)
        else {return image}
        image = imageD
        return image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.frendImageOld.image = nil
//        self.frendImage.image = frendCollectionImag[indFrendCollectionImag].images[indImage]
//        self.frendImageOld.image = frendCollectionImag[indFrendCollectionImag].images[indImage]
//        let cc = vkPhotos[indImage].sizes.count-1
        self.frendImageOld.image = urlToImage(urlImage: vkPhotos[indImage].sizes.last!.photoURL)
        originalX = self.frendImage.frame.origin.x
                
//        let leftSwipe = UISwipeGestureRecognizer(target:self, action: #selector(swipedLR(_:)))
//        let rightSwipe = UISwipeGestureRecognizer(target:self, action: #selector(swipedLR(_:)))

//        leftSwipe.direction = .left
//        rightSwipe.direction = .right

//        view.addGestureRecognizer(leftSwipe)
//        view.addGestureRecognizer(rightSwipe)

        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        panGR.maximumNumberOfTouches = 1
        view.addGestureRecognizer(panGR)

//        let pinchGR = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchPG(_:)))
//        view.addGestureRecognizer(pinchGR)
        
//        let handlePanGR = UIPanGestureRecognizer(target: self, action: #selector(handlePanGR(_:)))
//        view.addGestureRecognizer(handlePanGR)

        
    }
    
    

    @objc
    func handlePanGR(_ recognizer: UIPanGestureRecognizer) {

        switch recognizer.state {
        case .began:
            panGestureAnchorPoint = nil
            panGestureAnchorPoint = recognizer.location(in: view)
        case .changed:
            guard let panGestureAnchorPoint = panGestureAnchorPoint else { return }

            let gesturePoint = recognizer.location(in: view)

            frendImage.frame.origin.x += gesturePoint.x - panGestureAnchorPoint.x
            frendImage.frame.origin.y += gesturePoint.y - panGestureAnchorPoint.y
            self.panGestureAnchorPoint = gesturePoint
           
        case .cancelled, .ended:
            panGestureAnchorPoint = nil

        case .failed, .possible:
            panGestureAnchorPoint = nil
            break
        @unknown default:
            break
        }
    }
    
    
    @objc func handlePinchPG(_ recognizer: UIPinchGestureRecognizer) {

        switch recognizer.state {
//        case .began:

        case .changed:
            let gestureScale = recognizer.scale
            let transform = CGAffineTransform(scaleX: gestureScale, y: gestureScale)
            frendImageOld.transform = transform

        case .cancelled, .ended:
            self.frendImageOld.transform = CGAffineTransform.identity

        default:
           return
        }
    }
    
    var panGestureAnchorPoint: CGPoint?

    @objc
    private func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
 
            panGestureAnchorPoint = recognizer.location(in: view)
            originalX = self.frendImageOld.frame.origin.x

            
//            self.frendImageOld.transform = CGAffineTransform.identity
//            self.frendImageOld.image = frendCollectionImag[indFrendCollectionImag].images[indImage]

            
            var trX = self.someView.bounds.width


            if UIDevice.current.orientation.isLandscape {
                trX = self.frendImage.frame.width - (self.someView.bounds.width - self.frendImage.frame.width) / 2
            }
            var indImageT = indImage + 1
            if indImageT > indMax { indImageT = 0}
//            self.frendImage.image = frendCollectionImag[indFrendCollectionImag].images[indImageT]
//            var cc = vkPhotos[indImageT].sizes.count-1
            self.frendImage.image = urlToImage(urlImage: vkPhotos[indImageT].sizes.last!.photoURL)
            self.frendImage.transform = CGAffineTransform(translationX: trX, y: 0)
            self.frendImage.alpha = 0

            if UIDevice.current.orientation.isLandscape {
                trX = self.frendImageLeft.frame.width - (self.someView.bounds.width - self.frendImageLeft.frame.width) / 2
            }
            indImageT = indImage - 1
            if indImageT < 0  { indImageT = indMax}
//            self.frendImageLeft.image = frendCollectionImag[indFrendCollectionImag].images[indImageT]
//            cc = vkPhotos[indImageT].sizes.count-1
            self.frendImageLeft.image = urlToImage(urlImage: vkPhotos[indImageT].sizes.last!.photoURL)

            self.frendImageLeft.transform = CGAffineTransform(translationX: -trX, y: 0)
            self.frendImageLeft.alpha = 0

            
//            propertyAnimator = UIViewPropertyAnimator(
//                duration: 1,
//                curve: .easeInOut) {
//                self.frendImageOld.image?
//            }
//            propertyAnimator?.pauseAnimation()

            
        case .changed:
                
            guard let panGestureAnchorPoint = panGestureAnchorPoint else { return }

            let gesturePoint = recognizer.location(in: view)
            
            let gess = gesturePoint.x - panGestureAnchorPoint.x
            frendImageOld.frame.origin.x += gess
            frendImage.frame.origin.x += gess
            frendImageLeft.frame.origin.x += gess
            
            if frendImageOld.frame.origin.x < 0 {
                frendImageOld.alpha = (frendImageOld.frame.width + frendImageOld.frame.origin.x)/frendImageOld.frame.width
            } else {
                frendImageOld.alpha = (frendImageOld.frame.width - frendImageOld.frame.origin.x)/frendImageOld.frame.width
            }
            if frendImage.frame.origin.x < 0 {
                frendImage.alpha = (frendImage.frame.width + frendImage.frame.origin.x)/frendImage.frame.width
            } else {
                frendImage.alpha = (frendImage.frame.width - frendImage.frame.origin.x)/frendImage.frame.width
            }
            if frendImageLeft.frame.origin.x < 0 {
                frendImageLeft.alpha = (frendImageLeft.frame.width + frendImageLeft.frame.origin.x)/frendImageLeft.frame.width
            } else {
                frendImageLeft.alpha = (frendImageLeft.frame.width - frendImageLeft.frame.origin.x)/frendImageLeft.frame.width
            }
            
//            propertyAnimator?.startAnimation()

            self.panGestureAnchorPoint = gesturePoint

        case .ended:

            if frendImageOld.frame.origin.x < 0 {
                UIView.animate(withDuration: 0.5, delay: 0) {
                        self.frendImageOld.transform = CGAffineTransform(translationX: -self.someView.bounds.width, y: 0)
                            .concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
                        self.frendImageOld.alpha = 0
                        self.frendImage.frame.origin.x = CGFloat(self.originalX)
                        self.frendImage.alpha = 1
                } completion: { [self] _ in
                    indImage += 1
                    if indImage > indMax { indImage = 0}
//                    self.frendImageOld.image = frendCollectionImag[indFrendCollectionImag].images[indImage]
//                    let cc = vkPhotos[indImage].sizes.count-1
                    self.frendImageOld.image = urlToImage(urlImage: vkPhotos[indImage].sizes.last!.photoURL)

                    self.frendImageOld.transform = CGAffineTransform.identity
                    self.frendImageOld.alpha = 1
                    self.frendImage.alpha = 0
                }

            } else {
                UIView.animate(withDuration: 0.5, delay: 0) {
                        self.frendImageOld.transform = CGAffineTransform(translationX: self.someView.bounds.width, y: 0)
                            .concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
                        self.frendImageOld.alpha = 0
                        self.frendImageLeft.frame.origin.x = CGFloat(self.originalX)
                        self.frendImageLeft.alpha = 1
                } completion: { [self] _ in
                    indImage -= 1
                    if indImage < 0  { indImage = indMax}
//                    self.frendImageOld.image = frendCollectionImag[indFrendCollectionImag].images[indImage]
//                    let cc = vkPhotos[indImage].sizes.count-1
                    self.frendImageOld.image = urlToImage(urlImage: vkPhotos[indImage].sizes.last!.photoURL)

                    self.frendImageOld.transform = CGAffineTransform.identity
                    self.frendImageOld.alpha = 1
                    self.frendImageLeft.alpha = 0
                }
            }
            
//            propertyAnimator?.continueAnimation(
//                withTimingParameters: nil,
//                durationFactor: 0)
        default:
            return
        }
    }
    
    
    @objc
    private func swipedLR(_ recognizer: UIGestureRecognizer) {
//        switch recognizer.state {
//            case .ended:
                if let swipe = recognizer as? UISwipeGestureRecognizer {
                    frendImageOld.image = frendImage.image

                    switch swipe.direction {
                        case .right:
                            indImage = indImage - 1 //< 0 ? 0 : indImage - 1
                            if !(indImage < 0) {
//                                self.frendImage.image = frendCollectionImag[indFrendCollectionImag].images[indImage]
                                self.frendImage.image = urlToImage(urlImage: vkPhotos[indImage].sizes.last!.photoURL)

                                animationImageRight()
                            } else {
                                indImage = 0
                                animationImageRightEnd()
                            }
                        case .left:
//                            let indMax = frendCollectionImag[indFrendCollectionImag].images.count - 1
                            let indMax = vkPhotos.count - 1

                            indImage = indImage + 1 //> indMax ? indMax: indImage + 1
                            if !(indImage > indMax) {
//                                self.frendImage.image = frendCollectionImag[indFrendCollectionImag].images[indImage]
                                self.frendImage.image = urlToImage(urlImage: vkPhotos[indImage].sizes.last!.photoURL)

                                animationImageLeft()
                            } else {
                                indImage = indMax
                                animationImageLeftEnd()
                            }
                      default:
                            break
                    }
                }

    }
    


        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: Animate
    
    func animationImageRight() {
        self.frendImage.transform = CGAffineTransform(translationX: -self.someView.bounds.width, y: 0)
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: .calculationModeLinear) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.frendImage.transform = CGAffineTransform.identity
//                self.frendImageOld.transform = CGAffineTransform(translationX: self.someView.bounds.width, y: 0)
//                self.frendImageOld.frame = CGRect(x: self.someView.bounds.width, y: self.someView.bounds.midY, width: 90, height: 90)
                
                self.frendImageOld.transform = CGAffineTransform(translationX: self.someView.bounds.width, y: 0)
                    .concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                self.frendImageOld.alpha = 0
            }
        } completion: { _ in
            self.frendImageOld.alpha = 1
            self.frendImageOld.image = nil
            self.frendImageOld.transform = CGAffineTransform.identity
        }
    }
    
    
    func animationImageLeft() {
        self.frendImage.transform = CGAffineTransform(translationX: self.someView.bounds.width, y: 0)
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: .calculationModeLinear) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.frendImage.transform = CGAffineTransform.identity
//                self.frendImageOld.transform = CGAffineTransform(translationX: -self.someView.bounds.width, y: 0)
//                self.frendImageOld.frame = CGRect(x: -self.someView.bounds.width, y: self.someView.bounds.midY, width: 90, height: 90)
                self.frendImageOld.transform = CGAffineTransform(translationX: -self.someView.bounds.width, y: 0)
                    .concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                self.frendImageOld.alpha = 0
            }
        }completion: { _ in
            self.frendImageOld.alpha = 1
            self.frendImageOld.image = nil
            self.frendImageOld.transform = CGAffineTransform.identity
        }
    }
    
    func animationImageRightEnd() {
        self.frendImageOld.image = nil
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: .calculationModeLinear) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.frendImage.transform = CGAffineTransform(translationX: self.someView.bounds.width / 4, y: 0)
                    .concatenating(CGAffineTransform(scaleX: 0.9, y: 0.9))
                self.frendImage.alpha = 0.8
            }
        } completion: { _ in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: .calculationModeLinear) {
               UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.frendImage.transform = CGAffineTransform.identity
                self.frendImage.alpha = 1
               }
            }
        }
    }
    
    func animationImageLeftEnd() {
        self.frendImageOld.image = nil
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: .calculationModeLinear) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.frendImage.transform = CGAffineTransform(translationX: -self.someView.bounds.width / 4, y: 0)
                    .concatenating(CGAffineTransform(scaleX: 0.9, y: 0.9))
                self.frendImage.alpha = 0.8
            }
        } completion: { _ in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: .calculationModeLinear) {
               UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.frendImage.transform = CGAffineTransform.identity
                self.frendImage.alpha = 1
               }
            }
        }
    }

    
}
