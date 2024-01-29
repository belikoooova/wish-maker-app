//
//  CalendarManager.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 29.01.2024.
//

import EventKit

final class CalendarManager: CalendarManaging {
    func create(eventModel: WishEventModel) -> Bool {
        var result: Bool = false
        let group = DispatchGroup()
        group.enter()
        create(eventModel: eventModel) { isCreated in
            result = isCreated
            group.leave()
        }
        
        group.wait()
        return result
    }
    
    private let eventStore: EKEventStore = EKEventStore()

    func create(eventModel: WishEventModel, completion: @escaping (Bool) -> Void) {
        eventStore.requestAccess(to: .event) { [weak self] granted, error in
            guard let self = self, granted, error == nil else {
                completion(false)
                return
            }

            let event = EKEvent(eventStore: self.eventStore)
            event.title = eventModel.title
            event.startDate = eventModel.startDate
            event.endDate = eventModel.endDate
            event.notes = eventModel.description
            event.calendar = self.eventStore.defaultCalendarForNewEvents
            
            do {
                try self.eventStore.save(event, span: .thisEvent)
                completion(true)
            } catch {
                print("Failed to save event with error: \(error)")
                completion(false)
            }
        }
    }

    func createEventSynchronously(eventModel: WishEventModel) -> Bool {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Bool = false

        create(eventModel: eventModel) { success in
            result = success
            semaphore.signal()
        }

        semaphore.wait()
        return result
    }
}
