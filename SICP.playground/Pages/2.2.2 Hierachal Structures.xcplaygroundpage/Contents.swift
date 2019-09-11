final class Cons<A> {
    private let value: A
    private let children: [Cons<A>]

    init(_ value: A, _ children: [Cons<A>] = []) {
        self.value = value
        self.children = children
    }

    var car: A {
        return value
    }

    var cdr: [Cons<A>] {
        return children
    }

    var isLeaf: Bool {
        return children.count == 0
    }
}

let list = Cons(0, [Cons(0, [Cons(1), Cons(2), Cons(0, [Cons(7), Cons(8)])]), Cons(3), Cons(0, [Cons(5)])])
let square: (Int) -> Int = { x in x * x }
let count: (Int) -> Int = { _ in 1 }

func countLeaves<A>(_ list: Cons<A>) -> Int {
    if list.isLeaf { return 1 }
    return list.cdr.map(countLeaves).reduce(0) { n, r in return n + r }
}

func map<A>(fn: (A) -> A, _ list: Cons<A> ) -> Cons<A> {
    if list.isLeaf { return Cons(fn(list.car)) }
    return Cons(list.car, list.cdr.map { map(fn: fn, $0) })
}

func append<A>(_ list1: [Cons<A>], _ list2: Cons<A>) -> [Cons<A>] {
    guard !list1.isEmpty else {
        return [list2]
    }

    return [list1[0]] + append(Array(list1.dropFirst()), list2)
}

func reverseChildren<A>(_ list: [Cons<A>]) -> [Cons<A>] {
    if list.isEmpty {
        return []
    }

    return append(reverseChildren(Array(list.dropFirst())), list[0])
}

func deepReverse<A>(_ list: Cons<A>) -> Cons<A> {
    if list.isLeaf {
        return Cons(list.car)
    }
    return Cons(list.car, reverseChildren(list.cdr).map(deepReverse))
}

//dump(list.cdr)
//dump(deepReverse(Cons(0, [Cons(1), Cons(2), Cons(3, [Cons(1), Cons(2)]), Cons(4)])))

func fringe<A>(_ list: Cons<A>) -> Cons<A> {
    func flatten(_ list: Cons<A>) -> [Cons<A>] {
        if list.isLeaf {
            return [Cons(list.car)]
        }
        
        return list.cdr.map(flatten).reduce([Cons<A>](), { r, v in
            return r + v
        })
    }

    return Cons(list.car, flatten(list))
}

//dump(fringe(list))

func squareTree(_ tree: Cons<Int>) -> Cons<Int> {
    return map(fn: square, tree)
}

//dump(squareTree(list))

// Ex 2.32
// Prev 2.2 contains solution




