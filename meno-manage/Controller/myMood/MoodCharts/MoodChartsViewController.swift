import UIKit
import Realm
import RealmSwift
import Charts
import ChartsRealm
import EPCalendarPicker


class MoodChartsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, EPCalendarPickerDelegate, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var mainCollection: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
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
    let locationNames = ["Total Mood Count", "Average Daily Mood", "Moods & Activity", "Todays Activity", "Last Note", " Symptoms & Activities Past Week"]
    let locationDescription = ["How are you feeling today?","Time of day & your mood", "Your Mood vs Activity - Past Week", "Todays Activity", "Last Diary Entry", "From your past weeks journal. "]

    
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
        
        //MOOD DATA
        let great = getGreatMood()
        let good = getGoodMood()
        let meh = getMehMood()
        let sad = getSadMood()
        let awful = getAwfulMood()
        
        let totalMoods = getTotalSessions()
        let allTimeAverage = getAverage()
        getCurrentWeek()
        
        //    "Irregular period", "Vaginal dryness", "Hot flash", "Chills", "Night sweats", "Poor sleep", "Loss of libido", "Dry skin", "Thinning of hair", "Loss of breast fullness"
        //SYMPTOM DATA
        let IP = String(getIPeriod())
        let VG = String(getVag())
        let flash = String(getFlash())
        let chills = String(getChills())
        let NS = String(getNightSweats())
        let PS = String(getPoorSleep())
        let libido = String(getLossLibido())
        let DS = String(getDrySkin())
        let TH = String(getHair())
        let BF = String(getBreast())
        
        //"Work","Friends", "Relax", "Date", "Sports", "Shopping", "Gaming", "Reading", "Relaxing", "Travelling", "Cleaning", "Cooking", "Other"
        // GET GREAT ACTIVITIES:
        let GRWork = String(getGreatWork())
        let GRFriends = String(getGreatFriends())
        let GRRelax = String(getGreatRelax())
        let GRDate = String(getGreatDate())
        let GRSport = String(getGreatSport())
        let GRShopping = String(getGreatShopping())
        let GRGaming = String(getGreatGaming())
        let GRReading = String(getGreatReading())
        let GRRelaxing = String(getGreatRelaxing())
        let GRTravelling = String(getGreatTravelling())
        let GRCleaning = String(getGreatCleaning())
        let GRCooking = String(getGreatCooking())
        let GROther = String(getGreatOther())
        
        
        let s2Data2: [String] = [IP, VG, flash, chills, NS, PS, libido, DS, TH, BF]
        let s3Data2: [String] = ["sec", "coming soon", "coming soon", allTimeAverage, "coming soon",  totalMoods]
        let greatActivity: [String] = [GRWork, GRFriends, GRRelax, GRDate, GRSport, GRShopping, GRGaming, GRReading, GRRelaxing, GRTravelling, GRCleaning, GRCooking, GROther]

        sectionData = [0:s3Data, 1:s2Data, 2:newData, 3:newData, 4:newData,5:newData,6:newData]
        sectionData2 = [0:s3Data2, 1:s2Data2, 2:greatActivity, 3:newData2, 4:newData2,5:newData2,6:newData2 ]


        moodList = ["Great", "Good", "Meh", "Sad", "Awful"]
        getMoodList = [great, good, meh, sad, awful]
        
        statlabels = ["🗓 Today", "🗓 7 Days", "🗓 30 Days", "📊 All Time Average", "🔥 Best Streak" , "📈 Total Sessions Logged"]
        stats = ["sec", "coming soon", "coming soon", allTimeAverage, "coming soon",  totalMoods]
        
        print(getGreatWork())

        print(getIPeriod())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mainCollection.reloadData()
        self.mainTableView.reloadData()
        
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
    
    //GET COUNT FOR SYMPTOMS
    func getIPeriod() -> Int{
        let IPsymptom = realm.objects(Mood.self).filter("symptom = 'Irregular period'")
        return Int(IPsymptom.count)
    }
    func getVag() -> Int{
        let vagDry = realm.objects(Mood.self).filter("symptom = 'Vaginal dryness'")
        return Int(vagDry.count)
    }
    func getFlash() -> Int{
        let hotFlash = realm.objects(Mood.self).filter("symptom = 'Hot flash'")
        return Int(hotFlash.count)
    }
    func getChills() -> Int{
        let chills = realm.objects(Mood.self).filter("symptom = 'Chills'")
        return Int(chills.count)
    }
    func getNightSweats() -> Int{
        let nightsweats = realm.objects(Mood.self).filter("symptom = 'Night sweats'")
        return Int(nightsweats.count)
    }
    func getPoorSleep() -> Int{
        let poorsleep = realm.objects(Mood.self).filter("symptom = 'Poor sleep'")
        return Int(poorsleep.count)
    }
    func getLossLibido() -> Int{
        let libido = realm.objects(Mood.self).filter("symptom = 'Loss of libido'")
        return Int(libido.count)
    }
    func getDrySkin() -> Int{
        let dryskin = realm.objects(Mood.self).filter("symptom = 'Dry skin'")
        return Int(dryskin.count)
    }
    func getHair() -> Int{
        let hair = realm.objects(Mood.self).filter("symptom = 'Thinning of hair'")
        return Int(hair.count)
    }
    func getBreast() -> Int{
        let breast = realm.objects(Mood.self).filter("symptom = 'Loss of breast fullness'")
        return Int(breast.count)
    }
    
    
