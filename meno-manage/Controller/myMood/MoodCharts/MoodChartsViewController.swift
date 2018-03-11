import UIKit
import Realm
import RealmSwift
import SwiftKeychainWrapper

class MoodChartsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let locationNames = ["Monthly Mood Overview", "Mood Count", "Average Daily Mood", "Activity Count", "Often Together"]
    

    let locationDescription = ["A count of all the moods in the month of ", "A count of all the moods tracked for the month of ", "Your average daily mood.", "An activity count for the month of ", "Moods which are often together. use this as insight to improve your mood"]
    
    let chartViews = ["monthlymoodocount","monthlymoodocount","monthlymoodocount","monthlymoodocount","monthlymoodocount"]
    
    
//    let chartViews = [UIView(ChartView), UIView(ChartView), UIView(ChartView), UIView(ChartView), UIView(ChartView)]
    
    
    
    override func viewDidLoad() {
        
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.ChartName.text = locationNames[indexPath.row]
        cell.ChartDescription.text = locationDescription[indexPath.row]
        
        
        
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        return cell
    }

}

