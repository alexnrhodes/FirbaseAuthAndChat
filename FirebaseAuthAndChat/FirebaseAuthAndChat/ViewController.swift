//
//  ViewController.swift
//  FirebaseAuthAndChat
//
//  Created by Alex Rhodes on 12/12/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit
import FirebaseUI
import GoogleSignIn

class ViewController: UIViewController, GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let signIn = GIDSignIn.sharedInstance()
        signIn?.presentingViewController = self
        signIn?.delegate = self
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            NSLog("Error signing in with Google: \(error)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                NSLog("Error signing in with Google: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let messageViewController = storyboard.instantiateViewController(withIdentifier: "GoogleAuthViewController")
                self.present(messageViewController, animated: true, completion: nil)
            }
        }
    }

    func setupViews() {
        let googleButton = GIDSignInButton()
        googleButton.colorScheme = .light
        googleButton.backgroundColor = .black
        googleButton.tintColor = .black
        googleButton.center = self.view.center
        googleButton.style = .iconOnly
        self.view.addSubview(googleButton)
    }
    
}

