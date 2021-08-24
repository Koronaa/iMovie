//
//  CharacterTableViewCell.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-24.
//

import UIKit

protocol CharacterTableViewCellDelegate {
    func characterOnTapped()
}

class CharacterTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    private var collectionView:UICollectionView!
    private var movieInfoVM:MovieInfoViewModel!
    private var delegate:CharacterTableViewCellDelegate!
    
    
    func setupCell(for movieInfoVM:MovieInfoViewModel,with delegate:CharacterTableViewCellDelegate){
        self.movieInfoVM = movieInfoVM
        self.delegate = delegate
        collectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70.0), collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isScrollEnabled = true
        collectionView.contentMode = .center
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.CharacterCollectionViewCell.rawValue)
        self.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfoVM.chaaracterEndPoints.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.Cell.CharacterCollectionViewCell.rawValue, for: indexPath) as! CharacterCollectionViewCell
        cell.setupUI()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieInfoVM.selectedCharacterEndpoint = movieInfoVM.chaaracterEndPoints[indexPath.row]
        Log("Tapped endpoint: \(movieInfoVM.selectedCharacterEndpoint)")
        delegate.characterOnTapped()
    }
}

