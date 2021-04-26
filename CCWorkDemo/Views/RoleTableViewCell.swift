
import UIKit

class RoleTableViewCell: UITableViewCell {
    var data: Role? {
        didSet {
            guard let data = data else {return}
                
            idTextLabel.text = data.ID
            nameTextLabel.text = data.Name
            attackTextLabel.text = data.Attack
            defenseTextLabel.text = data.Defense
        }
    }
    
    fileprivate let idLabel: UILabel = {
       let label = UILabel()
        label.text = "ID"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    fileprivate let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "名稱"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    fileprivate let attackLabel: UILabel = {
       let label = UILabel()
        label.text = "攻擊力"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    fileprivate let defenseLabel: UILabel = {
       let label = UILabel()
        label.text = "防禦力"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    fileprivate let idTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    fileprivate let nameTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    fileprivate let attackTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    fileprivate let defenseTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //ID
        contentView.addSubview(idLabel)
        idLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8).isActive = true
        idLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 8).isActive = true
        idLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        contentView.addSubview(idTextLabel)
        idTextLabel.topAnchor.constraint(equalTo: idLabel.topAnchor,constant: 8).isActive = true
        idTextLabel.leftAnchor.constraint(equalTo: idLabel.rightAnchor,constant: 8).isActive = true
        idTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: 8).isActive = true
        idTextLabel.bottomAnchor.constraint(equalTo: idLabel.bottomAnchor).isActive = true
        
        //Name
        contentView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor,constant: 8).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: idLabel.leftAnchor,constant: 0).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        contentView.addSubview(nameTextLabel)
        nameTextLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor,constant: 8).isActive = true
        nameTextLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor,constant: 8).isActive = true
        nameTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: 8).isActive = true
        nameTextLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        //Attack
        contentView.addSubview(attackLabel)
        attackLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 8).isActive = true
        attackLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor,constant: 0).isActive = true
        attackLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        attackLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        contentView.addSubview(attackTextLabel)
        attackTextLabel.topAnchor.constraint(equalTo: attackLabel.topAnchor,constant: 8).isActive = true
        attackTextLabel.leftAnchor.constraint(equalTo: attackLabel.rightAnchor,constant: 8).isActive = true
        attackTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: 8).isActive = true
        attackTextLabel.bottomAnchor.constraint(equalTo: attackLabel.bottomAnchor).isActive = true
        
        
        //Defense
        contentView.addSubview(defenseLabel)
        defenseLabel.topAnchor.constraint(equalTo: attackLabel.bottomAnchor,constant: 8).isActive = true
        defenseLabel.leftAnchor.constraint(equalTo: attackLabel.leftAnchor,constant: 0).isActive = true
        defenseLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        defenseLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        contentView.addSubview(defenseTextLabel)
        defenseTextLabel.topAnchor.constraint(equalTo: defenseLabel.topAnchor,constant: 8).isActive = true
        defenseTextLabel.leftAnchor.constraint(equalTo: defenseLabel.rightAnchor,constant: 8).isActive = true
        defenseTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: 8).isActive = true
        defenseTextLabel.bottomAnchor.constraint(equalTo: defenseLabel.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
