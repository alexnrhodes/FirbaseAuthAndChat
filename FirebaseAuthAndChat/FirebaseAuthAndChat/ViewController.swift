//
//  ViewController.swift
//  FirebaseAuthAndChat
//
//  Created by Alex Rhodes on 12/12/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else { return }
        
        authUI?.delegate = self
        
        let authVC = authUI!.authViewController()
        
        present(authVC, animated: true, completion: nil)
    }
    
}

extension ViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        if error != nil {
            return
        }
        
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
}
