
import Foundation
import UIKit

class MemberViewController: UIViewController {
    var data: Member?
    var dataDisplay = [MemberDisplay]()
    
    fileprivate let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let tableView: UITableView = {
       let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight =  UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.register(MemberTableViewCell.self, forCellReuseIdentifier: "MemberTableViewCell")
        table.separatorStyle = .none
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
       // print("Member info: \(data)")
        
        do {
            if let dict = try data?.allProperties() {
                for (key,value) in dict {
                    if key != "Photo" {
                        dataDisplay.append(MemberDisplay(title: key, word: value as! String))
                    }
                }
            }
        }catch _ {
            
        }
        
        photoView.downloaded(from: data!.Photo)
        view.addSubview(photoView)
        photoView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 16).isActive = true
        photoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        photoView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 16).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension MemberViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell", for: indexPath) as! MemberTableViewCell
        cell.data = self.dataDisplay[indexPath.row]

        return cell
    }
}
