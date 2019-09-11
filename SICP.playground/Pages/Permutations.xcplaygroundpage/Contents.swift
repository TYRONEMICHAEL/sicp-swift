func dropFirst<A>(_ arr: [A]) -> [A] {
    return Array(arr.dropFirst(1))
}

func map<A, B>(_ fn: (A) -> B, _ list: [A]) -> [B] {
    guard let value = list.first else {
        return []
    }

    return [fn(value)] + map(fn, dropFirst(list))
}

func foldRight<A, B>(_ fn: (A, B) -> B, _ initial: B, _ list: [A]) -> B {
    guard let value = list.first else {
        return initial
    }

    return fn(value, foldRight(fn, initial, dropFirst(list)))
}

func remove<A: Equatable>(_ a: A, _ arr: [A]) -> [A] {
    return arr.filter { x in a != x }
}

func flatMap<A, B>(_ fn: (A) -> [B], _ list: [A]) -> [B] {
    return foldRight(+, [], map(fn, list))
}

func permutations(_ arr: [Int]) -> [[Int]] {
    guard !arr.isEmpty else {
        return [[]]
    }

    return flatMap({ x in
        return map({ y in
            return [x] + y
        }, permutations(remove(x, arr)))
    }, arr)
}

//dump(permutations([1, 2, 3]))

dump(flatMap({ y in
    [2] + y
}, [[3]]))

//dump([3] + [2])
