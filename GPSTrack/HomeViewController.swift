import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
    }

    private func setupButtons() {
        let userButton = UIButton(type: .system)
        userButton.setTitle("User Mode", for: .normal)
        userButton.addTarget(self, action: #selector(userModeTapped), for: .touchUpInside)

        let adminButton = UIButton(type: .system)
        adminButton.setTitle("Admin Mode", for: .normal)
        adminButton.addTarget(self, action: #selector(adminModeTapped), for: .touchUpInside)
        
        
    }

    @objc func userModeTapped() {
        let userVC = UserViewController()
        navigationController?.pushViewController(userVC, animated: true)
    }

    @objc func adminModeTapped() {
        let adminVC = AdminViewController()
        navigationController?.pushViewController(adminVC, animated: true)
    }
}
