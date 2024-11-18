import UIKit
import CoreLocation

class UserViewController: UIViewController, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationTracking()
    }
    
    private func setupLocationTracking() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
//        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        
    }
}
