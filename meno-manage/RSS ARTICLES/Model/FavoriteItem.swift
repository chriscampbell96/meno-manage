
import UIKit
import MWFeedParser

class FavoriteItem: MWFeedItem {
    
    var feedName : String!
    
    init(from item: MWFeedItem!, feedName: String!) {
        super.init()
        self.feedName = feedName
        self.identifier = item.identifier
        self.title = item.title
        self.summary = item.summary
        self.link = item.link
        self.date = item.date
        self.updated = item.updated
        self.content = item.content
        self.author = item.author
        self.enclosures = item.enclosures
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.feedName = aDecoder.decodeObject(forKey: "feedName") as! String
    }
    
    override func encode(with encoder: NSCoder) {
        super.encode(with: encoder)
        encoder.encode(self.feedName, forKey: "feedName")
    }
}
