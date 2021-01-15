//
//  CustomCollectionViewCell.swift
//  Test
//
//  Created by Максим Соловьёв on 14.01.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        return view
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "test")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.frame.height / 2
        return image
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "XL-объявление"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Тестовое описание. Здесь описывается услуга и её преимущества. К каждому объявлению своё небольшое описание"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 10
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 13.0)
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "299 ₽"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    var selectedImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "done")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.frame.height / 2
        image.isHidden = true
        return image
    }()
    
    override var isSelected: Bool {
        didSet {
            selectedImageView.isHidden = !isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 5
        
        setupConstraints()
    }
        
    private func setupConstraints() {
        
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(selectedImageView)
        
        [containerView,
         imageView,
         titleLabel,
         descriptionLabel,
         priceLabel,
         selectedImageView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 52),
            imageView.widthAnchor.constraint(equalToConstant: 52),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            selectedImageView.heightAnchor.constraint(equalToConstant: 20),
            selectedImageView.widthAnchor.constraint(equalToConstant: 20),
            selectedImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            selectedImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -36),
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
