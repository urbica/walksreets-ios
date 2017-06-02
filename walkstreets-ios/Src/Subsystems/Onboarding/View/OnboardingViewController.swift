//
//  OnboardingOnboardingViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 28/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, OnboardingViewInput {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var output: OnboardingViewOutput!
    var pageNumber: Int = 0


    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        OnboardingModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: OnboardingViewInput
    func setupInitialState() {
        setupSwipe()
    }
    
    
    func setupSwipe() {
        let backSwipe = UISwipeGestureRecognizer(target: self, action: #selector(backSwipe(swipe:)))
        backSwipe.direction = .right
        self.view.addGestureRecognizer(backSwipe)
        
        let nextSwipe = UISwipeGestureRecognizer(target: self, action: #selector(nextSwipe(swipe:)))
        nextSwipe.direction = .left
        self.view.addGestureRecognizer(nextSwipe)
    }
    
    func backSwipe(swipe: UIGestureRecognizer) {
        updatePageNumber(number: -1)
    }
    
    func nextSwipe(swipe: UIGestureRecognizer) {
        updatePageNumber(number: 1)
    }
    
    func updatePageNumber(number: Int = 0) {
        
        if number != 0 {
            pageNumber += number
        }
        
        if pageNumber < 0 {
            return
        } else if pageNumber > 4 {
            output.proceedToStart()
            return
        }
        
        collectionView.scrollToItem(at: IndexPath(item: pageNumber, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func goToStart() {
        performSegue(withIdentifier: "toStartScreen", sender: nil)
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as! OnboardingCell
        
        if let image = output.onboardingImages?[indexPath.row] {
            cell.setupImageView(image: image)
        }
        
        if indexPath.row == 4 {
            cell.showContinue()
        }
        
        return cell
        
    }
    
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}
