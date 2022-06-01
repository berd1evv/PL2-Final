//
//  ViewController.swift
//  PL2-Final
//
//  Created by Eldiiar on 26/5/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter the link of the photo"
        field.textAlignment = .center
        field.frame = CGRect(x: 50, y: 90, width: 350, height: 40)
        field.layer.borderWidth = 1
        field.clipsToBounds = true
        field.layer.cornerRadius = 20
        return field
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.addTarget(self, action: #selector(didTapDownloadButton), for: .touchUpInside)
        button.frame = CGRect(x: 140, y: 140, width: 90, height: 40)
        button.backgroundColor = .black
        return button
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.frame = CGRect(x: 0, y: 0, width: 600, height: 300)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.center = view.center
        view.addSubview(imageView)
        view.addSubview(textField)
        view.addSubview(downloadButton)
        
    }
    
    @objc func didTapDownloadButton() {
        downloadImage(url: textField.text ?? "")
    }
    
    func downloadImage(url: String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.main.async {
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self.imageView.image = loadedImage
                }
            }
        }
        
    }


}

