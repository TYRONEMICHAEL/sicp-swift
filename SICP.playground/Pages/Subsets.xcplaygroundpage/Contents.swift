//: [Previous](@previous)

import Foundation

func dropFirst<A>(_ a: [A]) -> [A] {
    return Array(a.dropFirst())
}

func map<A, B>(_ fn: (A) -> B, _ list: [A]) -> [B] {
    guard let value = list.first else {
        return []
    }

    return [fn(value)] + map(fn, dropFirst(list))
}

func subsets<A>(_ list: [A]) -> [[A]] {
    guard !list.isEmpty else {
        return [[]]
    }

    let rest = subsets(dropFirst(list))
    return rest + map( { x in
        return [list[0]] + x.map { $0 }
    }, rest)
}

dump(subsets([1, 2, 3]))
