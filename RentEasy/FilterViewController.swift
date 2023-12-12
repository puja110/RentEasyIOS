//
//  FilterViewController.swift
//  RentEasy
//
//  Created by CodeSOMPs on 2023-11-03.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class FilterViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapToSafeArea: NSLayoutConstraint!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var searchBarAppearance = SearchBarAppearance()
    let locationManager = CLLocationManager()
    var searchedDataResult: [RentDataEntity] = []
    var destinationVC: FilteredResultViewController?
    var selectedProperty: RentDataEntity?
    var rentDataEntityProperty: [RentDataEntity] = []
    var detailData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        destinationVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "FilteredResult") as? FilteredResultViewController
        navigationItem.title = "Search"
        navigationController?.setNavigationBarHidden(false, animated: true)
        rentDataEntityProperty = DataModelManager.shared.loadAllItems()
        searchTextField.delegate = self
        mapView.delegate = self
        searchBarAppearance.magnifyingGlassOnly(searchTextField)
        filterButton()
        locationService()
    }
    
    
    //MARK: - Location configuration
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let setLatitude = 44.389355
        let setLongitude = -79.690331
        let serviceLocation = CLLocationCoordinate2D(latitude: setLatitude, longitude: setLongitude)
        let serviceRegion = MKCoordinateRegion(center: serviceLocation, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(serviceRegion, animated: true)
        
    }
    
    func locationService() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            if let selectedProperty = selectedProperty {
                let coordinate = CLLocationCoordinate2D(latitude: selectedProperty.latitude, longitude: selectedProperty.longitude)
                let pin = MKPointAnnotation()
                pin.coordinate = coordinate
                pin.title = selectedProperty.name
                mapView.addAnnotation(pin)
            } else {
                presentLocation(location)
                rentDataEntityLocations()
            }
        }
    }
    
    func presentLocation(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let pin = MKPointAnnotation()
        pin.title = "Your Location"
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        mapView.selectAnnotation(pin, animated: true)
    }
    
    func rentDataEntityLocations() {
        for houses in rentDataEntityProperty {
            let houseLatitude = houses.latitude
            let houseLongitude = houses.longitude
            let houseLocation = CLLocationCoordinate2D(latitude: houseLatitude, longitude: houseLongitude)
            let annotation = NewAnnotation()
            annotation.coordinate = houseLocation
            annotation.title = houses.name
            annotation.subtitle = houses.address
            if let image = UIImage(data: houses.image!) {
                annotation.image = image
            }
            annotation.selectedItem = houses
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let customAnnotation = annotation as? NewAnnotation else { return nil }
        let annotationView = MKMarkerAnnotationView(annotation: customAnnotation, reuseIdentifier: "NewAnnotation")
        annotationView.canShowCallout = true
        let propertyImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        propertyImageView.image = customAnnotation.image
        propertyImageView.contentMode = .scaleAspectFit
        annotationView.leftCalloutAccessoryView = propertyImageView
        let disclosureButton = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = disclosureButton
        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let newAnnotation = view.annotation as? NewAnnotation {
                if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailPageID") as? DetailPageViewController {
                    destinationVC.selectedItem = newAnnotation.selectedItem
                    navigationController?.pushViewController(destinationVC, animated: true)
                }
            }
        }
    }

    
    //MARK: - SEARCH IMPLEMENTATION
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchedData = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        searchedDataResult = filteredResults(for: searchedData)
        destinationVC?.filteredRentData = searchedDataResult
        return true
    }
    
    func reloadTableView() {
        destinationVC?.tableView.reloadData()
    }
    
    func filteredResults(for searchedData: String) -> [RentDataEntity] {
        let request: NSFetchRequest<RentDataEntity> = RentDataEntity.fetchRequest()
        let predicate = NSPredicate(format: "name CONTAINS[c] %@ OR address CONTAINS[c] %@", searchedData, searchedData)
        request.predicate = predicate
        
        do {
            let resultData = try context.fetch(request)
            return resultData
        } catch {
            return []
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        presentVC()
        return true
    }
    
    //MARK: - BOTTOM SHEET
    func presentVC() {
        if let destinationVC = destinationVC {
            _ = searchTextField.text
            let results = searchedDataResult
            print("Results Count \(results.count)")
            destinationVC.filteredRentData = results
            destinationVC.modalPresentationStyle = .automatic
            
            if let bottomSheet = destinationVC.presentationController as? UISheetPresentationController {
                bottomSheet.detents = [.medium(), .large()]
                bottomSheet.largestUndimmedDetentIdentifier = .medium
                bottomSheet.preferredCornerRadius = 40
                bottomSheet.prefersScrollingExpandsWhenScrolledToEdge = false
                bottomSheet.prefersGrabberVisible = true
            }
            present(destinationVC, animated: true)
        }
        
    }
    
    func filterButton() {
        let filterSymbol = UIImage(systemName: "slider.vertical.3")
        let filterButton = UIButton(type: .custom)
        filterButton.setImage(filterSymbol, for: .normal)
        filterButton.tintColor = UIColor.black
        filterButton.frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        let paddingRight = UIView(frame: filterButton.frame)
        paddingRight.addSubview(filterButton)
        searchTextField.rightView = paddingRight
        searchTextField.rightViewMode = .always
        filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
    }
    
    @objc func filterButtonPressed() {
        let destinationVC = UIStoryboard(name: "Main", bundle: nil)
        if let searchFilter = destinationVC.instantiateViewController(withIdentifier: "SearchFilterView") as? SearchFilterView {
            if searchFilter.parent == nil {
                let navigationController = UINavigationController(rootViewController: searchFilter)
                navigationController.modalPresentationStyle = .popover
                self.present(navigationController, animated: true)
            }
        }
    }
}

//MARK: - CUSTOM ANNOTATION
class NewAnnotation: MKPointAnnotation {
    var image: UIImage?
    var selectedItem: RentDataEntity?
}
