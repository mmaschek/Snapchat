//
//  SignInViewController.swift
//  Snapchat
//
//  Created by Mike Maschek on 5/11/17.
//  Copyright © 2017 Mike Maschek. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func turnUpTapped(_ sender: Any) {
        
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                print("We tried to sign in")
                if error != nil {
                    print("Hey we have an error:\(error)")
                    
                    FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                        print("We tried to create a user")
                        
                        if error != nil {
                            print("Hey we have an error:\(error)")
                        }
                        else {
                            print("Created user successfully!")
                            
                            FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                            
                            self.performSegue(withIdentifier: "signinsegue", sender: nil)
                        }
                    })
                }
                else {
                    print("Signed in successfully!")
                    self.performSegue(withIdentifier: "signinsegue", sender: nil)
                }
            })
        
    }

}

