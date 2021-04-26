

import Foundation
import UIKit

class PhotoFramePickerViewController: UIViewController {
    var targetPhoto: UIImage?
    
    fileprivate let photoImageView: UIImageView = {
//        let w = UIScreen.main.bounds.width
//        let h = UIScreen.main.bounds.height
//
//        let imgHeight = w - 100
//        let imgWidth  = w - 100
//        let imageView = UIImageView(frame: CGRect(x: (w / 2) - (imgWidth / 2)  , y: (h / 2) - (imgHeight / 2) , width: imgWidth, height: imgHeight))
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate var selectedIndex = -1

    
    fileprivate let data: [UIImage] = [
        UIImage(named: "frame-circle@4500x4500.png")!,
        UIImage(named: "frame-film.png")!,
        UIImage(named: "frame-flower@4500x4500")!,
        UIImage(named: "frame-lace@4500x4500")!,
        UIImage(named: "frame-wood@4500x4500")!
    ]
    
    
    fileprivate let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PhotoFrameCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoFrameCollectionViewCell")
        return cv
    }()
    
    fileprivate let saveButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Save Photo", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(saveButtonEvent), for: .touchUpInside)
        return btn
    }()
    
    @objc func saveButtonEvent(sender:UIButton!) {
        print("save..")
        guard let selectedImage = self.photoImageView.image else {
           print("Image not found!")
           return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self,#selector(image(_:didFinishSavingWithError:contextInfo:)) ,nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        view.addSubview(collectionView)
        collectionView.backgroundColor = .blue
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        //select first item by default.
//        let indexPath = self.collectionView.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
//        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
//        collectionView(self.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        if let image = targetPhoto {
            photoImageView.image = image
            self.view.addSubview(photoImageView)
            photoImageView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            photoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
            photoImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
            
            self.view.addSubview(saveButton)
            saveButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 24).isActive = true
            saveButton.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor).isActive = true
            saveButton.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor).isActive = true
            saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
          if let error = error {
            Tools.showAlertWith(vc:self,title: "Save error", message: error.localizedDescription)
          } else {
            Tools.showAlertWith(vc:self,title: "Saved!", message: "Photo has been saved.")
          }
    }
    
  
}

extension PhotoFramePickerViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoFrameCollectionViewCell", for: indexPath) as! PhotoFrameCollectionViewCell
        cell.backgroundColor = .black
        cell.data = self.data[indexPath.item]
       
        if selectedIndex == indexPath.row {
            cell.contentView.backgroundColor = .gray
        } else {
            cell.contentView.backgroundColor = .black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        selectedIndex = indexPath.row
        self.collectionView.reloadData()

        let watermarkImage = self.data[selectedIndex]
        UIGraphicsBeginImageContextWithOptions(targetPhoto!.size, false, 0.0)
        targetPhoto!.draw(in: CGRect(x: 0.0, y: 0.0, width: 1242, height: 1242))
        watermarkImage.draw(in: CGRect(x: 0.0, y: 0.0, width: 1242, height: 1242))

        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.photoImageView.image = result
        
    }
}

