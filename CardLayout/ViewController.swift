//
//  ViewController.swift
//  CardLayout
//
//  Created by 陈凯 on 2017/3/2.
//  Copyright © 2017年 陈凯. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = CardLayout()
        layout.scale = 1.1
        layout.itemSize = CGSize(width: 200, height: 300)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath)
        cell.layer.cornerRadius = 5
        cell.backgroundColor = UIColor(white: 0.8, alpha: 1)//indexPath.item%2==0 ? UIColor(white: 0.8, alpha: 1) : UIColor(white: 0.6, alpha: 1)
        return cell
    }
    
}

