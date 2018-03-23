//
//  RestAPIManager.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-04.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class RestAPIManager: NSObject {
    let baseURL = "https://take-out-server.herokuapp.com"
    let baseURL2 = "https://jsonplaceholder.typicode.com"
    static let fileName = "RestAPIManager"
    static let sharedInstance = RestAPIManager()
    func getRequestObject<T: Decodable>(request: URLRequest,
                                        onSuccess:@escaping (T) -> Void,
                                        onFailure:@escaping(Any) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if err == nil{
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data!)
                    onSuccess(responseObject)
                } catch {
                    print("Complier Catch Error Info: \(error)")
                    let serverErr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Server Info: " + String(describing: serverErr))
                    onFailure(err.debugDescription)
                }
            }
        }.resume()
    }

//    fun post_bambora_payment(creditCard:CreditCard, passcode:String,
//    onSuccess:@)
  
    //For Testing purpose...Can do the refactoring later
    func getTodo(id:Int, onSuccess:@escaping (Todo) -> Void,
                         onFailure:@escaping(Any) -> Void) {
        let todo = "/todos/"
        let requestURL =  "\(baseURL2)\(todo)\(String(id))"
        guard let url = URL(string:requestURL) else { return }
        getRequestObject(request: URLRequest(url: url), onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getHeros(onSuccess:@escaping ([HeroStats2]) -> Void, onFailure:@escaping(Any) -> Void) {
        let reqURL = "https://api.opendota.com" + "/api" + "/heroStats"
        guard let url = URL(string: reqURL) else {return}
        getRequestObject(request: URLRequest(url: url), onSuccess: onSuccess, onFailure: onFailure)
    }
    
    /*
     * ===============[GET CALLS]=============
     */
    //Get chefs around user location
    func get_chefs(type: String, limit: Int, longitude:Double, latitude:Double,
                   onSuccess:@escaping ([Chef]) -> Void,
                   onFailure:@escaping(Any) -> Void) {
        //@TODO:embed location body in the API url query.
        var urlComponents = URLComponents(string: (baseURL+"/chefs"))
        urlComponents?.queryItems = [
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "longitude", value: "\((longitude))"),
            URLQueryItem(name: "latitude", value: "\((latitude))")
        ]
        print(String(describing: urlComponents?.url))
        guard let url = urlComponents?.url else { return }
        getRequestObject(request: URLRequest(url: url), onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Get menus for specified chef
    func get_menus(id:String, onSuccess:@escaping ([Menu]) -> Void,
                  onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/chefs/" + id + "/menus")) else { return }
        print(url)
        getRequestObject(request: URLRequest(url: url), onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Get orders for chef
    func get_chef_orders(onSuccess:@escaping ([Order]) -> Void,
                         onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/chef/orders")) else { return }
        getRequestObject(request: URLRequest(url: url), onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Get chef summary
    func get_chef_summary(onSuccess:@escaping (Text) -> Void,
                          onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/chef/summary")) else { return }
        getRequestObject(request: URLRequest(url: url), onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Get all orders
    func get_orders(onSuccess:@escaping ([Order]) -> Void,
                    onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/orders")) else { return }
        getRequestObject(request: URLRequest(url: url), onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Get chefs for administration
    func get_chefs_all(onSuccess:@escaping ([Chef]) -> Void,
                       onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/chefs/all")) else { return }
        getRequestObject(request: URLRequest(url: url), onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Get all users
    func get_users(onSuccess:@escaping ([User]) -> Void,
                   onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/users")) else { return }
        getRequestObject(request: URLRequest(url: url), onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Get admin summary
    func get_admin_summary(onSuccess:@escaping (Text) -> Void,
                           onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/admin/summary")) else { return }
        getRequestObject(request: URLRequest(url: url), onSuccess: onSuccess, onFailure: onFailure)
    }
    /*
     * ===============[POST CALLS]============
     */
    // Testing purpose
    func post_test(post:Post, onSuccess:@escaping (Post) -> Void,
                              onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(post)
            request.httpBody = jsonBody
        } catch {
            print("post_test ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    // For user to login to app
    func post_user_login(userName:String, passWord:String,
                         onSuccess:@escaping (User) -> Void,
                         onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/user/login")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let login = Login(username: userName, password: passWord)
        do {
            let jsonBody = try JSONEncoder().encode(login)
            request.httpBody = jsonBody
        } catch {
            print("post_user_login ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    // For user to register account
    func post_user_register(register: Register,
                            onSuccess:@escaping (User) -> Void,
                            onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/user/register")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(register)
            request.httpBody = jsonBody
        } catch {
            print("post_user_register ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
//        URLSession.shared.dataTask(with: request) { (data, response, err) in
//            let errMsg = RestAPIManager.fileName + "::post_user_register:"
//            if err == nil {
//                guard let data = data else {return}
//                do {
//                    // Might want do something later....Print json response data for now
//                    let json = try JSONSerialization.jsonObject(with: data, options:[])
//                    print(json)
//                    onSuccess()
//                } catch {
//                    print(errMsg + " JSON Error")
//                    onFailure(errMsg + " JSON Error")
//                }
//            } else {
//                print(errMsg + err.debugDescription)
//                onFailure(errMsg + " API Request Error")
//            }
//        }.resume()
    }
    
    // Creates new order
    func post_orders(newOrder: NewOrder,
                     onSuccess:@escaping (Order) -> Void,
                     onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/orders")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(newOrder)
            request.httpBody = jsonBody
        } catch {
            print("post_orders ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    // For chef to login to app
    func post_chef_login(login: Login,
                         onSuccess:@escaping (Chef) -> Void,
                         onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/chef/login")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(login)
            request.httpBody = jsonBody
        } catch {
            print("post_user_login ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //For chef to register account
    func post_chef_register(newChef: NewChef,
                            onSuccess:@escaping (Chef) -> Void,
                            onFailure:@escaping(Any) -> Void) {
        
        guard let url = URL(string: (baseURL + "/chef/register")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(newChef)
            request.httpBody = jsonBody
        } catch {
            print("post_chef_register ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Create new menu for chef
    func post_chef_menus(menu: Menu,
                         onSuccess:@escaping (Menu) -> Void,
                         onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/chef/menus")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(menu)
            request.httpBody = jsonBody
            
        } catch {
            print("post_chef_menus ERR")
        }
        
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Create new dish for specified chef menu
    func post_chef_menus_dish(id:String, dish: Dish,
                              onSuccess:@escaping (Dish) -> Void,
                              onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/chef/menus/" + id + "/dishs")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(dish)
            print(dish)
            print(jsonBody as NSData)
            request.httpBody = jsonBody
        } catch {
            print("post_chef_menus_dish ERR")
        }
        print(request)
      
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //For admin to login to app
    func post_admin_login(login: Login,
                          onSuccess:@escaping (Admin) -> Void,
                          onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/admin/login")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(login)
            request.httpBody = jsonBody
        } catch {
            print("post_admin_login ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    /*
     * ===============[PUT CALLS]============
     */
    // Edit user information
    func put_edit_user(editUser: EditUser,
                       onSuccess:@escaping (User) -> Void,
                       onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/user")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(editUser)
            request.httpBody = jsonBody
        } catch {
            print("post_edit_user ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Claim discount using code
    func put_discounts(codeString: CodeString,
                       onSuccess:@escaping (Discount) -> Void,
                       onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/discounts")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(codeString)
            request.httpBody = jsonBody
        } catch {
            print("put_discounts ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Rate specified chef
    func put_chefs_rate(id: String, rate: EditRating,
                       onSuccess:@escaping (Chef) -> Void,
                       onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/chefs/" + String(id) + "/rate")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(rate)
            request.httpBody = jsonBody
        } catch {
            print("put_discounts ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Edit chef information
    func put_chef(editChef: NewChef,
                  onSuccess:@escaping (Chef) -> Void,
                  onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/chef")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(editChef)
            request.httpBody = jsonBody
        } catch {
            print("put_discounts ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Edit chef information
    func put_order_status(id:String, editOrder: EditOrderStatus,
                          onSuccess:@escaping (Order) -> Void,
                          onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/chef/orders/" + String(id))) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(editOrder)
            request.httpBody = jsonBody
        } catch {
            print("put_discounts ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Activated/deactivated specified chef
    func put_chefs_id(id:String, activated: Activated,
                      onSuccess:@escaping (Chef) -> Void,
                      onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/chefs/" + String(id))) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(activated)
            request.httpBody = jsonBody
        } catch {
            print("put_discounts ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //Activated/Deactivated specified user
    func put_users_id(id:String, activated: Activated,
                      onSuccess:@escaping (User) -> Void,
                      onFailure:@escaping(Any) -> Void) {
        guard let url = URL(string: (baseURL + "/users/" + String(id))) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(activated)
            request.httpBody = jsonBody
        } catch {
            print("put_discounts ERR")
        }
        getRequestObject(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
}
