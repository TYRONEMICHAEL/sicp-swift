import Foundation

func isCloseEnough(_ x: Double, _ y: Double) -> Bool {
    return abs(x - y) < 0.001
}

func isPositive(_ x: Double) -> Bool {
    return x > 0
}

func isNegative(_ x: Double) -> Bool {
    return !isPositive(x)
}

func search(_ f: (Double) -> Double, _ negPoint: Double, _ posPoint: Double) -> Double {
    let midPoint = { x, y in (x + y) / 2 }(negPoint, posPoint)
    let testValue = { x in f(x) }(midPoint)

    if isCloseEnough(negPoint, posPoint) {
        return midPoint
    }

    return isPositive(testValue)
        ? search(f, negPoint, midPoint)
        : isNegative(testValue)
        ? search(f, midPoint, posPoint)
        : midPoint
}

let f: (Double) -> Double = { x in (x * x * x) - (2 * x) - 3 }
search(f, 1.0, 2.0)

func fixedPoint(_ f: @escaping (Double) -> Double, _ guess: Double) -> Double {
    let nextGuess = { x in f(x) }

    return isCloseEnough(guess, nextGuess(guess))
        ? nextGuess(guess)
        : fixedPoint(f, nextGuess(guess))
}

fixedPoint(cos, 1.0)

let fixedSinCos: (Double) -> Double = { y in sin(y) + cos(y) }

fixedPoint(fixedSinCos, 1.0)

func sqrt(_ x: Double) -> Double {
    let avg = { y in (y + (x / y)) / 2 }
    return fixedPoint(avg, x)
}

sqrt(10)

//// Exercise 1.35
func goldenRatio(_ x: Double) -> Double {
    let ratio: (Double) -> Double = { x in 1 + (1 / x) }
    return fixedPoint(ratio, x)
}

goldenRatio(1)
