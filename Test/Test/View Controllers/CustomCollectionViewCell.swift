//
//  CustomCollectionViewCell.swift
//  Test
//
//  Created by Максим Соловьёв on 14.01.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "test")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.frame.height / 2
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "XL-объявление"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 28.0)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Тестовое описание. Здесь описывается услуга и её преимущества. К каждому объявлению своё небольшое описание"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 20
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 15.0)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "299 ₽"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    let selectedImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "done")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.frame.height / 2
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        addSubview(image)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(selectedImageView)
        
        [image,
         titleLabel,
         descriptionLabel,
         priceLabel,
         selectedImageView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 80),
            image.widthAnchor.constraint(equalToConstant: 80),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        ])
        
        NSLayoutConstraint.activate([
            selectedImageView.heightAnchor.constraint(equalToConstant: 25),
            selectedImageView.widthAnchor.constraint(equalToConstant: 25),
            selectedImageView.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            selectedImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 50),
            priceLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
