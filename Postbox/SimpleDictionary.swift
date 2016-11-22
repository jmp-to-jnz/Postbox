import Foundation

public struct SimpleDictionary<K: Hashable, V>: Sequence {
    private var items: [(K, V)] = []
    
    public var count: Int {
        return self.items.count
    }
    
    public var isEmpty: Bool {
        return self.items.isEmpty
    }
    
    public init() {
    }
    
    private init(items: [(K, V)] = []) {
        self.items = items
    }
    
    public func filteredOut(keysIn: Set<K>) -> SimpleDictionary<K, V>? {
        var hasUpdates = false
        for (key, _) in self.items {
            if keysIn.contains(key) {
                hasUpdates = true
                break
            }
        }
        if hasUpdates {
            var updatedItems: [(K, V)] = []
            for (key, value) in self.items {
                if !keysIn.contains(key) {
                    updatedItems.append((key, value))
                    break
                }
            }
            return SimpleDictionary(items: updatedItems)
        } else {
            return nil
        }
    }
    
    public subscript(key: K) -> V? {
        get {
            for (k, value) in self.items {
                if k == key {
                    return value
                }
            }
            return nil
        } set(value) {
            var index = 0
            for (k, _) in self.items {
                if k == key {
                    if let value = value {
                        self.items[index] = (k, value)
                    } else {
                        self.items.remove(at: index)
                    }
                    return
                }
                index += 1
            }
            if let value = value {
                self.items.append((key, value))
            }
        }
    }
    
    public func makeIterator() -> AnyIterator<(K, V)> {
        var index = 0
        return AnyIterator { () -> (K, V)? in
            if index < self.items.count {
                let currentIndex = index
                index += 1
                return self.items[currentIndex]
            }
            return nil
        }
    }
}
