final class Cons<A> {
    private let value: A
    private var node: Cons<A>?

    init(_ value: A, _ next: Cons<A>?) {
        self.value = value
        self.node = next
    }

    var car: A {
        return value
    }

    var cdr: Cons<A>? {
        return node
    }

}

func length<A>(_ list: Cons<A>?) -> Int {
    if list == nil { return 0 }
    return 1 + length(list?.cdr)
}

func append<A>(_ list1: Cons<A>, _ list2: Cons<A>) -> Cons<A> {
    guard let l = list1.cdr else {
        return Cons(list1.car, list2)
    }

    return Cons(list1.car, append(l, list2))
}

func last<A>(_ list: Cons<A>) -> A {
    guard let l = list.cdr else {
        return list.car
    }

    return last(l)
}

func reverse<A>(_ list: Cons<A>) -> Cons<A> {
    guard let l = list.cdr else {
        return Cons(list.car, nil)
    }

    return append(reverse(l), Cons(list.car, nil))
}

let list = Cons(1, Cons(2, Cons(3, nil)))
let list2 = Cons(1, Cons(2, Cons(3, nil)))

//dump(reverse(list))

// Ex 2.20

func makeCons<A>(_ arr: [A]) -> Cons<A> {
    if arr.count == 1 {
        return Cons(arr[0], nil)
    }

    return Cons(arr[0], makeCons(Array(arr.dropFirst())))
}

dump(makeCons([1, 2, 3]))

func map<A>(_ fn: (A) -> A, _ list: Cons<A>) -> Cons<A> {
    guard let l = list.cdr else {
        return Cons(fn(list.car), nil)
    }

    return Cons(fn(list.car), map(fn, l))
}

let square: (Int) -> Int = { n in n * n }

dump(map(square, list))

func forEach<A>(_ fn: (A) -> Void, _ list: Cons<A>) {
    guard let l = list.cdr else {
        fn(list.car)
        return
    }

    fn(list.car)
    return forEach(fn, l)
}

forEach({ v in dump(v) }, list)
