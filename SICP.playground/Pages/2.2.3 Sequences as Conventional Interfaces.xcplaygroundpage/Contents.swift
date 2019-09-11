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

func accumulator<A, B>(fn: (A, B) -> B, _ initial: B, _ list: [Cons<A>]) -> B {
    if list.count == 0 {
        return initial
    }

    return fn(list[0].car, accumulator(fn: fn, initial, Array(list.dropFirst())))
}

let list = Cons(0, [Cons(0, [Cons(1), Cons(2), Cons(0, [Cons(7), Cons(8)])]), Cons(3), Cons(0, [Cons(5)])])
let add: (Int, Int) -> Int = { a, b in a + b }
dump(accumulator(fn: add, 0, fringe(list).cdr))

