//
//  chefSellViewController.swift
//  takeoutfood
//
//  Created by Fred Chen on 2018-01-18.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit
import Cloudinary

class chefSellViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  //MARK: Properties
    
  @IBOutlet weak var dishInput: UITextField!
  @IBOutlet weak var descInput: UITextField!
  @IBOutlet weak var priceInput: UITextField!
  @IBOutlet var imgurl: String! = "no"
 
    @IBOutlet weak var photo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func addDish(_ sender: UIButton) {
    //var menuAry = [String]()
    let menuAry = ChefManager.sharedInstance.chef.menus!
    let menuID = menuAry[0]
    let newDish = Dish(_id:nil, name:dishInput.text!, description:descInput.text!, price:Float(priceInput.text!)!, photo:imgurl, cuisineType:"a", cooktime:nil)
//   print(menuID)
//    print(menuAry[0])
//   print(newDish)
    RestAPIManager.sharedInstance.post_chef_menus_dish(id:menuID,dish:newDish,
    onSuccess:{(dish:Dish) in DispatchQueue.main.async{
      print("add dish success")
    }

    }
    ,onFailure:{_ in DispatchQueue.main.async{
      print("fail to add dish")
    }

    })
  }
    
    // MARK: Actions
    @IBAction func imgSelector(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        //nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photo.image = selectedImage
        
        let randint1 = Int(arc4random_uniform(1000000000))
        let randint2 = Int(arc4random_uniform(1000000000))
        let filename = "photo"+String(randint1)+"photo"+String(randint2)
        let myImage = photo.image
        let imgData = UIImageJPEGRepresentation(myImage!, 1.0)
        let config = CLDConfiguration(cloudName: "dz02pwbb6")
        let cloudinary = CLDCloudinary(configuration: config)
        let params = CLDUploadRequestParams().setUploadPreset("suci7q5w").setPublicId(filename)
        
        let request = cloudinary.createUploader().signedUpload(data: imgData!, params: params)
            .response( { response, error in
                print(">>> error: ")
                print(error)
                print(">>> response:")
                print(response)
            } )
        
        print(">>> request:")
        print(request)
        
        // This is the image url we need to save!
        imgurl = "http://res.cloudinary.com/dz02pwbb6/image/upload/"+filename+".jpg"

        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tabtab(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        //nameTextField.resignFirstResponder()
        print(">>>>>>> HEY TABTAB")
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)

    }
    
    
}
