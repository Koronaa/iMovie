//
//  MovieInfoViewController.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import UIKit
import Kingfisher

class MovieInfoViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var movieInfoVM: MovieInfoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI(){
        movieImageView.kf.setImage(with: movieInfoVM.posterURL)
        UIHelper.roundCorners(view: contentView, corners: [.topLeft,.topRight], radius: 15.0)
    }
    
    private func setupTableView(){
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: .main), forCellReuseIdentifier: UIConstants.Cell.TitleTableViewCell.rawValue)
        tableView.register(UINib(nibName: "ContentTableViewCell", bundle: .main), forCellReuseIdentifier: UIConstants.Cell.ContentTableViewCell.rawValue)
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
    @IBAction func backButtonOnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension MovieInfoViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieInfoVM.headerTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.TitleTableViewCell.rawValue) as! TitleTableViewCell
            cell.setContent(title: movieInfoVM.title, subTitle: movieInfoVM.releasedYear)
            return cell
        case 1,2,3,4:
            let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.ContentTableViewCell.rawValue) as! ContentTableViewCell
            cell.setContent(for: setContent(for: section))
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
            cell.setupCell(for: self.movieInfoVM, with: self)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func setContent(for section:Int) -> String{
        switch section {
        case 1:
            return movieInfoVM.description
        case 2:
            return movieInfoVM.directorName
        case 3:
            return movieInfoVM.producerInfo
        case 4:
            return movieInfoVM.releasedDate
        default:
            return "N/A"
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return movieInfoVM.headerTitles[section]
    }
    
    
}

extension MovieInfoViewController:CharacterTableViewCellDelegate{
    
    func characterOnTapped() {
        let characterInfoVC = UIHelper.makeViewController(viewControllerName: .CharacterInfoVC) as! CharacterInfoViewController
        characterInfoVC.characterInfoVM = CharacterInfoViewModel(selectedEndpoint: URL(string: movieInfoVM.selectedCharacterEndpoint!)!)
        self.navigationController?.pushViewController(characterInfoVC, animated: true)
    }
}


