//
//  CharacterInfoViewController.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-28.
//

import UIKit
import RxCocoa
import RxSwift
import SkeletonView

class CharacterInfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    fileprivate let bag = DisposeBag()
    
    var characterInfoVM:CharacterInfoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getCharacterInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setObservables()
        setupSkeleton()
    }
    
    private func setupUI(){
        imageView.image = UIImage(named: "character")
        UIHelper.circular(view: imageView)
    }
    
    private func getCharacterInfo(){
        characterInfoVM.getCharacterInfo {
            self.stopSkeleton()
        }
    }
    
    private func setupSkeleton(){
        let gradient = SkeletonGradient(baseColor: UIColor.systemGray6)
        nameLabel.showAnimatedGradientSkeleton(usingGradient: gradient, animation: nil, transition: .crossDissolve(0.3))
        birthYearLabel.showAnimatedGradientSkeleton(usingGradient: gradient, animation: nil, transition: .crossDissolve(0.3))
        genderLabel.showAnimatedGradientSkeleton(usingGradient: gradient, animation: nil, transition: .crossDissolve(0.3))
        nameLabel.startSkeletonAnimation()
        birthYearLabel.startSkeletonAnimation()
        genderLabel.startSkeletonAnimation()
    }
    
    private func stopSkeleton(){
        nameLabel.hideSkeleton()
        nameLabel.stopSkeletonAnimation()
        birthYearLabel.hideSkeleton()
        birthYearLabel.stopSkeletonAnimation()
        genderLabel.hideSkeleton()
        genderLabel.stopSkeletonAnimation()
    }
    
    private func setObservables(){
        characterInfoVM.name.asObservable()
            .map{$0}.bind(to: nameLabel.rx.text).disposed(by: bag)
        characterInfoVM.birthYear.asObservable()
            .map{$0}.bind(to: birthYearLabel.rx.text).disposed(by: bag)
        characterInfoVM.gender.asObservable()
            .map{$0}.bind(to: genderLabel.rx.text).disposed(by: bag)
        characterInfoVM.error.asObservable().subscribe(onNext: { error in
            UIHelper.showBanner(for: error!)
        }).disposed(by: bag)
    }
    
    @IBAction func backButtonOnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
