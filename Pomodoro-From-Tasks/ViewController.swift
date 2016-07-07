//
//  ViewController.swift
//  Pomodoro-From-Tasks
//
//  Created by Drew Westcott on 04/07/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
            
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.value(forKey: KEY_UID) != nil {
            self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timersButtonPressed(sender: UIButton!) {
        performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
    }
    
    @IBAction func attemptLogin(sender: UIButton!) {
        print("login/signup pressed")
        if let email = loginEmail.text where email != "", let pwd = loginPassword.text where pwd != "" {
            print("DW:log: email and password provided")
            let signInEmail = loginEmail.text!
            let signInPass = loginPassword.text!
            /// Trying to Signing In User
            FIRAuth.auth()?.signIn(withEmail: signInEmail, password: signInPass) { (user, error) in
                if error != nil {
                    print("DW:Error:\(error)")
                    if let errorCode = FIRAuthErrorCode(rawValue: (error?.code)!) {
                        print("DW:Raw:\(errorCode)")
                        if errorCode == .errorCodeUserNotFound {
                            //Trying to Create User
                            print("DW: Going to create account \(signInEmail) : \(signInPass)")
                            FIRAuth.auth()?.createUser(withEmail: signInEmail, password: signInPass, completion: { (result, error) in
                                if error != nil {
                                    if let errorCode = FIRAuthErrorCode(rawValue: (error?.code)!) {
                                        self.showErrorAlert(title: "Password Too Short", msg: "The Password must be at least 6 characters in length")
                                    } else {
                                        print("DW:Could not create account. Error: \(error)")
                                    }
                                } else {
                                    print("DW:\(result)")
                                    if let uid = result?.uid {
                                        //Actually sign in here
                                        print("UID: \(uid)")
                                        FIRAuth.auth()?.signIn(withEmail: signInEmail, password: signInPass, completion: { (authData, error) in
                                            
                                            if error != nil {
                                                print("DW:oops something happened")
                                            } else {
                                                print("DW:Signed in")
                                                UserDefaults.standard.setValue(uid, forKey: KEY_UID)
                                                self.performSegue(withIdentifier: SEGUE_POMODORO, sender: nil)
                                            }
                                        })
                                    }
                                }
                            })
                            //End of Trying to Create User
                        }
                    }
                } else {
                    if let uid = user?.uid {
                        //Actually sign in here
                        print("UID: \(uid)")
                        FIRAuth.auth()?.signIn(withEmail: signInEmail, password: signInPass, completion: { (authData, error) in
                            
                            if error != nil {
                                print("DW:oops something happened")
                            } else {
                                print("DW:Signed in")
                                UserDefaults.standard.setValue(uid, forKey: KEY_UID)
                                self.performSegue(withIdentifier: SEGUE_POMODORO, sender: nil)
                            }
                        })
                    }

                }
            }
            // End of Signing In User
        } else {
            showErrorAlert(title: "Email and Password Required", msg: "You must enter an email and a password to signup or login.")
        }
    }
    

    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
