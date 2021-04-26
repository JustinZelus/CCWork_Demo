
import Foundation
import UIKit

class DataListViewController: UIViewController {
    
    var data = [Role]()
    var urls = ["http://demo.kidtech.com.tw/files/appexam/appexam1.htm",
               "http://demo.kidtech.com.tw/files/appexam/appexam2.htm"]
    
    fileprivate let tableView: UITableView = {
       let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 200
        table.register(RoleTableViewCell.self, forCellReuseIdentifier: "RoleTableViewCell")
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 16).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        concurrentCalls(urls:urls) {
            print("reload table")
            self.tableView.reloadData()
        }

    }

    func concurrentCalls(urls: [String],completion: @escaping ConcurrentTaskCompletion) {
        let dispatchGroup = DispatchGroup()
        for url in urls {
            dispatchGroup.enter()
            NetworkModule.get(url:url, completion: {success,data in
                DispatchQueue.main.async {
                    if !success {
                        
                    } else {
                        let decoder = JSONDecoder()
                        do {
                            let jsonStr = Tools.jsonToString(json: Tools.convertDictionary(target: data!))
                            let role = try decoder.decode(Role.self, from: Data(jsonStr!.utf8))
                            self.data.append(role)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    dispatchGroup.leave()
                }
            })
        }
        
        dispatchGroup.notify(queue: .main) {
            print("multiple task done")
            print(self.data)
            completion()
        }
    }
    
  
}

extension DataListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoleTableViewCell", for: indexPath) as! RoleTableViewCell
        cell.data = self.data[indexPath.section]
        cell.backgroundColor = .white
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
}
