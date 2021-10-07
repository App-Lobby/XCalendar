//
//  Extensions+Calendar.swift
//  XCalendar
//
//  Created by Mohammad Yasir on 07/10/21.
//

import SwiftUI

extension Calendar {
    public func getAllDates(
        dateInterval: DateInterval,
        dateComponent: DateComponents) -> [Date] {
        
        var dates: [Date] = []
        dates.append(dateInterval.start)
        
        enumerateDates(startingAfter: dateInterval.start, matching: dateComponent, matchingPolicy: .nextTime) { date, _, stop in
            guard let date = date else {
                return
            }
            
            if date < dateInterval.end { dates.append(date) } else {
                stop = true // It is an inout parameter
            }
        }
        return dates
    }
    
    public func getAllRealDays(for month: Date) -> [Date] {
        guard
            let monthInterval = Key.calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = Key.calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = Key.calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return Key.calendar.getAllDates(
            dateInterval: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            dateComponent: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    public func getAllWeeks(for month: Date) -> [[Date]] {
        var weeks: [[Date]] = []
        for day in getAllRealDays(for: month) {
            if weeks.last?.count ?? 7 < 7 { weeks[weeks.count-1].append(day) } else {
                weeks.append([day])
            }
        }
        return weeks
    }
    
    public func isSameDate(this: Date, with: Date) -> Bool {
        let order = Calendar.current.compare(this, to: with, toGranularity: .day)
        
        switch order {
        case .orderedAscending:
            return false
        case .orderedDescending:
            return false
        case .orderedSame:
            return true
        }
    }
    
    public func getAllMonths(forDate: Date) -> [Date] {
        return Key.calendar.getAllDates(
            dateInterval: Key.calendar.dateInterval(of: .year, for: forDate)!,
            dateComponent: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

}
