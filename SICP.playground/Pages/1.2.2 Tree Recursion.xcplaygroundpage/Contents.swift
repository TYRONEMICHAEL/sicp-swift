// Fibonacci using tree recursion
// 0 1 1 2 3 5 8 13 21

func fib(_ x: Int) -> Int {
    if x == 0 { return 0 }
    if x == 1 { return 1 }

    return fib(x - 1) + fib(x - 2)
}

fib(8)

// Fibonacci using iteration
// 0 1 1 2 3 5 8 13 21

func fibIter(_ x: Int, _ v: Int, _ prev: Int, _ counter: Int = 0) -> Int {
    if counter == x + 1 { return v }
    if counter == 0 { return fibIter(x, 0, 0, counter + 1) }
    if counter == 1 { return fibIter(x, 1, 0, counter + 1) }

    return fibIter(x, v + prev, v, counter + 1)
}

fibIter(8, 0, 0)

// Exercise 1.11
// Recursive

func f(_ n: Int) -> Int {
    if n < 3 { return n }
    return f(n - 1) + (2 * f(n - 2)) + (3 * f(n - 3))
}

f(7)

// Exercise 1.11
// Iterative

func fIter(_ n: Int, _ a: Int, _ b: Int, _ c: Int, _ counter: Int = 0) -> Int {
    if counter == n { return a }
    return fIter(n, a + (2 * b) + (3 * c), a, b, counter + 1)
}

fIter(6, 2, 1, 0, 2)

// Exercise 1.12

func pascal(_ row: Int, _ column: Int) -> Int {
    if row == 1 || column == 1 || column == row {
        return 1
    }

    return pascal(row - 1, column - 1) + pascal(row - 1, column)
}

pascal(5, 3)
