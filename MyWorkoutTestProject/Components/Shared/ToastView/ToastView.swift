//
//  ToastView.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import UIKit

final class ToastView: UIView {
    
    enum Position {
        case top
        case bottom
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var messageLabel: UILabel!
    
    lazy var keyWindow: UIWindow? = UIApplication.shared.windows.first
    
    // MARK: - Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setGestureRecognizers()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setCornerRadius()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setCornerRadius()
    }
    
    private func setCornerRadius() {
        layer.cornerRadius = frame.height / 2
    }
    
    func setGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeGesture.direction = .down
        addGestureRecognizer(swipeGesture)
    }
    
    // MARK: - Actions
    
    @objc
    private func tapAction(_ sender: UITapGestureRecognizer) {
        hide(withDelay: .zero)
    }
    
    @objc
    private func swipeAction(_ sender: UISwipeGestureRecognizer) {
        hide(withDelay: .zero)
    }
    
    // MARK: - Public
    
    func show(withMessage message: String, at position: Position = .bottom) {
        if let keyWindow = keyWindow, keyWindow.subviews.contains(self) {
            setMessage(message)
            return
        }
        
        showAndHide(at: position)
        
        setMessage(message)
    }
    
    func show(withMessage message: String, at position: Position = .bottom, in view: UIView) {
        if view.subviews.contains(self) {
            setMessage(message)
            return
        }
        
        showAndHide(at: position, in: view)
        
        setMessage(message)
    }
    
    func showPermanently(withMessage message: String, at position: Position) {
        if let keyWindow = keyWindow, keyWindow.subviews.contains(self) {
            setMessage(message)
            return
        }
        
        showPermanently(at: position)
        
        setMessage(message)
    }
    
    func showPermanently(withMessage message: String, at position: Position, in view: UIView) {
        if view.subviews.contains(self) {
            setMessage(message)
            return
        }
        
        showPermanently(at: position, in: view)
        
        setMessage(message)
    }
    
    func setMessage(_ message: String) {
        messageLabel.text = message
    }
    
    func hide(withDelay delay: TimeInterval = 2) {
        UIView.animate(withDuration: 0.3, delay: delay, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    private func showAndHide(at position: Position) {
        show(at: position)
        animateEntryAndHide()
    }
    
    private func showAndHide(at position: Position, in view: UIView) {
        show(at: position, in: view)
        animateEntryAndHide()
    }
    
    private func showPermanently(at position: Position) {
        show(at: position)
        animateEntry()
    }
    
    private func showPermanently(at position: Position, in view: UIView) {
        show(at: position, in: view)
        animateEntry()
    }
    
    private func show(at position: Position, in view: UIView) {
        view.addSubview(self)
        
        switch position {
        case .bottom:
            if #available(iOS 11.0, *) {
                NSLayoutConstraint.activate([
                    view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
                    centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    widthAnchor.constraint(lessThanOrEqualToConstant: 370),
                ])
            } else {
                NSLayoutConstraint.activate([
                    bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0),
                    centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    widthAnchor.constraint(lessThanOrEqualToConstant: 370),
                ])
            }
            
        case .top:
            if #available(iOS 11.0, *) {
                NSLayoutConstraint.activate([
                    view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: topAnchor, constant: -view.frame.height * 0.1),
                    centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    widthAnchor.constraint(lessThanOrEqualToConstant: 370),
                ])
            } else {
                NSLayoutConstraint.activate([
                    topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1),
                    centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    widthAnchor.constraint(lessThanOrEqualToConstant: 370),
                ])
            }
        }
        
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        setNeedsDisplay()
        layoutIfNeeded()
        
        animateEntry()
    }
    
    private func show(at position: Position) {
        if let keyWindow = keyWindow {
            keyWindow.addSubview(self)
            
            switch position {
            case .bottom:
                if #available(iOS 11.0, *) {
                    NSLayoutConstraint.activate([
                        keyWindow.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 60),
                        centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor),
                        widthAnchor.constraint(lessThanOrEqualToConstant: 370),
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor, constant: -30.0),
                        centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor),
                        widthAnchor.constraint(lessThanOrEqualToConstant: 370),
                    ])
                }
                
            case .top:
                if #available(iOS 11.0, *) {
                    NSLayoutConstraint.activate([
                        keyWindow.safeAreaLayoutGuide.topAnchor.constraint(equalTo: topAnchor, constant: -keyWindow.frame.height * 0.1),
                        centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor),
                        widthAnchor.constraint(lessThanOrEqualToConstant: 370),
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        topAnchor.constraint(equalTo: keyWindow.topAnchor, constant: keyWindow.frame.height * 0.1),
                        centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor),
                        widthAnchor.constraint(lessThanOrEqualToConstant: 370),
                    ])
                }
            }
        }
        
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        setNeedsDisplay()
        layoutIfNeeded()
        
        animateEntry()
    }
    
    @objc
    private func animateEntryAndHide() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { _ in
            self.hide()
        })
    }
    
    private func animateEntry() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
}

