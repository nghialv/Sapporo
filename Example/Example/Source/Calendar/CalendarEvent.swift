//
//  CalendarEvent.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import Foundation

final class CalendarEvent {
    let title: String
    let day: Int
    let startHour: Int
    let durationInHours: Int
    
    init(title: String, day: Int, startHour: Int, durationInHours: Int) {
        self.title = title
        self.day = day
        self.startHour = startHour
        self.durationInHours = durationInHours
    }
}
