//
//  CalendarView.swift
//  XCalendar
//
//  Created by Mohammad Yasir on 07/10/21.
//

import SwiftUI

struct CalendarView: View {
    public let forDate: Date
    public let selectionSize: SelectionSize
    
    @State public var selectedDate = Date()
    private let days: [Day] = [Day(text: "S"), Day(text: "M"), Day(text: "T"), Day(text: "W"), Day(text: "T"), Day(text: "F"), Day(text: "S")]
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.extreme.rawValue) {
            headerView
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: Spacing.large.rawValue) {
                daysNameView
                
                ForEach(Key.calendar.getAllRealDays(for: forDate), id:\.self) { day in
                    if Key.calendar.isDate(day, equalTo: forDate, toGranularity: .month) {
                        realDateView(day: day)
                    } else {
                        fakeDateView(day: day)
                    }
                }
            }
        }
    }
    
    private func realDateView(
        day: Date
    ) -> some View {
        ZStack {
            Circle()
                .strokeBorder(Key.calendar.isSameDate(this: day, with: selectedDate) ? Color.white : .clear)
                .frame(width: selectionSize.rawValue + 10, height: selectionSize.rawValue + 10)
                .background(
                    Group {
                        if DateFormatter.day.string(from: day) == "Sunday" {
                            Circle()
                                .foregroundColor(Key.calendar.isSameDate(this: day, with: selectedDate) ? .white : Color(#colorLiteral(red: 0.09086381644, green: 0.3214819431, blue: 0.5836756229, alpha: 1)))
                                .frame(width: selectionSize.rawValue, height: selectionSize.rawValue)
                        } else {
                            Circle()
                                .foregroundColor(Key.calendar.isSameDate(this: day, with: selectedDate) ? .white : Color(#colorLiteral(red: 0.02716426179, green: 0.1046925262, blue: 0.1926645935, alpha: 1)))
                                .frame(width: selectionSize.rawValue, height: selectionSize.rawValue)
                        }
                    }
                )
            
            Text(DateFormatter.date.string(from: day))
                .foregroundColor(Key.calendar.isSameDate(this: day, with: selectedDate) ? Color(#colorLiteral(red: 0.09264679548, green: 0.353177014, blue: 0.6412135916, alpha: 1)) : .white)
                .font(.subheadline)
                .onTapGesture {
                    withAnimation {
                        selectedDate = day
                    }
                }
            
        }
    }
    
    private func fakeDateView(
        day: Date
    ) -> some View {
        Text(DateFormatter.date.string(from: day))
            .foregroundColor(.gray.opacity(0.4))
            .font(.subheadline)
    }
    
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text(DateFormatter.month.string(from: forDate))
                .font(.system(.headline, design: .serif))
            
            Text(DateFormatter.year.string(from: forDate))
                .font(.system(.subheadline, design: .serif))
        }
        .padding(.leading, Spacing.standard.rawValue)
        .foregroundColor(Color(#colorLiteral(red: 0.09264679548, green: 0.353177014, blue: 0.6412135916, alpha: 1)))
    }
    
    private var daysNameView: some View {
        ForEach(days, id:\.id) { day in
            Text(day.text)
                .foregroundColor(.white)
                .font(.subheadline.bold())
        }
    }
}
