//
//  ViewController.swift
//  keyboardHandling Febuary 3rd 2020
//
//  Created by Margiett Gil on 2/3/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pursuitLogo: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
     @IBOutlet weak var pursuitLogoCenterY: NSLayoutConstraint!
    
    private var visableKeyboard = false
    private var originalYConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pulsateLogo()
        registerForKeyboardNotifications()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterForKeyboardNofications()
    }
    
    private func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    
    
    private func unregisterForKeyboardNofications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
    }
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        print("keyboardWillShow")
        
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
        }
        
        moveKeyBoardUp(keyboardFrame.size.height)
        print("keyboard frame is \(keyboardFrame)")
    }
    
    @objc
    private func keyboardWillHide(_ notification: NSNotification){
           resetUI()
        
        
        print("keyboardWillHide")
        print(notification.userInfo)
        //TODO: complete
    }
    
    func moveKeyBoardUp(_ height: CGFloat) {
        if visableKeyboard { return }
        originalYConstraint = pursuitLogoCenterY // save original value
        
        pursuitLogoCenterY.constant -= (height * 0.80)
        // 0, -301 = > - 240.8
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
           }
      
        visableKeyboard = true
    }
   
    
    
    private func resetUI() {
        visableKeyboard = false
        //-314 = 0, + 314
        pursuitLogoCenterY.constant -= originalYConstraint.constant
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
        
    }
    private func pulsateLogo() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.pursuitLogo.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil )
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
     
        return true
    }
}
