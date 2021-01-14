//
//  ViewController.swift
//  Test
//
//  Created by Максим Соловьёв on 14.01.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "exit"), for: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 32.0)
        return label
    }()
    
    let pickButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать", for: .normal)
        button.tintColor = .white
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapPickButton), for: .touchUpInside)
        return button
    }()
    
    var collectionView: UICollectionView!
    var cellId = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCollectionView()
        setupInterface()
        setupConstraints()
    }
    
    @objc func didTapPickButton() {
        //ПРИ НАЖАТИИ ДОЛЖЕН ПОКАЗАТЬСЯ АЛЕРТ С НАЗВАНИЕМ ВЫБРАННОЙ УСЛУГИ
        print("ВЫБРАЛ")
    }
    
    private func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 300)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        self.view.addSubview(collectionView)
    }
    
    private func setupInterface() {
        let data = JSONFileParser().welcome
        titleLabel.text = data?.result.title
    }
    
    private func setupConstraints() {
        
        view.addSubview(exitButton)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(pickButton)
        
        [exitButton,
         titleLabel,
         collectionView,
         pickButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            exitButton.heightAnchor.constraint(equalToConstant: 50),
            exitButton.widthAnchor.constraint(equalToConstant: 50),
            exitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            pickButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            pickButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            pickButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            pickButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: pickButton.topAnchor, constant: -20)
        ])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = JSONFileParser().welcome?.result.list
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCollectionViewCell
        let data = JSONFileParser().welcome
        //cell.imageView.image = UIImage(named: (data!.result.list[indexPath.row].icon.the52X52))
        cell.titleLabel.text = data!.result.list[indexPath.row].title
        cell.descriptionLabel.text = data!.result.list[indexPath.row].listDescription
        cell.priceLabel.text = data!.result.list[indexPath.row].price
        cell.selectedImageView.isHidden = !data!.result.list[indexPath.row].isSelected
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 8, bottom: 5, right: 8)
    }
    
}
