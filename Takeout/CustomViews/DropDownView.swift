//
//  DropDownView.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-13.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class DropDownView: UIView {
    @IBOutlet var contentView: UIView!
    //@IBOutlet var locationSelection: [UIButton]!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "DropDownView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
    }
}
