//
//  LoginViewController.swift
//  Twitter
//
//  Created by Case Wright on 2/2/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(UserDefaults.standard.bool(forKey: "userLoggedIn")) {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    

    @IBAction func onLoginBtn(_ sender: Any) {
        let apiURL = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: apiURL, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: {_ in
            
        })
        
        /*TwitterAPICaller.client?.login(url: apiURL, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("could not log in")
        })*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(UserDefaults.standard.bool(forKey: "userLoggedIn"))
    }

}
