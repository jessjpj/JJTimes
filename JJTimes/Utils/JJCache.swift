//
//  JJCache.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation

class JJCache<Key: Hashable, Value> where Key: AnyObject {
    private let cache = NSCache<Key, Entry>()
    private let entryLifetime: TimeInterval

    init(entryLifetime: TimeInterval = 5 * 60) {
        self.entryLifetime = entryLifetime
    }

    func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value, expirationDate: Date().addingTimeInterval(entryLifetime))
        cache.setObject(entry, forKey: key)
    }

    func value(forKey key: Key) -> Value? {
        guard let entry = cache.object(forKey: key) else { return nil }
        guard Date() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }
        return entry.value
    }

    func removeValue(forKey key: Key) {
        cache.removeObject(forKey: key)
    }

    private struct WrappedKey: Hashable {
        let key: Key

        init(_ key: Key) {
            self.key = key
        }
    }

    private class Entry {
        let value: Value
        let expirationDate: Date

        init(value: Value, expirationDate: Date) {
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}
