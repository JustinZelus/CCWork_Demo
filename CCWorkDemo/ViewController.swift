import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    fileprivate let googleMapButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Locationing", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(googleMapButtonEvent), for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    
    fileprivate let cameraButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Take a photo", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(cameraButtonEvent), for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    
    fileprivate let twoRequestButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Data List", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(twoRequestButtonEvent), for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    
    fileprivate let loginButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(loginButtonEvent), for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    
    @objc func loginButtonEvent(sender:UIButton!) {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func twoRequestButtonEvent(sender:UIButton!) {
        let dataListVC = DataListViewController()
        self.navigationController?.pushViewController(dataListVC, animated:true)
    }
    
    @objc func googleMapButtonEvent(sender:UIButton!) {
        let gooleMapVC = GoogleMapViewController()
        self.navigationController?.pushViewController(gooleMapVC, animated: true)
    }
    
    @objc func cameraButtonEvent(sender:UIButton!) {
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.showsCameraControls = true
            self.present(imagePicker, animated: false, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(googleMapButton)
        googleMapButton.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 36).isActive = true
        googleMapButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        googleMapButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        googleMapButton.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        view.addSubview(cameraButton)
        cameraButton.topAnchor.constraint(equalTo: googleMapButton.bottomAnchor, constant: 24).isActive = true
        cameraButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        cameraButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        view.addSubview(twoRequestButton)
        twoRequestButton.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 24).isActive = true
        twoRequestButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        twoRequestButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        twoRequestButton.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        view.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: twoRequestButton.bottomAnchor, constant: 24).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        print("end")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
               print("No image found")
               return
        }
        
        let photoFramePickerVC = PhotoFramePickerViewController()
        photoFramePickerVC.targetPhoto = image
        self.navigationController?.pushViewController(photoFramePickerVC, animated:true)
        //self.present(photoFramePickerVC, animated: true, completion: nil)
    }
  
}

