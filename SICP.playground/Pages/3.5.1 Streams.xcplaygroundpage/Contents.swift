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

func streamRef<A>(_ stream: Cons<A>, _ n: Int) -> A? {
    guard n != 0 else {
        return stream.car
    }

    guard let next = stream.cdr else {
        return nil
    }

    return streamRef(next, n - 1)
}

func streamMap<A, B>(_ fn: @escaping (A) -> B, _ s: Cons<A>) -> Cons<B> {
    guard let next = s.cdr else {
        return Cons(fn(s.car), nil)
    }
    return Cons(fn(s.car), { streamMap(fn, next) })
}

func streamForEach<A, B>(_ fn: (A) -> B, _ s: Cons<A>) {
    guard let next = s.cdr else {
        fn(s.car)
        return
    }

    fn(s.car)
    streamForEach(fn, next)
}

let a = Cons(1, { Cons(2,{ Cons(3, nil) })})
let add1 = { a in a + 1}

//dump(streamForEach({ v in print(v) }, streamMap(add1, a)))

// Fermat test

func expmod(_ base: Int, _ exp: Int, _ m: Int) -> Int {
    if exp == 0 { return 1 }
    if exp % 2 == 0 {
        return square(expmod(base, exp / 2, m))
    }

    return remainder(base * expmod(base, exp - 1, m), m)
}

func square(_ x: Int) -> Int {
    return x * x
}

func remainder(_ a: Int, _ b: Int) -> Int {
    return a % b
}

func fermatTest(_ n: Int) -> Bool {

    func tryIt(_ a: Int) -> Bool {
        return expmod(a, n, n) == a
    }

    return tryIt(Int.random(in: 0 ... n - 1))
}

func streamEnumerateInterval(_ l: Int, _ h: Int) -> Cons<Int> {
    return l == h
        ? Cons(l, nil)
        : Cons(l, { streamEnumerateInterval(l + 1, h) })
}

func memo<A>(_ fn: @escaping () -> A) -> () -> A {
    var result: A?
    return {
        guard let value = result else {
            let value = fn()
            result = value
            return value
        }
        return value
    }
}

//dump(streamEnumerateInterval(10, 100).cdr)

func streamMapOptimised<A, B>(_ fn: @escaping (A) -> B, _ s: Cons<A>) -> Cons<B> {
    guard let next = s.cdr else {
        return Cons(fn(s.car), nil)
    }

    return Cons(fn(s.car), memo({ streamMapOptimised(fn, next) }))
}

func streamCombine<A, B>(_ fn: @escaping (A) -> B, _ s1: Cons<A>, _ s2: Cons<A>) -> Cons<B> {
    guard let next = s1.cdr else {
        return Cons(fn(s1.car), { streamMap(fn, s2) })
    }

    return Cons(fn(s1.car), { streamCombine(fn, next, s2) })
}

//streamForEach(print, streamCombine(square(_:), a, a))

let print: (Int) -> Void = {
    dump($0)
}

let isEven: (Int) -> Bool = { x in x % 2 == 0 }


//let x = streamMap({ print($0) }, streamEnumerateInterval(0, 10))
//streamRef(x, 5)
//streamRef(x, 7)


//let y = streamMapOptimised({ print($0) }, streamEnumerateInterval(0, 10))

//streamRef(y, 5)
//streamRef(y, 7)

var sum = 0

func accum(_ x: Int) -> Int {
    sum += x
    return sum
}

func streamFilter<A>(_ fn: @escaping (A) -> Bool, _ s: Cons<A>) -> Cons<A>? {
    guard let next = s.cdr else {
        return fn(s.car) ? Cons(s.car,  nil) : nil
    }
    return fn(s.car) ? Cons<A>(s.car, { streamFilter(fn, next) }) : streamFilter(fn, next)
}

let seq = streamMap(accum, streamEnumerateInterval(1, 20))
let y = streamFilter({ x in x % 2 == 0 }, seq)!
let z = streamFilter({ x in x % 5 == 0 }, seq)!

streamRef(y, 7)

