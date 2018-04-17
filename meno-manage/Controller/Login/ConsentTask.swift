//
//  ConsentTask.swift
//  meno-manage
//
//  Created by Chris Campbell on 31/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import Foundation
import ResearchKit

public var ConsentTask: ORKOrderedTask {
    
    let Document = ORKConsentDocument()
    Document.title = "meno-manage Application Concent!"
    
    let sectionTypes: [ORKConsentSectionType] = [
        .overview,
        .dataGathering,
        .privacy,
        .dataUse,
        .timeCommitment,
        .studyTasks,
        .withdrawing
    ]
    
    let consentSections: [ORKConsentSection] = sectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        consentSection.summary = "This feild study:"
        consentSection.content = "This research study will last a total of 1 week.You can opt out at any point, by just deleting the applcaition and emailling: chriscampbell.info@gmail.com. DATA GATHERING: data will be deleted after the 1 week period. Personal information will never be disclosed. Information held on the device will be removed wehn the applcaition is deleted. You are not required but are encouraged to ue the applcaition thoughout your daily taks/activities. Any further questions, please get in touch!"
        
        return consentSection
    }
    
    Document.sections = consentSections
    Document.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "UserSignature"))
    
    var steps = [ORKStep]()
    
    //Visual Consent
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsent", document: Document)
    steps += [visualConsentStep]
    
    //Signature
    let signature = Document.signatures!.first! as ORKConsentSignature
    let reviewConsentStep = ORKConsentReviewStep(identifier: "Review", signature: signature, in: Document)
    reviewConsentStep.text = "Review the consent"
    reviewConsentStep.reasonForConsent = "Consent to join the Research Study."
    
    steps += [reviewConsentStep]
    
    //Completion
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    completionStep.title = "Welcome"
    completionStep.text = "Thank you for joining this study."
    steps += [completionStep]
   
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}

