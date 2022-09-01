//
//  ViewController.swift
//  PopoverApp
//
//  Created by Nikolai Maksimov on 01.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "swiftLogo-1")
        imageView.tintColor = .orange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "cmd + B, cmd + R"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tapButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.setTitle("?", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(tapButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        tapButton.layer.cornerRadius = tapButton.frame.width / 2
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        view.addSubview(nameLabel)
        view.addSubview(tapButton)
    }
    
    @objc func tapButtonPressed() {
        
        let popOverViewController = PopOverViewController()
        popOverViewController.modalPresentationStyle = .popover
        popOverViewController.preferredContentSize = CGSize(width: 130, height: 150)
        
        guard let presentationVC = popOverViewController.popoverPresentationController else { return }
        presentationVC.delegate = self
        presentationVC.sourceView = tapButton
        presentationVC.permittedArrowDirections = .down
        presentationVC.sourceRect = CGRect(x: tapButton.bounds.midX,
                                           y: tapButton.bounds.minY - 5,
                                           width: 0,
                                           height: 0)
        
        // включение отдельных (активных) кнопок на экране
        presentationVC.passthroughViews = [tapButton]
        
        if tapButton.titleLabel?.text == "?" {
            tapButton.setTitle("X", for: .normal)
            present(popOverViewController, animated: true)
        } else {
            tapButton.setTitle("?", for: .normal)
            presentedViewController?.dismiss(animated: true)
        }
        
        
        
        
    }
}
extension ViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
    // метод не дает закрыть popOver при нажатии в любом месте экрана
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        false
    }
    
}

// MARK: - Set constraints
extension ViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 0),
            
            tapButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tapButton.heightAnchor.constraint(equalToConstant: 50),
            tapButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}
