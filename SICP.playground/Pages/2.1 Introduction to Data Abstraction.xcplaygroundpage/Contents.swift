import Foundation

typealias Cons<A, B> = (A, B)

func car<A, B>(_ c: (A, B)) -> A {
    return c.0
}

func cdr<A, B>(_ c: (A, B)) -> B {
    return c.1
}

let makeRat: (Double, Double) -> Cons<Double, Double> = { a, b in (a, b) }
let getPrintValue: (Cons<Double, Double>) -> String = { x in return "\(car(x))/\(cdr(x))" }
let printRat: (Cons<Double, Double>) -> () = { x in dump(getPrintValue(x)) }

let oneHalf = (1.0, 2.0)
printRat(oneHalf)

let oneThird = (1.0, 3.0)
printRat(oneThird)

let multRat: (Cons<Double, Double>, Cons<Double, Double>) -> Cons<Double, Double> = { a, b in
    return (car(a) * car(b), cdr(a) * cdr(b))
}

printRat(multRat(oneHalf, oneThird))

func gcd(_ a: Double, _ b: Double) -> Double {
    if b == 0 {
        return a
    }

    return gcd(b, a.truncatingRemainder(dividingBy: b))
}

let makeRatGcd: (Double, Double) -> Cons<Double, Double> = { a, b in
    let g = gcd(a, b)
    return (a / g, b / g)
}

let addRat: (Cons<Double, Double>, Cons<Double, Double>) -> Cons<Double, Double> = { a, b in
    let a1 = makeRatGcd(car(a), cdr(a))
    let b1 = makeRatGcd(car(b), cdr(b))
    return (car(a1) + car(b1), cdr(a1))
}

printRat(addRat(oneThird, oneThird))

// Exercise 2.1

let betterMakeRat: (Double, Double) -> Cons<Double, Double> = {
    a, b in
    a / b > 0 ? (a, b) : (-a, b)
}

// Exercise 2.2

typealias Point = (x: Double, y: Double)
typealias Segment = (start: Point, end: Point)

func avg(_ a: Double, _ b: Double) -> Double {
    return (a + b) / 2
}

func makeSegment(_ start: Point, end: Point) -> Segment {
    return (start, end)
}

func start(_ segment: Segment) -> Point {
    return car(segment)
}

func end(_ segment: Segment) -> Point {
    return cdr(segment)
}

func makePoint(_ x: Double, _ y: Double) -> Point {
    return (x, y)
}

func xPoint(_ point: Point) -> Double {
    return car(point)
}

func yPoint(_ point: Point) -> Double {
    return cdr(point)
}

let midPoint: (Segment) -> Point = { segment in
    let s = start(segment)
    let e = end(segment)

    let avgX = avg(xPoint(s), xPoint(e))
    let avgY = avg(yPoint(s), yPoint(e))

    return (avgX, avgY)
}

let segment = makeSegment(makePoint(3, 2), end: makePoint(6, 8))
let mid = midPoint(segment)

dump(mid)

func cons<A>(_ a: A, _ b: A) -> (Int) -> A {
    return { index in
        index == 0 ? a : b
    }
}

func car<A>(_ z: (Int) -> A) -> A {
    return z(0)
}

func cdr<A>(_ z: (Int) -> A) -> A {
    return z(1)
}

let c = cons(1, 2)
print(car(c))
print(cdr(c))

// Exercise 2.4

typealias Cons1<A> = (_ a: A, _ b: A) -> A
typealias ConExecution<A> = (_ fn: Cons1<A>) -> A

func cons1<A>(_ a: A, _ b: A) -> ConExecution<A> {
    return { fn in
        fn(a, b)
    }
}

func car1<A>(_ z: ConExecution<A>) -> A {
    let fn: (A, A) -> A = { a, b in a }
    return z(fn)
}

func cdr1<A>(_ z: ConExecution<A>) -> A {
    let fn: (A, A) -> A = { a, b in b }
    return z(fn)
}

let c1 = cons1(1, 2)
print(car1(c1))
print(cdr1(c1))

// Exercise 2.5

func expo(_ n: Double, _ x: Double) -> Double {
    if x == 0 {
        return 1
    }

    return n * expo(n, x - 1)
}

func consArith(_ a: Double, _ b: Double) -> Double {
    guard a > 0 && b > 0 else { fatalError("Must be above 0") }
    return expo(a, 2) * expo(b, 3)
}

func countFactors(_ n: Double, _ f: Double) -> Double {
    func iter(_ remaining: Double, _ result: Double) -> Double {
        print(remaining, result)
        if remaining.truncatingRemainder(dividingBy: f) == 0 {
            return iter(remaining / f, result + 1)
        }

        return result
    }

    return iter(n, 0)
}

func cdr2(_ n: Double) -> Double {
    return countFactors(n, 3)
}

func car2(_ n: Double) -> Double {
    return countFactors(n, 2)
}


let c2 = consArith(21, 14)
dump(cdr2(c2))

// Exercise 2.6

// SUCC = n => f => x => f(n(f)(x))
// n: function that takes in f
// f: function that takes in x
// x: function that produces the result of f

// λn.λf.λx.f(nfx)

typealias X<A, B> = (A) -> B
typealias F<B, C> = (B) -> C
typealias N<A, B, C> = (@escaping F<B, C>) -> X<A, B>

func successor<A, B, C>(_ n: @escaping N<A, B, C>) -> (@escaping F<B, C>) -> (A) -> C {
    return { f in
        return { x in
            return f(n(f)(x))
        }
    }
}

func zero<A, B>(_ a: A) -> (B) -> B {
    return { b in
        b
    }
}

func one<A>(_ f: @escaping (A) -> A) -> (A) -> A {
    return { x in
        return successor(zero)(f)(x)
    }
}

func two<A>(_ f: @escaping (A) -> A) -> (A) -> A {
    return { x in
        return successor(one)(f)(x)
    }
}

let x = 0
let inc: (Int) -> Int = { x in x + 1 }
let result = one(inc)(x)
let result2 = two(inc)(x)

// Exercise 2.7

typealias Interval = (upper: Double, lower: Double)

func makeInterval(_ upper: Double, _ lower: Double) -> Interval {
    return (upper, lower)
}

func upperBound(_ interval: Interval) -> Double {
    return interval.upper
}

func lowerBound(_ interval: Interval) -> Double {
    return interval.lower
}

// Exercise 2.8

func subInterval(_ a: Interval, _ b: Interval) -> Interval {
    return (upper: a.lower - b.upper,  lower: a.upper - b.lower)
}

// Exercise 2.9

// ... Quite mathematical (not familiar with interval arithmetic) skipping as an additional exercise.
