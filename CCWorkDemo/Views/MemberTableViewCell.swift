

import UIKit

class MemberTableViewCell: UITableViewCell {
    var data: MemberDisplay? {
        didSet {
            guard let data = data else {return}
            titleLabel.text = data.title
            wordLabel.text = data.word
        }
    }
    
    fileprivate let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    fileprivate let wordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 2
       return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 8).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8).isActive = true
        
        contentView.addSubview(wordLabel)
        wordLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor,constant: 4).isActive = true
        wordLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor,constant: 8).isActive = true
        wordLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: 8).isActive = true
        wordLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8).isActive = true
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
