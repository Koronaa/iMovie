//
//  ViewController.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import UIKit
import RxCocoa
import RxSwift
import SkeletonView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    fileprivate let homeVM = HomeViewModel()
    fileprivate let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTableView()
        setupObservables()
        setupSkeleton()
    }
    
    private func setupUI(){
        UIHelper.hide(navigationController: self.navigationController)
    }
    
    private func setupTableView(){
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: .main), forCellReuseIdentifier: UIConstants.Cell.MovieTableViewCell.rawValue)
        tableView.isSkeletonable = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupObservables(){
        homeVM.movies.subscribe(onNext: { movies in
            if movies != nil{
                self.tableView.hideSkeleton()
                self.tableView.stopSkeletonAnimation()
                self.tableView.reloadData()
            }
        }).disposed(by: bag)
        
        homeVM.error.subscribe(onNext: { error in
            if let e = error{
                UIHelper.showBanner(for: e)
            }
        }).disposed(by: bag)
    }
    
    private func getMovies(){
        homeVM.getMovies()
    }
    
    private func setupSkeleton(){
        let gradient = SkeletonGradient(baseColor: UIColor.systemGray6)
        tableView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: nil, transition: .crossDissolve(0.3))
        tableView.startSkeletonAnimation()
    }
    
    
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.movies.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let movieInfo = homeVM.movies.value?[indexPath.row]{
            let movieCollectionVM = MovieTableViewCellViewModel(movie: movieInfo)
            let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.MovieTableViewCell.rawValue, for: indexPath) as! MovieTableViewCell
            cell.movieInfo = movieCollectionVM
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 296.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieInfo = homeVM.movies.value?[indexPath.row]{
            let movieInfoVM = MovieInfoViewModel(movie: movieInfo)
            let movieInfoVC = UIHelper.makeViewController(viewControllerName: .MovieInfoVC) as! MovieInfoViewController
            movieInfoVC.movieInfoVM = movieInfoVM
            self.navigationController?.pushViewController(movieInfoVC, animated: true)
        }
    }
    
    //MARK: Skeleton View
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return UIConstants.Cell.MovieTableViewCell.rawValue
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    
}

