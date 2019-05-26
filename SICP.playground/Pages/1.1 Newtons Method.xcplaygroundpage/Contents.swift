// 1.1.7 Square Roots By Newton

// Create a method that takes in a (guess) and the value (x) to be find the square root for
// if (guess) is good enough against (x) then return guess otherwise continue
// If (guess) is not good enough improve the guess and call this method again with the improved guess

// Create a method that checks if (guess) is good enough
// Determine what is good enough by defining a value tolerance
// Square guess and get the difference between (x)
// If it is less than the tolerance it is good enough otherwise it is not

// Create a method that improves the guess by getting the [quotient] of the guess: (x / guess)
// Get the of the improved guess by taking getting an average of the [guess] and [quotient]: (guess + quotient) / 2

func squareIter(_ guess: Double, _ x: Double) -> Double {
    if isGoodEnough(guess, x) {
        return guess
    }

    return squareIter(improveGuess(guess, x), x)
}

func isGoodEnough(_ guess: Double, _ x: Double) -> Bool {
    return abs(guess * guess - x) < 0.001
}

func improveGuess(_ guess: Double, _ x: Double) -> Double {
    return ((x / guess) + guess) / 2
}

// Improved Square Iter

func improvedSquareIter(_ guess: Double, _ prevGuess: Double, _ x: Double) -> Double {
    if improvedIsGoodEnough(guess, prevGuess) {
        return guess
    }

    return improvedSquareIter(improveGuess(guess, x), guess, x)
}

func improvedIsGoodEnough(_ guess: Double, _ prevGuess: Double) -> Bool {
    return abs(guess - prevGuess) < 0.001
}

squareIter(1, 2)
improvedSquareIter(1, 0, 10000000000000)
