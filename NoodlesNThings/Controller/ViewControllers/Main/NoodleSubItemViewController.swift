//
//  NoodleSubItemViewController.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit

class NoodleSubItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var subItemCollectionView: UICollectionView!
    
    var strSubItemTitle: String?
    
    var subItems:[FoodSubItem] = {
        
        let subItem1 = FoodSubItem()
        subItem1.imageName = "pizza1"
        subItem1.name = "Supreme Special"
        subItem1.sizeLPrice = "$18.34"
        subItem1.sizeMPrice = "$14.60"
        
        let subItem2 = FoodSubItem()
        subItem2.imageName = "pizza2"
        subItem2.name = "Moonlight"
        subItem2.sizeLPrice = "$15.28"
        subItem2.sizeMPrice = "$12.56"
        
        let subItem3 = FoodSubItem()
        subItem3.imageName = "pizza3"
        subItem3.name = "Chicken Supreme"
        subItem3.sizeLPrice = "$17.23"
        subItem3.sizeMPrice = "$10.34"
        
        let subItem4 = FoodSubItem()
        subItem4.imageName = "pizza4"
        subItem4.name = "Veggie Delight"
        subItem4.sizeLPrice = "$10.29"
        subItem4.sizeMPrice = "$7.19"
        
        let subItem5 = FoodSubItem()
        subItem5.imageName = "pizza5"
        subItem5.name = "Chill Party"
        subItem5.sizeLPrice = "$17.23"
        subItem5.sizeMPrice = "$10.34"
        
        let subItem6 = FoodSubItem()
        subItem6.imageName = "pizza6"
        subItem6.name = "Ocean Hawaiian"
        subItem6.sizeLPrice = "$10.29"
        subItem6.sizeMPrice = "$7.19"
        
        return [subItem1, subItem2, subItem3, subItem4, subItem5, subItem6]
        
    }()
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
            self.restoreNavBarShadow()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        subItemCollectionView.contentInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        subItemCollectionView.addGestureRecognizer(gesture)
        
        setUpNavBar()
    }
    
    func setUpNavBar()  {
        navigationItem.title = strSubItemTitle

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(false, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 20.0)!]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 34.0)!]
        
        
        let imgBack = #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = imgBack
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBack
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        
    
    }
    
    func restoreNavBarShadow() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
   
    
    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colCellSubListing", for: indexPath) as! colCellSubItem
        cell.subItem = subItems[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailViewController
        self.navigationController?.pushViewController(itemDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width - 10 - 24)/2, height: 255.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

}
