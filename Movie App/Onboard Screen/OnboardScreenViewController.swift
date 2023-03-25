//
//  OnboardScreenViewController.swift
//  Movie App
//
//  Created by Muvi on 30/09/22.
//

import UIKit

class OnboardScreenViewController: UIViewController {

    
    //MARK: Slide
    var slide : [OnboardingSlide] = []
    @IBOutlet weak var onboardCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slide.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slide = [OnboardingSlide(title: "Inception", description: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.", image: "1.jpg"), OnboardingSlide(title: "Avengers: Endgame", description: "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe", image: "2.jpg"), OnboardingSlide(title: "Joker", description: "A mentally troubled stand-up comedian embarks on a downward spiral that leads to the creation of an iconic villain.", image: "3.jpg")]
        
        self.nextButton.layer.cornerRadius = 10
        self.nextButton.clipsToBounds = true
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == slide.count - 1 {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            present(mainViewController, animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
    }
}
extension OnboardScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slide.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onboardCollectionView.dequeueReusableCell(withReuseIdentifier: "onboardCell", for: indexPath) as! OnboardCollectionViewCell
        cell.setupSlide(slide[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: onboardCollectionView.frame.width, height: onboardCollectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
    }
}
