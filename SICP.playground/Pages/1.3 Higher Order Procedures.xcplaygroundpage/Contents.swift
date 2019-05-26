func sum<A: Numeric & Comparable>(_ term: (A) -> A, _ a: A, _ next: (A) -> A, _ b: A) -> A {
    if a > b {
        return 0
    }
    return term(a) + sum(term, next(a), next, b)
}

let cube: (Int) -> Int = { a in a * a * a }
let iter: (Int) -> Int = { a in a + 1 }
let sumOfCubes: (Int, Int) -> Int = { a, b in sum(cube, a, iter, b) }

sumOfCubes(1, 3)

let identity: (Int) -> Int = { a in a }
let sumOfIntegers: (Int, Int) -> Int = { a, b in sum(identity, a, iter, b) }

sumOfIntegers(1, 10)

let piTerm: (Double) -> Double = { x in  1.0 / (x * (x + 2)) }
let piIter: (Double) -> Double = { x in x + 4 }
let piSum: (Double, Double) -> Double = { a, b in sum(piTerm, a, piIter, b) }

8 * piSum(1, 1000)

func integral( _ f: (Double) -> Double, _ a: Double, _ b: Double, _ dx: Double) -> Double {
    let addDx: (Double) -> Double = { x in x + dx }
    return dx * sum(f, a + (dx / 2.0), addDx, b)
}

let cubeDouble: (Double) -> Double = { a in a * a * a }
let iterDouble: (Double) -> Double = { a in a + 1 }

integral(cubeDouble, 0, 1, 0.01)

// Exercise 1.29

func simpson( _ f: @escaping (Double) -> Double, _ a: Double, _ b: Double, _ n: Double) -> Double {
    let h: () -> Double = {  (b - a) / n }
    let y: (Double) -> Double = { k in f(a + (k * h())) }
    let term: (Double) -> Double = { k in
        k == 0 || k == n
            ? 1
            : k.truncatingRemainder(dividingBy: 2) == 0
            ? 2 * y(k)
            : 4 * y(k)
    }

    return sum(term, 0, iterDouble, n) * (h() / 3)
}

simpson(cubeDouble, 0, 1, 1000)

// Exercise 1.30

func sumIter<A: Numeric & Comparable>(_ term: @escaping (A) -> A, _ a: A, _ next: @escaping (A) -> A, _ b: A) -> A {
    func iter(_ a: A, _ result: A) -> A {
        if a > b {
            return result
        }

        return iter(next(a), result + term(a))
    }

    return iter(a, 0)
}

let sumOfCubesIter: (Int, Int) -> Int = { a, b in sumIter(cube, a, iter, b) }

sumOfCubesIter(1, 3)

// Exercise 1.31

func product<A: Numeric & Comparable>(_ term: @escaping (A) -> A, _ a: A, _ next: @escaping (A) -> A, _ b: A) -> A {

    if a > b {
        return 1
    }

    return term(a) * product(term, next(a), next, b)
}

let factorial: (Int, Int) -> Int = { a, b in product(identity, a, iter, b) }

factorial(1, 5)

func productIter<A: Numeric & Comparable>(_ term: @escaping (A) -> A, _ a: A, _ next: @escaping (A) -> A, _ b: A) -> A {

    func iter(_ a: A, _ result: A) -> A {
        if a > b {
            return result
        }

        return iter(next(a), result * term(a))
    }

    return iter(a, 1)
}

let factorialIter: (Int, Int) -> Int = { a, b in productIter(identity, a, iter, b) }

factorialIter(1, 6)

// Exercise 1.32

func accumulate<A: Numeric & Comparable>(_ combiner: (A, A) -> A, _ nullValue: A, _ term: @escaping (A) -> A, _ a: A, _ next: @escaping (A) -> A, _ b: A) -> A {
    if a > b {
        return nullValue
    }

    return combiner(term(a), accumulate(combiner, nullValue, term, next(a), next, b))
}


let sum: (Int, Int) -> Int = { a, b in accumulate(+, 0, identity, a, iter, b) }
let product: (Int, Int) -> Int = { a, b in accumulate(*, 1, identity, a, iter, b) }
sum(1, 10)
product(1, 5)

func accumulateIter<A: Numeric & Comparable>(_ combiner: @escaping (A, A) -> A, _ nullValue: A, _ term: @escaping (A) -> A, _ a: A, _ next: @escaping (A) -> A, _ b: A) -> A {

    func iter(_ a: A, _ result: A) -> A {
        if a > b {
            return result
        }

        return iter(next(a), combiner(term(a), result))
    }

    return iter(a, nullValue)
}

let sumIter: (Int, Int) -> Int = { a, b in accumulateIter(+, 0, identity, a, iter, b) }
let productIter: (Int, Int) -> Int = { a, b in accumulateIter(*, 1, identity, a, iter, b) }
sumIter(1, 10)
productIter(1, 5)

// Exercise 1.33

func accumulateFilter<A: Numeric & Comparable>(_ pred: (A) -> Bool, _ combiner: (A, A) -> A, _ nullValue: A, _ term: @escaping (A) -> A, _ a: A, _ next: @escaping (A) -> A, _ b: A) -> A {
    if a > b {
        return nullValue
    }

    if pred(a) {
        return combiner(term(a), accumulateFilter(pred, combiner, nullValue, term, next(a), next, b))
    }

    return combiner(nullValue, accumulateFilter(pred, combiner, nullValue, term, next(a), next, b))
}

let even: (Int) -> Bool = { a in a % 2 == 0 }
let evenSum: (Int, Int) -> Int = { a, b in accumulateFilter(even, +, 0, identity, a, iter, b) }

evenSum(1, 4)
