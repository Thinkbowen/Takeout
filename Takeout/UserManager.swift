//
//  UserManager.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-10.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class UserManager: NSObject {
    static let sharedInstance = UserManager()
    var user = User()
    var selectedLocation = Location()
    var selectedType = String()
    
    func setUser(user:User) {
        self.user = user
        if(user.homeLocation != nil) {
            selectedLocation = user.homeLocation!
        }
        print(self.user)
    }
    
    func setLocation(location: Location) {
        self.selectedLocation = location
    }
    
    func selectHomeLocation() {
        guard user.homeLocation != nil else { return }
        self.selectedLocation = user.homeLocation!
    }
    
    
    func selectWorkLocation() {
        guard user.workLocation != nil else { return }
        self.selectedLocation = user.workLocation!
    }
}
