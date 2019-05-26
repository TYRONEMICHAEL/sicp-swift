// Calculating Factorial using linear recursive process

func factorial(_ n: Int) -> Int {
    if n == 1 {
        return 1
    }

    return n * factorial(n - 1)
}

factorial(6)

// Calculating Factorial using linear iterative process

func iterFactorial(_ product: Int, _ counter: Int) -> Int {
    if counter == 1 {
        return product
    }

    return iterFactorial(counter * product, counter - 1)
}

iterFactorial(1, 5)
