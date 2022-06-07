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
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderWidth = 1
        field.clipsToBounds = true
        field.layer.cornerRadius = 20
        return field
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.addTarget(self, action: #selector(didTapDownloadButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        return button
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let saveToGallery: UIButton = {
        let button = UIButton()
        button.setTitle("Save to Gallery", for: .normal)
        button.addTarget(self, action: #selector(didTapDownloadImageButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.center = view.center
        view.addSubview(imageView)
        view.addSubview(textField)
        view.addSubview(downloadButton)
        view.addSubview(saveToGallery)
        setUpConstraints()
        
    }
    
    @objc func didTapDownloadButton() {
        downloadImage(url: textField.text ?? "")
    }
    
    @objc func didTapDownloadImageButton() {
        let imageData = UIImage.pngData(imageView.image!)
        let compressedImage = UIImage(data: imageData()!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
                
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            downloadButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 400),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            saveToGallery.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveToGallery.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30)
        ])
    }


}

