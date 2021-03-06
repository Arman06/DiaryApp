//
//  ViewController.swift
//  diary
//
//  Created by Арман on 11/4/18.
//  Copyright © 2018 Арман. All rights reserved.
//
import UIKit

class LogInViewController: UIViewController {

    let defaults = UserDefaults.standard
    var login = String()
    var password = String()
    var topAnchor: NSLayoutConstraint?
    var topAnchorConstantHolder: CGFloat?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font : UIFont(name: "Avenir", size: 35)!])
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: textThemeColor, range: NSRange(location: 0, length: 3))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 1, green: 0.3513356447, blue: 0.3235116899, alpha: 1) , range: NSRange(location: 4, length: 2))
        label.attributedText = attributedString
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(loginField)
        stack.addArrangedSubview(passwordField)
        stack.addArrangedSubview(logInButton)
        return stack
    }()
    
    let loginField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(string: "Login",
                                                         attributes:[NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8979702592, green: 0.8980781436, blue: 0.8979334831, alpha: 1)])
        field.backgroundColor = #colorLiteral(red: 0.3135865331, green: 0.3139150143, blue: 0.3050451577, alpha: 1)
        field.borderStyle = .roundedRect
        field.keyboardType = .default
        field.textColor = #colorLiteral(red: 0.8979702592, green: 0.8980781436, blue: 0.8979334831, alpha: 1)
        field.keyboardAppearance = .dark
        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: "Password",
                                                         attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8979702592, green: 0.8980781436, blue: 0.8979334831, alpha: 1)])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = #colorLiteral(red: 0.3135865331, green: 0.3139150143, blue: 0.3050451577, alpha: 1)
        field.borderStyle = .roundedRect
        field.keyboardType = .default
        field.isSecureTextEntry = true
        field.textColor = #colorLiteral(red: 0.8979702592, green: 0.8980781436, blue: 0.8979334831, alpha: 1)
        field.keyboardAppearance = .dark
        return field
    }()
    
    let logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1914029121, green: 0.1960671544, blue: 0.2047308981, alpha: 1)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(logInButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addNotificationObserevers()
        configureTapGesture()
        topAnchorConstantHolder = topAnchor?.constant
        loginField.delegate = self
        passwordField.delegate = self
    }
    
    
    func setupViews() {
        view.addSubview(stackView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[v0]-25-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": stackView]))
        topAnchor =  stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        topAnchor?.isActive = true
        stackView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    
    
    
    
    func addNotificationObserevers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo {
            let keyboardRect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            if keyboardRect.height > 0 {
                let difference = self.view.frame.height - ((self.topAnchor?.constant)! + self.stackView.frame.height + keyboardRect.height + self.view.safeAreaInsets.top + 15)
                if difference < 0 {
                    self.topAnchor?.constant = (self.topAnchor?.constant)! - abs(difference)
                }
                UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    
    
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.topAnchor?.constant = topAnchorConstantHolder!
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    
    
    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
    @objc func logInButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        Eljur.logIn(login, password) { (token, error, errorString) in
            if token != nil {
                self.defaults.set(token, forKey: "token")
                self.present(RootTabBarController(), animated: true, completion: nil)
            } else if error != nil {
                let alert = UIAlertController(title: nil, message: "Ошибка", preferredStyle: .alert)
                let action = UIAlertAction(title: "Окей", style: .destructive, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else if errorString != nil {
                let alert = UIAlertController(title: nil, message: errorString, preferredStyle: .alert)
                let action = UIAlertAction(title: "Окей", style: .destructive, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}



extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == loginField {
            login = textField.text ?? ""
        }
        if textField == passwordField {
            password = textField.text ?? ""
        }
    }
}


