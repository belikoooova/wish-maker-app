//
//  CalendarManagingProtocol.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 29.01.2024.
//

import EventKit

protocol CalendarManaging {
    func create(eventModel: WishEventModel) -> Bool
}
