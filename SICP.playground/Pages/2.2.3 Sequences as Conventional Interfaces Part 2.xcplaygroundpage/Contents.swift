import Foundation

func dropFirst<A>(_ arr: [A]) -> [A] {
    return Array(arr.dropFirst(1))
}

func reduce<A, B>(_ fn: (A, B) -> B, _ initial: B, _ list: [A]) -> B {
    guard let value = list.first else {
        return initial
    }

    return fn(value, reduce(fn, initial, Array(list.dropFirst(1))))
}

func foldRight<A, B>(_ fn: (A, B) -> B, _ initial: B, _ list: [A]) -> B {
    guard let value = list.first else {
        return initial
    }

    return fn(value, foldRight(fn, initial, dropFirst(list)))
}

func foldLeft<A, B>(_ fn: (A, B) -> B, _ initial: B, _ list: [A]) -> B {
    func iter(_ fn: (A, B) -> B, result: B, _ list: [A]) -> B {
        guard let value = list.first else {
            return result
        }

        return iter(fn, result: fn(value, result), dropFirst(list))
    }

    return iter(fn, result: initial, list)
}

func map<A, B>(_ fn: (A) -> B, _ list: [A]) -> [B] {
    guard let value = list.first else {
        return []
    }

    return [fn(value)] + map(fn, dropFirst(list))
}

//func map<A>(_ fn: (A) -> [A], _ list: [A]) -> [[A]] {
//    guard let value = list.first else {
//        return []
//    }
//
//    return [fn(value)] + map(fn, dropFirst(list))
//}

func flatMap<A, B>(_ fn: (A) -> [B], _ list: [A]) -> [B] {
    return foldRight(+, [], map(fn, list))
}

let sum: (Int, Int) -> Int = { a, b in a + b }
let append: (String, String) -> String = { a, b in a + b }

reduce(sum, 0, [1, 2, 3])
foldLeft(append, "", ["Hello", "World"])
foldLeft(sum, 0, [1, 2, 3])

let square: (Int) -> Int = { x in x * x }
let squareF: (Int) -> [Int] = { x in [x * x] }

map(squareF, [1, 2, 3])
flatMap(squareF, [1, 2, 3])

func remove<A: Equatable>(_ a: A, _ arr: [A]) -> [A] {
    return arr.filter { x in a != x }
}

dump(remove(3, [1, 2, 3]))

// Exercise 2.40

func enumerate(_ from: Int, _ to: Int) -> [Int] {
    if from > to {
        return []
    }

    return [from] + enumerate(from + 1, to)
}

dump(enumerate(1, 5))

func uniquePairs(_ n: Int) -> [[Int]] {
    if n == 0 {
        return [[]]
    }

    return flatMap({ x in
        return map({ y in
            [x, y]
        }, enumerate(1, x - 1))
    }, enumerate(1, n - 1))
}

func filter<A>(_ pred: (A) -> Bool, _ list: [A]) -> [A] {
    if list.isEmpty {
        return []
    }

    if pred(list[0]) {
        return [list[0]] + filter(pred, dropFirst(list))
    }

    return filter(pred, dropFirst(list))
}

func uniqueSum(_ n: Int, _ s: Int) -> [[Int]] {
    return filter({ triplet in
        foldLeft(+, 0, triplet) == s
    }, uniqueTriplets(n))
}

func uniqueTriplets(_ n: Int) -> [[Int]] {
    if n == 0 {
        return [[]]
    }

    return flatMap({ x in
        return flatMap({ y in
            return map({ z in
                [x, y, z]
            }, enumerate(1, y - 1))
        }, enumerate(1, x - 1))
    }, enumerate(1, n - 1))
}

//dump(uniqueTriplets(5))

//dump(uniqueSum(6, 9))

// [1, 2, 3] ->

func permutations(_ list: [Int]) -> [[Int]] {
    if list.isEmpty {
        return [[]]
    }

    return flatMap({ x in
        return map({ y in
            [x] + y
        }, permutations(remove(x, list)))
    }, list)
}

print(permutations([1, 2, 3]))
