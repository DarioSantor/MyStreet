//
//  CustomOcurrencetableViewCellTableViewCell.swift
//  MyStreet
//
//  Created by Correia, Jose Bastos on 20/03/2023.
//

import UIKit

class CustomOcurrencetableViewCellTableViewCell: UITableViewCell {

    static let identifier = "CustomOcurrencetableViewCellTableViewCell"
    
    private let topView = UIView()
    private let bottomView = UIView()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondarySystemBackground
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topView.layer.cornerRadius = 14
        topView.backgroundColor = .gray
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bottomView.layer.cornerRadius = 14
        bottomView.backgroundColor = .secondarySystemBackground
        
        
        addSubview(topView)
        addSubview(bottomView)
        topView.addSubview(descriptionLabel)
        bottomView.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            topView.widthAnchor.constraint(equalToConstant: 320),
            topView.centerXAnchor.constraint(equalTo: centerXAnchor),
            topView.bottomAnchor.constraint(equalTo: centerYAnchor),
            
            bottomView.topAnchor.constraint(equalTo: centerYAnchor),
            bottomView.widthAnchor.constraint(equalToConstant: 320),
            bottomView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 12),
            descriptionLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            locationLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 12),
            locationLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        

    }
    
    func configure(occurence: Occurrence) {
        descriptionLabel.text = occurence.description
        locationLabel.text = occurence.location
    }
}
