//
//  NoodleItemViewController.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit

class NoodleItemViewController: UIViewController {
    
    //MARK: - UI Outlets -
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - DUMMY Data (hey, that's not nice) -
    
    var items: [FoodItem] = {
        var item1 = FoodItem()
        item1.itemImageName = "pizza"
        item1.itemName = "Pizza"
        item1.noOfItems = "14 Items"
        
        var item2 = FoodItem()
        item2.itemImageName = "pasta"
        item2.itemName = "Pasta"
        item2.noOfItems = "19 Items"
        
        var item3 = FoodItem()
        item3.itemImageName = "salads"
        item3.itemName = "Salads"
        item3.noOfItems = "10 Items"
        
        var item4 = FoodItem()
        item4.itemImageName = "dessert"
        item4.itemName = "Dessert"
        item4.noOfItems = "19 Items"
        
        var item5 = FoodItem()
        item5.itemImageName = "drink"
        item5.itemName = "Drinks"
        item5.noOfItems = "20 Items"
        
        return [item1, item2, item3, item4, item5]
    }()
    
    //MARK: - Lifecycle and Overrides -
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// S'cute animations
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///TableView Customization
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

//MARK: - UItableview Datasource Delegate Methods
extension NoodleItemViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as? FoodItemTableViewCell else { return UITableViewCell() }
        
        cell.item = items[indexPath.row]
        cell.itemNameLabel.textAlignment = indexPath.row % 2 == 0 ? NSTextAlignment.left : NSTextAlignment.right
        cell.numberOfItemsLabel.textAlignment = indexPath.row % 2 == 0 ? NSTextAlignment.left : NSTextAlignment.right
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item:FoodItem?
        item = items[indexPath.row]
        if let imagName = item?.itemImageName {
            let currentImg = UIImage(named: imagName)
            let imageCrop = currentImg?.getCropRatio()
            let height:CGFloat = tableView.frame.width / imageCrop!
            print("Height : \(height)")
            return height
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item:FoodItem?
        item = items[indexPath.row]
        
        let subItemVC = self.storyboard?.instantiateViewController(withIdentifier: "SubItemVC") as! SubItemVC
        subItemVC.strSubItemTitle = item?.itemName
        self.navigationController?.pushViewController(subItemVC, animated: true)
    }
}
