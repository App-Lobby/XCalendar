//
//  XCalendar.swift
//  XCalendar
//
//  Created by Mohammad Yasir on 07/10/21.
//

import SwiftUI

struct XCalendar: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(Key.calendar.getAllMonths(forDate: Date()), id:\.self) { day in
                CalendarView(forDate: day, selectionSize: .large)
                    .padding(.vertical)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).edgesIgnoringSafeArea(.all))
    }
}

