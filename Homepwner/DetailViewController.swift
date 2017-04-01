//
//  DetailViewController.swift
//  Homepwner
//
//  WORKING COPY For ch. 15 - ch. 17
//
//  Created by Alex Louzao on 3/25/17.
//  Copyright © 2017 ALcsc2310. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            
            let overlayView = UIView(frame: imagePicker.cameraOverlayView!.frame)
            
            let crosshairLabel = UILabel()
            crosshairLabel.text = "+"
            crosshairLabel.font = UIFont.systemFont(ofSize: 50)
            crosshairLabel.translatesAutoresizingMaskIntoConstraints = false
            overlayView.addSubview(crosshairLabel)
            
            crosshairLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
            crosshairLabel.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor).isActive = true
            
            overlayView.isUserInteractionEnabled = false
            
            imagePicker.cameraOverlayView = overlayView
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageStore.setImage(image, forKey: item.itemKey)
        imageView.image = image
        dismiss(animated: true, completion: nil)
        removePictureBarButton.isEnabled = true
    }
    
    
    var imageStore: ImageStore!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    var item: Item! {
        didSet{
            navigationItem.title = item.name
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        let key = item.itemKey
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
        removePictureBarButton.isEnabled = imageView.image != nil
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText){
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField)->Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func backgroundTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "changeDate"?:
            let dateCreatedViewController = segue.destination as! DateChangeController
            dateCreatedViewController.item = item
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    var flexibleSpaceBarButton: UIBarButtonItem!
    var removePictureBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flexibleSpaceBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        removePictureBarButton = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self, action: #selector(removePicture(_:)))
        
        // Locate the toolbar at bottom and add to it the barButtons
        for subView in self.view.subviews {
            if let toolbar = subView as? UIToolbar {
                var toolbarItems = toolbar.items
                toolbarItems?.append(flexibleSpaceBarButton)
                toolbarItems?.append(removePictureBarButton)
                toolbar.setItems(toolbarItems, animated: true)
                break
            }
        }
    }
    
    @IBAction func removePicture(_ sender: UIBarButtonItem) {
        imageStore.deleteImage(forKey: item.itemKey)
        imageView.image = nil
        removePictureBarButton.isEnabled = false
    }
    
}

