import Foundation

// Euclid's Algorithm

func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    }

    return gcd(b, a % b)
}

gcd(200, 40)

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

expmod(5, 11, 11)

func fermatTest(_ n: Int) -> Bool {

    func tryIt(_ a: Int) -> Bool {
        return expmod(a, n, n) == a
    }

    return tryIt(Int.random(in: 0 ... n - 1))
}

fermatTest(13)

func fastPrime(_ n: Int, _ times: Int) -> Bool {
    guard fermatTest(n) else {
        return false
    }

    if times == 0 {
        return true
    }

    return fastPrime(n, times - 1)
}

fastPrime(12, 2)

// Exercise 1.21

func smallestDivisor(_ n: Int) -> Int {

    func isDivisor(_ a: Int, _ b: Int) -> Bool {
        return b % a  == 0
    }

    func findDivisor(_ a: Int, _ b: Int) -> Int {
        if square(a) > b { return b }
        if isDivisor(a, b) { return a }
        return findDivisor(a + 1, b)
    }

    return findDivisor(2, n)
}

smallestDivisor(199)
smallestDivisor(1999)
smallestDivisor(19999)

// Exercise 1.22 & 1.23

func measure(_ title: String, block: (@escaping () -> ()) -> ()) {

    let startTime = CFAbsoluteTimeGetCurrent()

    block {
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("\(title):: Time: \(timeElapsed)")
    }
}

func searchForPrimes(start: Int, count: Int) -> [Int] {
    func search(start: Int, count: Int, result: [Int]) -> [Int] {
        func isPrime(n: Int) -> Bool {
            return smallestDivisor(n) == n
        }

        if result.count == count {
            return result
        }

        if isPrime(n: start) {
            return search(start: start + 2, count: count, result: result + [start])
        }

        return search(start: start + 2, count: count, result: result)
    }

    return search(start: start, count: count, result: [])
}


measure("Primes for 1001") { finish in
    searchForPrimes(start: 1001, count: 3)
    finish()
}

measure("Primes for 10001") { finish in
    searchForPrimes(start: 10001, count: 3)
    finish()
}

measure("Primes for 100001") { finish in
    searchForPrimes(start: 100001, count: 3)
    finish()
}

measure("Primes for 1000001") { finish in
    searchForPrimes(start: 1000001, count: 3)
    finish()
}

// Exercise 1.24
// Numbers get too large to compute as Ints

func searchForPrimesFermat(start: Int, count: Int) -> [Int] {
    func search(start: Int, count: Int, result: [Int]) -> [Int] {
        func isPrime(n: Int) -> Bool {
            return fermatTest(n)
        }

        if result.count == count {
            return result
        }

        if isPrime(n: start) {
            return search(start: start + 2, count: count, result: result + [start])
        }

        return search(start: start + 2, count: count, result: result)
    }

    return search(start: start, count: count, result: [])
}
