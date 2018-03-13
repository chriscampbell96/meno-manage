import UIKit
import Realm
import RealmSwift
import Charts
import ChartsRealm


class MoodChartsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var mainCollection: UICollectionView!
    
    
    func getDayOfWeek(today:String)->Int {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
    }
    

    
    
    
    //chart 1
    let locationNames = ["Log New Mood Now!", "Average Daily Mood", "Total Mood Count", "Monthly Mood Count"]
    let locationDescription = ["How are you feeling today?","Your average daily mood for each day of the week.", "A count of every mood since they day yo first logged.", "A count of all the moods in the month of "]

    
    let months = ["Great", "Good", "Meh", "Sad", "Awful"]
    let unitsSold = [1.0, 2.0, 3.0, 4.0, 5.0] as! [Double]
    
    let months1 = ["Great", "Good", "Meh", "Sad", "Awful"]
    let unitsSold1 = [2.0, 7.0, 3.0, 1.0, 8.0] as! [Double]

    var moodList: [String]!
    var getMoodList: [Double]!
    //global v's
    var moods: Results<Mood>!
    var realm = try! Realm()
    
    //init variables...
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let great = getGreatMood()
        let good = getGoodMood()
        let meh = getMehMood()
        let sad = getSadMood()
        let awful = getAwfulMood()
        
        moodList = ["Great", "Good", "Meh", "Sad", "Awful"]
        getMoodList = [great, good, meh, sad, awful]

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mainCollection.reloadData()
        
        let great = getGreatMood()
        let good = getGoodMood()
        let meh = getMehMood()
        let sad = getSadMood()
        let awful = getAwfulMood()
        
        moodList = ["Great", "Good", "Meh", "Sad", "Awful"]
        getMoodList = [great, good, meh, sad, awful]
    }
    
    //get moods
    func getGreatMood() -> Double{
        let greatMood = realm.objects(Mood.self).filter("mood = 'great'")
        print(greatMood.count)
        return Double(greatMood.count)
    }
    func getGoodMood() -> Double{
        let goodMood = realm.objects(Mood.self).filter("mood = 'good'")
        print(goodMood.count)
        return Double(goodMood.count)
    }
    func getMehMood() -> Double{
        let mehMood = realm.objects(Mood.self).filter("mood = 'meh'")
        print(mehMood.count)
        return Double(mehMood.count)
    }
    func getSadMood() -> Double{
        let sadMood = realm.objects(Mood.self).filter("mood = 'sad'")
        print(sadMood.count)
        return Double(sadMood.count)
    }
    func getAwfulMood() -> Double{
        let awfulMood = realm.objects(Mood.self).filter("mood = 'awful'")
        print(awfulMood.count)
        return Double(awfulMood.count)
    }
    
    func getAverage(){
//        let greatMood = realm.objects(Mood.self).filter("mood = 'great'")
//        let goodMood = realm.objects(Mood.self).filter("mood = 'good'")
//        let mehMood = realm.objects(Mood.self).filter("mood = 'meh'")
//        let sadMood = realm.objects(Mood.self).filter("mood = 'sad'")
//        let awfulMood = realm.objects(Mood.self).filter("mood = 'awful'")

    }
    
    func getActivityCount(){
        
    }
    
    func getOftenTogether(){
        
    }
    
    func getDailyMood(){
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var cell: UICollectionViewCell?
        
        if indexPath.row == 0 {
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as! TopCellCollectionViewCell
            
            topCell.topAsk.text = locationNames[indexPath.row]
            topCell.topDesc.text = locationDescription[indexPath.row]
            
            //This creates the shadows and modifies the cards a little bit
            topCell.contentView.layer.cornerRadius = 4.0
            topCell.contentView.layer.borderWidth = 1.0
            topCell.contentView.layer.borderColor = UIColor.clear.cgColor
            topCell.contentView.layer.masksToBounds = false
            topCell.layer.shadowColor = UIColor.gray.cgColor
            topCell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            topCell.layer.shadowRadius = 4.0
            topCell.layer.shadowOpacity = 1.0
            topCell.layer.masksToBounds = false
            topCell.layer.shadowPath = UIBezierPath(roundedRect: topCell.bounds, cornerRadius: topCell.contentView.layer.cornerRadius).cgPath
            
            
            return topCell
        }
        
        if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            
            cell.ChartName.text = locationNames[indexPath.row]
            cell.ChartDescription.text = locationDescription[indexPath.row]
            cell.configure(dataPoints: moodList, values: getMoodList)
            
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
        if indexPath.row == 2 {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell
            
            cell2.ChartName.text = locationNames[indexPath.row]
            cell2.ChartDescription.text = locationDescription[indexPath.row]
            cell2.configure(dataPoints: moodList, values: getMoodList)
            
            cell2.contentView.layer.cornerRadius = 4.0
            cell2.contentView.layer.borderWidth = 1.0
            cell2.contentView.layer.borderColor = UIColor.clear.cgColor
            cell2.contentView.layer.masksToBounds = false
            cell2.layer.shadowColor = UIColor.gray.cgColor
            cell2.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            cell2.layer.shadowRadius = 4.0
            cell2.layer.shadowOpacity = 1.0
            cell2.layer.masksToBounds = false
            cell2.layer.shadowPath = UIBezierPath(roundedRect: cell2.bounds, cornerRadius: cell2.contentView.layer.cornerRadius).cgPath
            
            return cell2
        }
        if indexPath.row == 3 {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! SecondCollectionViewCell
            
            cell3.NewDesc.text = locationNames[indexPath.row]
            cell3.NewLabel.text = locationDescription[indexPath.row]
            cell3.configure(dataPoints: moodList, values: getMoodList)
            
            cell3.contentView.layer.cornerRadius = 4.0
            cell3.contentView.layer.borderWidth = 1.0
            cell3.contentView.layer.borderColor = UIColor.clear.cgColor
            cell3.contentView.layer.masksToBounds = false
            cell3.layer.shadowColor = UIColor.gray.cgColor
            cell3.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            cell3.layer.shadowRadius = 4.0
            cell3.layer.shadowOpacity = 1.0
            cell3.layer.masksToBounds = false
            cell3.layer.shadowPath = UIBezierPath(roundedRect: cell3.bounds, cornerRadius: cell3.contentView.layer.cornerRadius).cgPath
            
            return cell3
        }

        
        return UICollectionViewCell()

    }
    

}

