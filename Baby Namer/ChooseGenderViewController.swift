//
//  ChooseGenderViewController.swift
//  Baby Namer
//
//  Created by Daniel Fairbanks on 2/16/15.
//  Copyright (c) 2015 Fairbanksdan. All rights reserved.
//

import UIKit

class ChooseGenderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
    func viewDidAppear() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let pickNameViewController = segue.destinationViewController as ViewController
        
        if segue.identifier == "Boys" {
            pickNameViewController.isBoys = true
        } else {
            pickNameViewController.isBoys = false
        }
    }
    

}
