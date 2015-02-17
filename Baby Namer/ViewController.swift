//
//  ViewController.swift
//  Baby Namer
//
//  Created by Daniel Fairbanks on 1/31/15.
//  Copyright (c) 2015 Fairbanksdan. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var nameCard: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var isBoys = Bool()

    let yesLabel = UILabel()
    let noLabel = UILabel()
    
    var rootViewWidth : CGFloat!
    
    var nameArray = [String]()
    
    var snapshotX : CGFloat = 0.0
    var snapshotY : CGFloat = 0.0
    
    var incrementNextName = 0
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isBoys {
            nameArray.append("Jackson")
            nameArray.append("Aiden")
            nameArray.append("Liam")
            nameArray.append("Lucas")
            nameArray.append("Noah")
            nameArray.append("Mason")
            nameArray.append("Ethan")
            nameArray.append("Caden")
            nameArray.append("Jacob")
            nameArray.append("Logan")
            nameArray.append("Jayden")
            nameArray.append("Jack")
            nameArray.append("Luke")
            nameArray.append("Michael")
            nameArray.append("Benjamin")
            nameArray.append("Alexander")
            nameArray.append("James")
            nameArray.append("Jayce")
        } else {
            nameArray.append("Sophia")
            nameArray.append("Emma")
            nameArray.append("Olivia")
            nameArray.append("Ava")
            nameArray.append("Isabella")
            nameArray.append("Mia")
            nameArray.append("Zoe")
            nameArray.append("Lily")
            nameArray.append("Emily")
            nameArray.append("Madelyn")
            nameArray.append("Madison")
            nameArray.append("Chloe")
            nameArray.append("Charlotte")
            nameArray.append("Aubrey")
            nameArray.append("Avery")
            nameArray.append("Abigail")
            nameArray.append("Kaylee")
            nameArray.append("Layla")
        }
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if isBoys == false {
            mainView.backgroundColor = UIColor(red: 244/255, green: 96/255, blue: 156/255, alpha: 1.0)
        } else {
            mainView.backgroundColor = UIColor(red: 147/255, green: 210/255, blue: 244/255, alpha: 1.0)
        }
        
        let rootViewBounds = view.bounds
        rootViewWidth = CGRectGetWidth(rootViewBounds)
        
        let longpress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        longpress.minimumPressDuration = 0.0
        view.addGestureRecognizer(longpress)
        
        nameCard.layer.cornerRadius = 5
        
        incrementNextName = 1
        
        nameLabel.text = nameArray[0]
        
        println("nameCard width = \(mainView.frame.size.width)")
        
        yesLabel.frame = CGRectMake(15, 15, 80, 40)
        noLabel.frame = CGRectMake((mainView.frame.size.width - 145), 15, 70, 40)
        
        println("nameArray.count is \(nameArray.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // Returns a customized snapshot of a given view
    func customSnapshopFromView(inputView: UIView) -> UIView {
        
        // Make an image from the input view.
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        yesLabel.text = "YES"
        yesLabel.font = UIFont(name: "HelveticaNeue", size: 40)
        yesLabel.alpha = 0.0
        yesLabel.textColor = UIColor.greenColor()
        
        
        noLabel.text = "NO"
        noLabel.font = UIFont(name: "HelveticaNeue", size: 40)
        noLabel.alpha = 0.0
        noLabel.textColor = UIColor.redColor()
        
        // Create an image view.
        let snapshot : UIView = UIImageView(image: image)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0.0
        snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        snapshot.layer.shadowRadius = 5.0
        snapshot.layer.shadowOpacity = 0.4
        snapshot.addSubview(yesLabel)
        snapshot.addSubview(noLabel)

        return snapshot
    }
    
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        
        let longPress = gestureRecognizer as UILongPressGestureRecognizer
        let state = longPress.state
        var location = longPress.locationInView(view)
        
        struct My {
            static var snapshot : UIView? = nil ///< A snapshot of the row user is moving.
        }
        
        struct Path {
            static var sourceIndexPath : NSIndexPath? = nil ///< Initial index path, where gesture begins.
        }
        
        switch state {
        case UIGestureRecognizerState.Began:
                
                // Take a snapshot of the selected row using helper method.
                My.snapshot = customSnapshopFromView(nameCard)
                
                
                
                // Add the snapshot as subview, centered at cell's center...
                var center = nameCard.center
                My.snapshot!.center = center
//                My.snapshot!.alpha = 0.0
                view.addSubview(My.snapshot!)
            
                snapshotY = location.y - nameCard.frame.origin.y
                snapshotX = location.x - nameCard.frame.origin.x
                
//                UIView.animateWithDuration(0.25, animations: { () -> Void in
//                    
//                    // Offset for gesture location.
//                    center.y = location.y
//                    My.snapshot!.center = center
//                    My.snapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
//                    My.snapshot!.alpha = 1.0
////                    self.nameCard.alpha = 0.0
//                    
//                    }, completion: { (finished) -> Void in
//                        if finished {
////                            self.nameCard.hidden = true
//                        }
//                })
            
        case UIGestureRecognizerState.Changed:
            
            nameLabel.text = nameArray[incrementNextName]
            
            var origin = My.snapshot!.frame.origin
            origin.y = location.y - snapshotY
            origin.x = location.x - snapshotX
            
            My.snapshot!.frame.origin = origin
            
            if My.snapshot!.center.x > (rootViewWidth/2 + 20) {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.yesLabel.alpha = 1.0
                    self.noLabel.alpha = 0.0
                })
                
            } else if My.snapshot!.center.x < (rootViewWidth/2 - 20) {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.yesLabel.alpha = 0.0
                    self.noLabel.alpha = 1.0
                })
                
            } else {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.yesLabel.alpha = 0.0
                    self.noLabel.alpha = 0.0
                })
            }
            
        case UIGestureRecognizerState.Ended:
            
            if nameArray.count > incrementNextName + 1 {
                incrementNextName = incrementNextName + 1
            } else {
                incrementNextName = 0
            }

            if location.x > (rootViewWidth/2) {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    println("done")
                    My.snapshot?.center.x = self.rootViewWidth*2
                }, completion: { (finished) -> Void in
                    if finished {
                        My.snapshot!.removeFromSuperview()
                        My.snapshot = nil
                    }
                })
            } else {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    println("done")
                    My.snapshot?.center.x = -self.rootViewWidth*2
                    }, completion: { (finished) -> Void in
                        if finished {
                            My.snapshot!.removeFromSuperview()
                            My.snapshot = nil
                        }
                })
            }
            
        default:
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    My.snapshot!.center = self.nameCard.center
                    My.snapshot!.transform = CGAffineTransformIdentity
                    My.snapshot!.alpha = 0.0
                    self.nameCard.alpha = 1.0
                    }, completion: { (finished) -> Void in
                        if finished {
                            Path.sourceIndexPath = nil
                            
                        }
                })

        }
    }
    
    



}
