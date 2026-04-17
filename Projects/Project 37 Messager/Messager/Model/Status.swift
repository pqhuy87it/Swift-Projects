//
//  Status.swift
//  Messager
//
//  Created by David Kababyan on 23/08/2020.
//

import Foundation

enum Status: String, CaseIterable {
    
    case Available = "Available"
    case Busy = "Busy"
    case AtSchool = "At School"
    case AtTheMovies = "At The Movies"
    case AtWork = "At Work"
    case BatteryAboutToDie = "Battery About to die"
    case CantTalk = "Can't Talk"
    case InAMeeting = "In a Meeting"
    case AtTheGym = "At the gym"
    case Sleeping = "Sleeping"
    case UrgentCallsOnly = "Urgent calls only"
}
