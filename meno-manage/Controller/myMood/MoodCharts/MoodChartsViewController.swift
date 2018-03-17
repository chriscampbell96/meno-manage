import UIKit
import Realm
import RealmSwift
import Charts
import ChartsRealm
import EPCalendarPicker


class MoodChartsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, EPCalendarPickerDelegate {
    
    @IBOutlet weak var mainCollection: UICollectionView!
    
    @IBOutlet weak var changeDate: UIBarButtonItem!
    
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
    let locationNames = ["Log New Mood Now!", "All Time Mood Count", "Daily Mood Count", "Daily Average", "Often Together", "Activity Vs. Mood"]
    let locationDescription = ["How are you feeling today?","Your average daily mood for each day of the week.", "A count of every mood since they day yo first logged.", "A count of all the moods in the month of", "Find out which activities are assosiated with your moods!", "This is a test"]

    
    let months = ["Great", "Good", "Meh", "Sad", "Awful"]

    
    let months1 = ["Great", "Good", "Meh", "Sad", "Awful"]


    var moodList: [String]!
    var getMoodList: [Double]!
    var changed: String!
    
    var weekList: [String]!
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
        print(changed)

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
        
        weekList = ["S", "M", "T", "W", "T", "F", "S" ]
    }
    
    //get moods
    func getGreatMood() -> Double{
        let greatMood = realm.objects(Mood.self).filter("mood = 'Great'")
        return Double(greatMood.count)
    }
    func getGoodMood() -> Double{
        let goodMood = realm.objects(Mood.self).filter("mood = 'Good'")
        return Double(goodMood.count)
    }
    func getMehMood() -> Double{
        let mehMood = realm.objects(Mood.self).filter("mood = 'Meh'")
        return Double(mehMood.count)
    }
    func getSadMood() -> Double{
        let sadMood = realm.objects(Mood.self).filter("mood = 'Sad'")
        return Double(sadMood.count)
    }
    func getAwfulMood() -> Double{
        let awfulMood = realm.objects(Mood.self).filter("mood = 'Awful'")
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
        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
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
        if indexPath.row == 1 {
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
        if indexPath.row == 2 {
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
//        if indexPath.row == 3 {
//            let cell4 = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyOverview", for: indexPath) as! DailyAverageCollectionViewCell
////            
////            cell4.ChartName.text = locationNames[indexPath.row]
////            cell4.ChartDescription.text = locationDescription[indexPath.row]
////            cell4.AfternoonLabel.text = "Meh"
////            cell4.MorningLabel.text = "Sad"
////            cell4.EveningLabel.text = "Good"
//            
//            
//            cell4.contentView.layer.cornerRadius = 4.0
//            cell4.contentView.layer.borderWidth = 1.0
//            cell4.contentView.layer.borderColor = UIColor.clear.cgColor
//            cell4.contentView.layer.masksToBounds = false
//            cell4.layer.shadowColor = UIColor.gray.cgColor
//            cell4.layer.shadowOffset = CGSize(width: 0, height: 1.0)
//            cell4.layer.shadowRadius = 4.0
//            cell4.layer.shadowOpacity = 1.0
//            cell4.layer.masksToBounds = false
//            cell4.layer.shadowPath = UIBezierPath(roundedRect: cell4.bounds, cornerRadius: cell4.contentView.layer.cornerRadius).cgPath
//            
//            return cell4
//        }

        
        return UICollectionViewCell()

    }
    
    
    
    @IBAction func changeDate(_ sender: AnyObject) {
        let calendarPicker = EPCalendarPicker(startYear: 2017, endYear: 2018, multiSelection: false, selectedDates: [])
        calendarPicker.calendarDelegate = self
        calendarPicker.startDate = Date()
        calendarPicker.hightlightsToday = true
        calendarPicker.showsTodaysButton = true
        calendarPicker.hideDaysFromOtherMonth = false
        calendarPicker.tintColor = UIColor.orange
        //        calendarPicker.barTintColor = UIColor.greenColor()
        calendarPicker.dayDisabledTintColor = UIColor.gray
        calendarPicker.title = "Filter Charts By Date"
        
        let navigationController = UINavigationController(rootViewController: calendarPicker)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func epCalendarPicker(_: EPCalendarPicker, didCancel error : NSError) {
        print("User cancelled selection")
        
    }
    func epCalendarPicker(_: EPCalendarPicker, didSelectDate date : Date) {
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.timeStyle = DateFormatter.Style.none
        let changed = dateformatter.string(from: date as Date)

        print(changed)
        
    
    }
    func epCalendarPicker(_: EPCalendarPicker, didSelectMultipleDate dates : [Date]) {
        print("User selected dates: \n\(dates)")
    }
    

}

