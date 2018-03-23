//
//  landingViewController.swift
//  takeoutfood
//
//  Created by Fred Chen on 2018-01-10.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class landingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } 
}

@IBDesignable extension UIView {
  @IBInspectable var borderColor:UIColor? {
    set {
      layer.borderColor = newValue!.cgColor
    }
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor:color)
      }
      else {
        return nil
      }
    }
  }
  @IBInspectable var borderWidth:CGFloat {
    set {
      layer.borderWidth = newValue
    }
    get {
      return layer.borderWidth
    }
  }
  @IBInspectable var cornerRadius:CGFloat {
    set {
      layer.cornerRadius = newValue
      clipsToBounds = newValue > 0
    }
    get {
      return layer.cornerRadius
    }
  }
}

