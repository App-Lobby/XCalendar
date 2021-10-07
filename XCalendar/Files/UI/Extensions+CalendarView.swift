//
//  Extensions+CalendarView.swift
//  XCalendar
//
//  Created by Mohammad Yasir on 07/10/21.
//

import SwiftUI

extension CalendarView {
    public enum SelectionSize: CGFloat {
        case small = 20
        case medium = 30
        case large = 40
        case extraLarge = 50
    }
    
    public struct Day: Identifiable {
        let id = UUID()
        let text: String
    }
}
