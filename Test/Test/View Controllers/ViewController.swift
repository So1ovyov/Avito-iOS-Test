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
        label.font = UIFont.boldSystemFont(ofSize: 28.0)
        return label
    }()
    
    let pickButton: UIButton = {
        let button = UIButton()
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
    
    private let jsonFileParser = JSONFileParser()
    private var data: Welcome!
    private var selectedItem: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        data = jsonFileParser.parse(fileName: "result")!
        
        setupCollectionView()
        setupInterface()
        setupConstraints()
        
        DispatchQueue.main.async {
            if let selectedIndex = self.data.result.list.firstIndex(where: { $0.isSelected }) {
                self.selectedItem = self.data.result.list[selectedIndex]
                self.collectionView.selectItem(at: IndexPath(row: selectedIndex, section: 0),
                                               animated: true,
                                               scrollPosition: .centeredHorizontally)
            }
        }
    }
    
    @objc func didTapPickButton() {
        if pickButton.titleLabel?.text == self.data.result.selectedActionTitle {
            let alertVC = UIAlertController(title: nil, message: "Выбрана услуга: \(selectedItem!.title)", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
            alertVC.addAction(cancelAction)
            present(alertVC, animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: nil, message: "Выберите услугу", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
            alertVC.addAction(cancelAction)
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    private func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.estimatedItemSize = .init(width: UIScreen.main.bounds.width - 30, height: 200)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        self.view.addSubview(collectionView)
    }
    
    private func setupInterface() {
        titleLabel.text = data?.result.title
        pickButton.setTitle(data.result.selectedActionTitle, for: .normal)
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
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.widthAnchor.constraint(equalToConstant: 30),
            exitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 8)
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
        let items = data.result.list
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCollectionViewCell
        let item = data.result.list[indexPath.row]
        
        do {
            let url = item.icon.the52X52
            let data = try Data.init(contentsOf: URL.init(string: url)!)
            let img = UIImage.init(data: data)
            DispatchQueue.main.async {
                cell.imageView.image = img
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.listDescription
        cell.priceLabel.text = item.price
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 5, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedItem = data.result.list[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCollectionViewCell
        if cell.isSelected == true {
            collectionView.deselectItem(at: indexPath, animated: true)
            self.pickButton.setTitle(self.data.result.actionTitle, for: .normal)
            return false
        }
        self.pickButton.setTitle(self.data.result.selectedActionTitle, for: .normal)
        return true
    }
    
}
