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
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Тестовое описание. Здесь описывается услуга и её преимущества. К каждому объявлению своё небольшое описание"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 20
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 15.0)
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "299 ₽"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        setupConstraints()
    }
    
    @objc func didTapView() {
        //ОДНОВРЕМЕННО ДОЛЖЕН БЫТЬ ОТМЕЧЕН 1 ЭЛЕМЕНТ 
        if selectedImageView.isHidden == true {
            selectedImageView.isHidden = false
        } else {
            selectedImageView.isHidden = true
        }
        
    }
    
    private func setupConstraints() {
        
        contentView.addSubview(containerView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(selectedImageView)
        
        [containerView,
         imageView,
         titleLabel,
         descriptionLabel,
         priceLabel,
         selectedImageView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
        ])
        
        NSLayoutConstraint.activate([
            selectedImageView.heightAnchor.constraint(equalToConstant: 25),
            selectedImageView.widthAnchor.constraint(equalToConstant: 25),
            selectedImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            selectedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 50),
            priceLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -8),
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
