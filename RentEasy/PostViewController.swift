//
//  PostViewController.swift
//  RentEasy
//
//  Created by CodeSOMPs on 2023-11-10.
//

import UIKit
import MapKit

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var propetyNameField: UITextField!
    @IBOutlet weak var propertySizeField: UITextField!
    @IBOutlet weak var propertyAmountField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var propertyAddressField: UITextField!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var suggestionButton: UIButton!
    @IBOutlet weak var negotiableButton: UIButton!
    @IBOutlet weak var nonNegotiableButton: UIButton!
    @IBOutlet weak var agreeToTermsButton: UIButton!
    
    let imagePickerController = UIImagePickerController()
    var selectedImageData: Data?
    var imageViews: [UIImageView] = []
    var myImageIndex = 0
    var agreedToTerms = false
    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        imageViews = [imageOne, imageTwo, imageThree]
        imageOne.layer.cornerRadius = 15
        imageTwo.layer.cornerRadius = 15
        imageThree.layer.cornerRadius = 15
        suggestionButton.setTitle("Address", for: .normal)
        suggestionButton.isHidden = true
        nonNegotiableButton.setImage(UIImage(systemName: "circle"), for: .normal)
        negotiableButton.setImage(UIImage(systemName: "circle.circle.fill"), for: .normal)
    }
    
    //MARK: - IMAGE UPLOAD METHODS
    func uploadNewPicture() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        let action = UIAlertController(title: "Upload Image", message: nil, preferredStyle: .actionSheet)
        let cameraOpt = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            } else {
                print("Enable camera access!")
            }
        }
        let galleryOpt = UIAlertAction(title: "Gallery", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        action.addAction(cameraOpt)
        action.addAction(galleryOpt)
        action.addAction(cancelButton)
        present(action, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        selectedImageData = image.jpegData(compressionQuality: 0.8)
        guard myImageIndex < imageViews.count else {return}
        imageViews[myImageIndex].image = image
        myImageIndex += 1
        dismiss(animated: true)
    }
    
    func resetImages() {
        for images in imageViews {
            images.image = nil
        }
    }
    
    func getImageDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    //MARK: - TERMS, NEGOTIABLE AND NON-NEGOTIABLE BUTTONS
    @IBAction func negotiableButtonPressed(_ sender: UIButton) {
        if negotiableButton.currentImage == UIImage(systemName: "circle") {
            negotiableButton.setImage(UIImage(systemName: "circle.circle.fill"), for: .normal)
        } else {
            negotiableButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        nonNegotiableButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    
    @IBAction func nonNegotiableButtonPressed(_ sender: UIButton) {
        if nonNegotiableButton.currentImage == UIImage(systemName: "circle") {
            nonNegotiableButton.setImage(UIImage(systemName: "circle.circle.fill"), for: .normal)
        } else {
            nonNegotiableButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        negotiableButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    
    @IBAction func agreeToTermsButtonPressed(_ sender: UIButton) {
        agreedToTerms.toggle()
        let termsImage = agreedToTerms ? "checkmark.rectangle" : "rectangle"
        let image = UIImage(systemName: termsImage)
        agreeToTermsButton.setImage(image, for: .normal)
    }
    
    
    //MARK: - UPLOAD ACTIONS
    @IBAction func uploadButtonPressed(_ sender: UIButton) {
        uploadNewPicture()
    }
    
    @IBAction func sumbitButtonPressed(_ sender: UIButton) {
        guard let name = propetyNameField.text,
              let address = propertyAddressField.text,
              let size = propertySizeField.text,
              let amount = Int16(propertyAmountField.text ?? "100"),
              let description = descriptionField.text,
              !name.isEmpty,
              !address.isEmpty,
              !size.isEmpty,
              !description.isEmpty,
              agreedToTerms
        else {
            confirmationAlert(message: "All fields must be filled.")
            return
        }
        
        Task {
            if let places = await getPlace(in: address) {
                DataModelManager.shared.uploadRentDataEntity(name: name, address: address, longitude: places.coordinate.longitude, latitude: places.coordinate.latitude, amount: Int(amount), size: size, newImage: selectedImageData, description: description)
            } else {
                confirmationAlert(message: "Address not Found")
            }
        }
        
        propetyNameField.text = ""
        propertyAddressField.text = ""
        propertyAmountField.text = ""
        propertySizeField.text = ""
        descriptionField.text = ""
        resetImages()
        successfulAlert()    }
    
    private func successfulAlert() {
        let alertController = UIAlertController(title: "Upload Successful", message: nil, preferredStyle: .alert)
        let oK = UIAlertAction(title: "OK", style: .destructive)
        alertController.addAction(oK)
        present(alertController, animated: true, completion: nil)
    }
    
    private func confirmationAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - ADDRESS AUTOCOMPLETION
struct AddressItem: Identifiable {
    var id = UUID()
    let longitude: String
    let latitude: String
}

extension PostViewController: MKLocalSearchCompleterDelegate {
    @IBAction func onTouchSuggestion(_ sender: UIButton) {
        propertyAddressField.text = suggestionButton.titleLabel?.text
        suggestionButton.isHidden = true
        
    }
    @IBAction func onSearchAddress(_ sender: UITextField) {
        if(sender.text! == ""){
            suggestionButton.isHidden = true
            return
        }
        searchAddress(sender.text!)
        suggestionButton.isHidden = false
    }
    
    func searchAddress(_ searchableText: String) {
        guard searchableText.isEmpty == false else { return }
        localSearchCompleter.queryFragment = searchableText
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in
            let firstResultIndex = completer.results[0]
            suggestionButton.setTitle(firstResultIndex.title + ", " + firstResultIndex.subtitle, for: .normal)
        }
    }
    
    func getPlace(in address: String) async -> MKPlacemark? {
        let locationRequest = MKLocalSearch.Request()
        locationRequest.naturalLanguageQuery = address
        do {
            let response = try await MKLocalSearch(request: locationRequest).start()
            if let firstPlaceFound = response.mapItems.first {
                return firstPlaceFound.placemark
            } else {
                return nil
            }
        } catch {
            fatalError("\(error)")
        }
    }
}

