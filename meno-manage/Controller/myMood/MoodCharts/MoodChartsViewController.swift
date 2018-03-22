import UIKit
import Realm
import RealmSwift
import Charts
import ChartsRealm
import EPCalendarPicker


class MoodChartsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, EPCalendarPickerDelegate, UITableViewDataSource, UITableViewDelegate {

    
    
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
    let locationNames = ["Total Mood Count", "Monthly Mood Count", "Activity Count", "Average Daily Mood", "Often Together", "Moods + Activities"]
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
    

    let sections: [String] = ["Mood Overview", "Symptom Count", "Great", "Good", "Meh", "Sad", "Awful"]
    
    
    let s1Data: [String] = ["Row 3", "Row 3", "Row 3"]
    let s2Data: [String] = ["Irregular period", "Vaginal dryness", "Hot flashes", "Chills", "Night sweats", "Poor sleep", "Loss of libido", "Dry skin", "Thinning of hair", "Loss of breast fullness"]
    let s3Data: [String] = ["🗓 Today", "🗓 7 Days", "🗓 30 Days", "📊 All Time Average", "🔥 Best Streak" , "📈 Total Sessions Logged"]
    
            let newData: [String] = ["Work","Friends", "Relax", "Date", "Sports", "Shopping", "Gaming", "Reading", "Relaxing", "Travelling", "Cleaning", "Cooking", "Other"]
    
                let newData2: [String] = ["0","0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
    
    var sectionData: [Int: [String]] = [:]
    
    let sections2: [String] = ["Often Together", "Symptom Count", "Mood Overview"]

    var sectionData2: [Int: [String]] = [:]
    
    
    var statlabels: [String]!
    var stats: [String]!
    
    //init variables...
    override func viewDidLoad() {
        super.viewDidLoad()
        let great = getGreatMood()
        let good = getGoodMood()
        let meh = getMehMood()
        let sad = getSadMood()
        let awful = getAwfulMood()
        
        let totalMoods = getTotalSessions()
        let allTimeAverage = getAverage()
        getCurrentWeek()
        let s1Data2: [String] = ["Row 3", "Row 3", "Row 3"]
        let s2Data2: [String] = ["0", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
        let s3Data2: [String] = ["sec", "coming soon", "coming soon", allTimeAverage, "coming soon",  totalMoods]


        sectionData = [0:s3Data, 1:s2Data, 2:newData, 3:newData, 4:newData,5:newData,6:newData]
        sectionData2 = [0:s3Data2, 1:s2Data2, 2:newData2, 3:newData2, 4:newData2,5:newData2,6:newData2 ]


        moodList = ["Great", "Good", "Meh", "Sad", "Awful"]
        getMoodList = [great, good, meh, sad, awful]
        
        statlabels = ["🗓 Today", "🗓 7 Days", "🗓 30 Days", "📊 All Time Average", "🔥 Best Streak" , "📈 Total Sessions Logged"]
        stats = ["sec", "coming soon", "coming soon", allTimeAverage, "coming soon",  totalMoods]
        



    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mainCollection.reloadData()
        
        
        let totalMoods = getTotalSessions()
                getCurrentWeek()
        let allTimeAverage = getAverage()

        let great = getGreatMood()
        let good = getGoodMood()
        let meh = getMehMood()
        let sad = getSadMood()
        let awful = getAwfulMood()
        
        moodList = ["Great", "Good", "Meh", "Sad", "Awful"]
        getMoodList = [great, good, meh, sad, awful]
        
        weekList = ["S", "M", "T", "W", "T", "F", "S" ]
        
        statlabels = ["🗓 Today", "🗓 7 Days", "🗓 30 Days", "📊 All Time", "🔥 Best Streak" , "📈 Total Sessions Logged"]
        stats = ["sec", "coming soon", "coming soon", allTimeAverage, "coming soon",  totalMoods]

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
    
    func getAverage() -> String{
        let good = getGoodMood()
        let great = getGreatMood()
        let meh = getMehMood()
        let sad = getSadMood()
        let awful = getAwfulMood()
        
        if great > good && great > meh && great > sad  && great > awful{
            return "great"
        }else if good > great && good > meh && good > sad  && good > awful{
            return "good"
        }else if meh > great && meh > good && meh > sad  && meh > awful{
            return "meh"
        }else if sad > great && sad > good && sad > meh && sad > awful{
            return "sad"
        }else if awful > great && awful > good && awful > meh && awful > sad{
            return "awful"
        }
        return "error"
    }
    
    func getActivityCount(){
        
    }
    
    func getOftenTogether(){
        
    }
    
    func getDailyMood(){
        
    }
    
    
    
    func getMoodToday(){
        
    }
    
    func getTotalSessions() -> String{
        let allTime = realm.objects(Mood.self)
        let allSessions = allTime.count
        return String(allSessions)
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

        
        return UICollectionViewCell()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return (sectionData[section]?.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
     -> String? {
     return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "moodHomeCell") as?
//            MoodHomeTableViewCell else {return UITableViewCell()}
//        cell.statsTitle.text = statlabels[indexPath.row]
//        cell.statsStats.text = stats[indexPath.row]
//
//
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "moodHomeCell")
            
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "moodHomeCell");
            }
            
            cell!.textLabel?.text = sectionData[indexPath.section]![indexPath.row]
            cell?.detailTextLabel?.text = sectionData2[indexPath.section]![indexPath.row]
            
            return cell!
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
    
    func getCurrentWeek(){
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: today)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        
        
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .flatMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }  // use `compactMap` in Xcode 9.3 and later
            .filter { !calendar.isDateInWeekend($0) }
        
        let startOfWeek = Date().startOfWeek
        let endOfWeek = Date().endOfWeek
        print(startOfWeek as Any)
        print(endOfWeek as Any)
        print(days)
    }
    

}
//extension Date {
//    var startOfWeek: Date? {
//        let gregorian = Calendar(identifier: .gregorian)
//        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
//        return gregorian.date(byAdding: .day, value: 1, to: sunday)
//    }
//
//    var endOfWeek: Date? {
//        let gregorian = Calendar(identifier: .gregorian)
//        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
//        return gregorian.date(byAdding: .day, value: 7, to: sunday)
//    }
//}

