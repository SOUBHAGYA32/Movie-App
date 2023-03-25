//
//  HomeViewController.swift
//  Movie App
//
//  Created by Muvi on 26/09/22.
//

import UIKit
import SDWebImage
class HomeViewController: UIViewController {
    //MARK: Banner Array
    let bannerArray = ["https://m.media-amazon.com/images/S/sonata-images-prod/PV_IN_PawPatrol_Launch/d95d85e7-2c5f-4e13-aa7d-27f5c980fad7._UR3000,600_SX3000_FMwebp_.jpeg", "https://m.media-amazon.com/images/S/sonata-images-prod/PV_IN_ShershaahLaunchwithNewposter/54c9bffa-e10e-4320-8d0d-23cef44b797d._UR3000,600_SX3000_FMwebp_.jpeg", "https://m.media-amazon.com/images/S/sonata-images-prod/PV_IN_CROW_UN_TheUnbearableWeight_LP/1031f13a-8269-4918-887b-40be781fa9f5._UR3000,600_SX3000_FMwebp_.jpeg", "https://m.media-amazon.com/images/S/sonata-images-prod/PV_IN_Runway34_Launch/f5d62171-c4c6-49bb-98d5-efe15d6db49b._UR3000,600_SX3000_FMwebp_.jpeg"]
    
    //MARK: API Results
    var apiResults : [MovieData] = []

    //MARK:
    var movieModel : [ApiResponse] = []
    
    //MARK: IBoutlet for Collection View and Table View
    @IBOutlet weak var myTable: UITableView!
    //MARK: IBOutlet For Banner
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTable.delegate = self
        self.myTable.dataSource = self
        self.setNavigationBarImage()
        self.getData()
        self.getPopularMovies()
        self.getTodayArivingMovies()
    }
    
    //MARK: API CALL
    //MARK: Feature Section Data
    func getData() {
        let urlString = "https://api.themoviedb.org/3/tv/top_rated?api_key=babf838380288ebe26ed74b72d96a9f9"
             
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            guard let data = data else { return }
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                guard let apiResults = apiResponse.results else { return }
                self.apiResults = apiResults
                self.movieModel.append(ApiResponse(sectionName: "Featured Section", results: apiResults))
                DispatchQueue.main.async {
                    self.myTable.reloadData()
                }
                print(self.movieModel[0].sectionName ?? "")
            } catch {
                print("")
            }
        }
        task.resume()
    }
    
    
    //MARK: Popular Movies
    func getPopularMovies() {
        let popularUrlString = "https://api.themoviedb.org/3/tv/popular?api_key=babf838380288ebe26ed74b72d96a9f9"
        guard let url = URL(string: popularUrlString) else { return }
        var urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            guard let data = data else { return }
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                guard let apiResults = apiResponse.results else { return }
                self.apiResults = apiResults
                self.movieModel.append(ApiResponse(sectionName: "Popular Movies", results: apiResults))
                DispatchQueue.main.async {
                    self.myTable.reloadData()
                }
            } catch {
                print("")
            }
        }
        task.resume()
    }
    
    //MARK: Ariving Today
    func getTodayArivingMovies() {
        let todayUrlString = "https://api.themoviedb.org/3/tv/airing_today?api_key=babf838380288ebe26ed74b72d96a9f9"
        guard let url = URL(string: todayUrlString) else { return }
        var urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            guard let data = data else { return }
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                guard let apiResults = apiResponse.results else { return }
                self.apiResults = apiResults
                self.movieModel.append(ApiResponse(sectionName: "Ariving Today Movies", results: apiResults))
                DispatchQueue.main.async {
                    self.myTable.reloadData()
                }
            } catch {
                print("")
            }
        }
        task.resume()
    }
    //MARK: Netflix Logo
    func setNavigationBarImage() {
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    
}

    //MARK: Extension for Table View
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieModel.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeTableCell = tableView.dequeueReusableCell(withIdentifier: "homeTable", for: indexPath) as! HomeTableViewCell
        
        homeTableCell.vc = self
        homeTableCell.setData(data: self.movieModel[indexPath.section].results!)
        return homeTableCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: 30.0))
        let textLabel = UILabel(frame: CGRect(x: 5.0, y: 5.0, width: self.view.bounds.width, height: 20.0))
        textLabel.text = "\(movieModel[section].sectionName as! String)"
        textLabel.textColor = .white
        headerView.addSubview(textLabel)
        headerView.backgroundColor = .black
        return headerView
    }
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "carsoulCell", for: indexPath) as! MoviesBannerCollectionViewCell
        //MARK: Load Banner image from URL
        if let url = URL(string: "\(bannerArray[indexPath.row])"){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    cell.bannerImage.image = UIImage(data: data)
                    cell.bannerImage.contentMode = .scaleAspectFill
                    cell.bannerImage.clipsToBounds = true
                }
            }
            task.resume()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collcetionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bannerCollectionView.frame.width, height: bannerCollectionView.frame.height)
    }
}