//    GET GREAT MOOD ACTIVITIES
    func getGreatWork() -> Int{
        let greatWork = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Work'")
        return Int(greatWork.count)
    }
    func getGreatFriends() -> Int{
        let greatFriends = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Friends'")
        return Int(greatFriends.count)
    }
    func getGreatRelax() -> Int{
        let greatRelax = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Relax'")
        return Int(greatRelax.count)
    }
    func getGreatDate() -> Int{
        let greatDate = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Date'")
        return Int(greatDate.count)
    }
    func getGreatShopping() -> Int{
        let greatShopping = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Shopping'")
        return Int(greatShopping.count)
    }
    func getGreatSport() -> Int{
        let greatSport = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Sport'")
        return Int(greatSport.count)
    }
    func getGreatGaming() -> Int{
        let greatGaming = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Gaming'")
        return Int(greatGaming.count)
    }
    func getGreatReading() -> Int{
        let greatReading = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Reading'")
        return Int(greatReading.count)
    }
    func getGreatRelaxing() -> Int{
        let greatRelaxing = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Relaxing'")
        return Int(greatRelaxing.count)
    }
    func getGreatTravelling() -> Int{
        let greatTravelling = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Travelling'")
        return Int(greatTravelling.count)
    }
    func getGreatCleaning() -> Int{
        let greatCleaning = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Cleaning'")
        return Int(greatCleaning.count)
    }
    func getGreatCooking() -> Int{
        let greatCooking = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Cooking'")
        return Int(greatCooking.count)
    }
    func getGreatOther() -> Int{
        let greatOther = realm.objects(Mood.self).filter("mood = 'Great' AND activities = 'Other'")
        return Int(greatOther.count)
    }
    
    
    //    GET GOOD MOOD ACTIVITIES
    func getGoodWork() -> Int{
        let goodWork = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Work'")
        return Int(goodWork.count)
    }
    func getGoodFriends() -> Int{
        let goodFriends = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Friends'")
        return Int(goodFriends.count)
    }
    func getGoodRelax() -> Int{
        let goodRelax = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Relax'")
        return Int(goodRelax.count)
    }
    func getGoodDate() -> Int{
        let goodDate = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Date'")
        return Int(goodDate.count)
    }
    func getGoodShopping() -> Int{
        let goodShopping = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Shopping'")
        return Int(goodShopping.count)
    }
    func getGoodSport() -> Int{
        let goodSport = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Sport'")
        return Int(goodSport.count)
    }
    func getGoodGaming() -> Int{
        let goodGaming = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Gaming'")
        return Int(goodGaming.count)
    }
    func getGoodReading() -> Int{
        let goodReading = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Reading'")
        return Int(goodReading.count)
    }
    func getGoodRelaxing() -> Int{
        let goodRelaxing = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Relaxing'")
        return Int(goodRelaxing.count)
    }
    func getGoodTravelling() -> Int{
        let GoodTravelling = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Travelling'")
        return Int(GoodTravelling.count)
    }
    func getGoodCleaning() -> Int{
        let GoodCleaning = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Cleaning'")
        return Int(GoodCleaning.count)
    }
    func getGoodCooking() -> Int{
        let GoodCooking = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Cooking'")
        return Int(GoodCooking.count)
    }
    func getGoodOther() -> Int{
        let GoodOther = realm.objects(Mood.self).filter("mood = 'Good' AND activities = 'Other'")
        return Int(GoodOther.count)
    }
    
    //    GET MEH MOOD ACTIVITIES
    func getMehWork() -> Int{
        let MehWork = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Work'")
        return Int(MehWork.count)
    }
    func getMehFriends() -> Int{
        let MehFriends = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Friends'")
        return Int(MehFriends.count)
    }
    func getMehRelax() -> Int{
        let MehRelax = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Relax'")
        return Int(MehRelax.count)
    }
    func getMehDate() -> Int{
        let MehDate = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Date'")
        return Int(MehDate.count)
    }
    func getMehShopping() -> Int{
        let MehShopping = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Shopping'")
        return Int(MehShopping.count)
    }
    func getMehSport() -> Int{
        let MehSport = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Sport'")
        return Int(MehSport.count)
    }
    func getMehGaming() -> Int{
        let MehGaming = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Gaming'")
        return Int(MehGaming.count)
    }
    func getMehReading() -> Int{
        let MehReading = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Reading'")
        return Int(MehReading.count)
    }
    func getMehRelaxing() -> Int{
        let MehRelaxing = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Relaxing'")
        return Int(MehRelaxing.count)
    }
    func getMehTravelling() -> Int{
        let MehTravelling = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Travelling'")
        return Int(MehTravelling.count)
    }
    func getMehCleaning() -> Int{
        let MehCleaning = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Cleaning'")
        return Int(MehCleaning.count)
    }
    func getMehCooking() -> Int{
        let MehCooking = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Cooking'")
        return Int(MehCooking.count)
    }
    func getMehOther() -> Int{
        let MehOther = realm.objects(Mood.self).filter("mood = 'Meh' AND activities = 'Other'")
        return Int(MehOther.count)
    }
    
    //    GET SAD MOOD ACTIVITIES
    func getSadWork() -> Int{
        let SadWork = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Work'")
        return Int(SadWork.count)
    }
    func getSadFriends() -> Int{
        let SadFriends = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Friends'")
        return Int(SadFriends.count)
    }
    func getSadRelax() -> Int{
        let SadRelax = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Relax'")
        return Int(SadRelax.count)
    }
    func getSadDate() -> Int{
        let SadDate = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Date'")
        return Int(SadDate.count)
    }
    func getSadShopping() -> Int{
        let SadShopping = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Shopping'")
        return Int(SadShopping.count)
    }
    func getSadSport() -> Int{
        let SadSport = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Sport'")
        return Int(SadSport.count)
    }
    func getSadGaming() -> Int{
        let SadGaming = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Gaming'")
        return Int(SadGaming.count)
    }
    func getSadReading() -> Int{
        let SadReading = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Reading'")
        return Int(SadReading.count)
    }
    func getSadRelaxing() -> Int{
        let SadRelaxing = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Relaxing'")
        return Int(SadRelaxing.count)
    }
    func getSadTravelling() -> Int{
        let SadTravelling = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Travelling'")
        return Int(SadTravelling.count)
    }
    func getSadCleaning() -> Int{
        let SadCleaning = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Cleaning'")
        return Int(SadCleaning.count)
    }
    func getSadCooking() -> Int{
        let SadCooking = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Cooking'")
        return Int(SadCooking.count)
    }
    func getSadOther() -> Int{
        let SadOther = realm.objects(Mood.self).filter("mood = 'Sad' AND activities = 'Other'")
        return Int(SadOther.count)
    }
    
    
    //    GET AWFUL MOOD ACTIVITIES
    func getAwfulWork() -> Int{
        let AwfulWork = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Work'")
        return Int(AwfulWork.count)
    }
    func getAwfulFriends() -> Int{
        let AwfulFriends = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Friends'")
        return Int(AwfulFriends.count)
    }
    func getAwfulRelax() -> Int{
        let AwfulRelax = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Relax'")
        return Int(AwfulRelax.count)
    }
    func getAwfulDate() -> Int{
        let AwfulDate = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Date'")
        return Int(AwfulDate.count)
    }
    func getAwfulShopping() -> Int{
        let AwfulShopping = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Shopping'")
        return Int(AwfulShopping.count)
    }
    func getAwfulSport() -> Int{
        let AwfulSport = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Sport'")
        return Int(AwfulSport.count)
    }
    func getAwfulGaming() -> Int{
        let AwfulGaming = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Gaming'")
        return Int(AwfulGaming.count)
    }
    func getAwfulReading() -> Int{
        let AwfulReading = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Reading'")
        return Int(AwfulReading.count)
    }
    func getAwfulRelaxing() -> Int{
        let AwfulRelaxing = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Relaxing'")
        return Int(AwfulRelaxing.count)
    }
    func getAwfulTravelling() -> Int{
        let AwfulTravelling = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Travelling'")
        return Int(AwfulTravelling.count)
    }
    func getAwfulCleaning() -> Int{
        let AwfulCleaning = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Cleaning'")
        return Int(AwfulCleaning.count)
    }
    func getAwfulCooking() -> Int{
        let AwfulCooking = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Cooking'")
        return Int(AwfulCooking.count)
    }
    func getAwfulOther() -> Int{
        let AwfulOther = realm.objects(Mood.self).filter("mood = 'Awful' AND activities = 'Other'")
        return Int(AwfulOther.count)
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
        return 4
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
            let cell4 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! DayTimeCollectionViewCell
            
            cell4.cellTitle.text = locationNames[indexPath.row]
            cell4.cellDescription.text = locationDescription[indexPath.row]
            cell4.morningLabel.text = "Good"
            cell4.afternoonLabel.text = "Meh"
            cell4.nightLabel.text = "Great"
            
            
            cell4.contentView.layer.cornerRadius = 4.0
            cell4.contentView.layer.borderWidth = 1.0
            cell4.contentView.layer.borderColor = UIColor.clear.cgColor
            cell4.contentView.layer.masksToBounds = false
            cell4.layer.shadowColor = UIColor.gray.cgColor
            cell4.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            cell4.layer.shadowRadius = 4.0
            cell4.layer.shadowOpacity = 1.0
            cell4.layer.masksToBounds = false
            cell4.layer.shadowPath = UIBezierPath(roundedRect: cell4.bounds, cornerRadius: cell4.contentView.layer.cornerRadius).cgPath
            
            return cell4
        }
        if indexPath.row == 2 {
            let moodCell = collectionView.dequeueReusableCell(withReuseIdentifier: "moodToExercise", for: indexPath) as! moodActivityCollectionViewCell
            
            moodCell.title.text = locationNames[indexPath.row]
            moodCell.desc.text = locationDescription[indexPath.row]
            
            moodCell.contentView.layer.cornerRadius = 4.0
            moodCell.contentView.layer.borderWidth = 1.0
            moodCell.contentView.layer.borderColor = UIColor.clear.cgColor
            moodCell.contentView.layer.masksToBounds = false
            moodCell.layer.shadowColor = UIColor.gray.cgColor
            moodCell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            moodCell.layer.shadowRadius = 4.0
            moodCell.layer.shadowOpacity = 1.0
            moodCell.layer.masksToBounds = false
            moodCell.layer.shadowPath = UIBezierPath(roundedRect: moodCell.bounds, cornerRadius: moodCell.contentView.layer.cornerRadius).cgPath
            
            return moodCell
        }
        if indexPath.row == 3 {
            let lastNoteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastNote", for: indexPath) as! lastNoteCollectionViewCell
            
            lastNoteCell.title.text = locationNames[indexPath.row]
            lastNoteCell.label.text = locationDescription[indexPath.row]
 
            lastNoteCell.contentView.layer.cornerRadius = 4.0
            lastNoteCell.contentView.layer.borderWidth = 1.0
            lastNoteCell.contentView.layer.borderColor = UIColor.clear.cgColor
            lastNoteCell.contentView.layer.masksToBounds = false
            lastNoteCell.layer.shadowColor = UIColor.gray.cgColor
            lastNoteCell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            lastNoteCell.layer.shadowRadius = 4.0
            lastNoteCell.layer.shadowOpacity = 1.0
            lastNoteCell.layer.masksToBounds = false
            lastNoteCell.layer.shadowPath = UIBezierPath(roundedRect: lastNoteCell.bounds, cornerRadius: lastNoteCell.contentView.layer.cornerRadius).cgPath
            
            return lastNoteCell
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
//        print(startOfWeek as Any)
//        print(endOfWeek as Any)
//        print(days)
    }
    

}

