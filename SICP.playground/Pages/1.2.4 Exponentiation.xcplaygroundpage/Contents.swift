// Finding the exponentiation of a number using recursion

func expo(_ n: Int, _ x: Int) -> Int {
    if x == 0 {
        return 1
    }

    return n * expo(n, x - 1)
}

expo(3, 20)

// Finding the exponentiation of a number iteratively

func expoIter(_ n: Int, _ x: Int, _ v: Int) -> Int {
    if x == 0 {
        return v
    }

    return expoIter(n, x - 1, v * n)
}

expoIter(3, 4, 1)

// Finding the exponentiation of a number using successive squaring

func fastExpo(_ b: Int, _ n: Int) -> Int {
    if n == 0 {
        return 1
    }

    if n % 2 == 0 {
        return square(fastExpo(b, n / 2))
    }

    return b * fastExpo(b, n - 1)
}

func square(_ x: Int) -> Int {
    return x * x
}


fastExpo(1, 1000)

// Finding the exponentiation of a number using successive squaring iteratively

func fastExpoIter(_ a: Int, _ b: Int, _ n: Int) -> Int {
    if n == 0 {
        return a
    }

    if n % 2 == 0 {
        return fastExpoIter(a, b * b, n / 2)
    }

    return fastExpoIter(a * b, b, n - 1)
}

fastExpoIter(1, 3, 5)

// 1.17 Repeated addition using successive squaring and recursion

func m(_ a: Int, _ b: Int) -> Int {
    if b == 0 { return 0 }
    return a + (m(a, b - 1))
}

m(5, 5)

func fastM(_ a: Int, _ b: Int) -> Int {
    if b == 0 { return 0 }
    if b % 2 == 0 {
        return double(a) + fastM(a, half(b))
    }
    return a + (fastM(a, b - 1))
}

func double(_ x: Int) -> Int {
    return x * 2
}

func half(_ x: Int) -> Int {
    return x / 2
}

fastM(5, 100)

// 1.17 Repeated addition using successive squaring iteratively

func fastIterM(_ a: Int, _ b: Int, _ c: Int) -> Int {
    if c == 0 { return a }
    if b % 2 == 0 {
        return fastIterM(a, double(b), half(c))
    }
    return fastIterM(a + b, b, c - 1)
}

fastIterM(0, 3, 6)
