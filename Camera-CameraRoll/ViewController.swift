//
//  ViewController.swift
//  CameraAndCameraRol
//
//  Created by Javier Cruz Santiago on 1/14/19.
//  Copyright © 2019 Javier Cruz Santiago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView!
    var buttonCamera: UIButton!
    var buttonCameraRol: UIButton!
    var buttonSave: UIButton!
    
    func createView() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.lightGray
        
        buttonCamera = UIButton()
        buttonCamera.setTitle("Cámara", for: .normal)
        buttonCamera.setTitleColor(.white, for: .normal)
        buttonCamera.backgroundColor = .red
        buttonCamera.addTarget(self, action: #selector(getPictureFromCamera), for: .touchUpInside)
        
        buttonCameraRol = UIButton()
        buttonCameraRol.setTitle("Galería", for: .normal)
        buttonCameraRol.setTitleColor(.white, for: .normal)
        buttonCameraRol.backgroundColor = .black
        buttonCameraRol.addTarget(self, action: #selector(getPictureFromCameraRol), for: .touchUpInside)
        
        buttonSave = UIButton()
        buttonSave.setTitle("Guardar", for: .normal)
        buttonSave.setTitleColor(.white, for: .normal)
        buttonSave.backgroundColor = .blue
        buttonSave.addTarget(self, action: #selector(savePictureAtCameraRoll), for: .touchUpInside)
    }
    
    func addViews() {
        view.addSubview(imageView)
        view.addSubview(buttonCamera)
        view.addSubview(buttonCameraRol)
        view.addSubview(buttonSave)
    }
    
    func setupLayout() {
        imageView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: view.frame.width, height: view.frame.height / 2)
        
        let buttonHeight = ((view.frame.height - UIApplication.shared.statusBarFrame.height) / 2) / 3
        
        buttonCameraRol.frame = CGRect(x: 0, y: view.frame.height - buttonHeight * 1, width: view.frame.width, height: buttonHeight)
        buttonCamera.frame = CGRect(x: 0, y: view.frame.height - buttonHeight * 2, width: view.frame.width, height: buttonHeight)
        buttonSave.frame = CGRect(x: 0, y: view.frame.height - buttonHeight * 3, width: view.frame.width, height: buttonHeight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        addViews()
        setupLayout()
    }
}

//MARK: UIElements Actions
extension ViewController {
    @objc func getPictureFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            navigationController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func getPictureFromCameraRol() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            navigationController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func savePictureAtCameraRoll() {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, nil, nil)
    }
}

//MARK: UIImagePickerControllerDelegate Management
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        let imageE = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        imageView.image = image
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

//MARK: UINavigationControllerDelegate Management
extension ViewController: UINavigationControllerDelegate {
    
}
