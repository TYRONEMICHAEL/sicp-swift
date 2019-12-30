final class Cons<A> {
    private let value: A
    private let next: (() -> Cons<A>?)?

    init(_ value: A, _ next: (() -> Cons<A>?)?) {
        self.value = value
        self.next = next
    }

    var car: A {
        return value
    }

    var cdr: Cons<A>? {
        return next?()
    }
}

func streamtail<A>(_ stream: Cons<A>) -> Cons<A>? {
    return stream.cdr
}

func fibGen(_ a: Int, _ b: Int) -> Cons<Int> {
    return Cons(a, { fibGen(b, a + b) })
}

//let s = fibGen(0, 1)
//s.cdr?.cdr?.cdr?.cdr?.car
// Cons(0, { fibGen(1, 0 + 1) })
// Cons(0, { Cons(1, { fibGen(1, 1 + 1) }) })
// Cons(0, { Cons(1, Cons(2, { fibGen(1, 2 + 1) })) })
// Cons(0, { Cons(1, Cons(2, { Cons(3, { fibGen(3, 3 + 2) }))) })

func streamMap<A, B>(_ fn: @escaping (A) -> B, _ s: Cons<A>) -> Cons<B> {
    guard let next = s.cdr else {
        return Cons(fn(s.car), nil)
    }
    return Cons(fn(s.car), { streamMap(fn, next) })
}

func streamCombine<A, B>(_ fn: @escaping (A) -> B, _ s1: Cons<A>, _ s2: Cons<A>) -> Cons<B> {
    guard let next = s1.cdr else {
        return Cons(fn(s1.car), { streamMap(fn, s2) })
    }

    return Cons(fn(s1.car), { streamCombine(fn, next, s2) })
}

func streamCombine<A, B>(_ fn: @escaping (A, A) -> B, _ s1: Cons<A>, _ s2: Cons<A>) -> Cons<B> {
    guard let a = s1.cdr, let b = s2.cdr else {
        return Cons(fn(s1.car, s2.car), nil)
    }

    return Cons(fn(s1.car, s2.car), { streamCombine(fn, a, b) })
}

let a = Cons(1, { Cons(2,{ Cons(3, nil) })})
let b = Cons(4, { Cons(5,{ Cons(6, nil) })})

//dump(streamCombine(*, a, b).cdr?.cdr?.car)

func streamWithdraw(_ balance: Int, amountStream: Cons<Int>) -> Cons<Int> {
    guard let next = amountStream.cdr else {
        return Cons(balance - amountStream.car, nil)
    }
    
    return Cons(balance - amountStream.car, { streamWithdraw(balance - amountStream.car, amountStream: next) })
}

let z = streamWithdraw(10, amountStream: a)
z.cdr?.cdr?.car
