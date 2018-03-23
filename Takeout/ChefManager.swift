
import UIKit

class ChefManager: NSObject {
  static let sharedInstance = ChefManager()
  var chef = Chef()
  
  func setChef(chef:Chef) {
    self.chef = chef
    print(self.chef)
  }
}

