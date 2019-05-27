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

func average(_ x: Double, _ y: Double) -> Double {
    return (x + y) / 2
}

func averageDamp(_ f: @escaping (Double) -> Double) -> (Double) -> Double {
    return { x in
        average(x, f(x))
    }
}

func fixedPoint(_ f: @escaping (Double) -> Double, _ guess: Double) -> Double {
    let nextGuess = { x in f(x) }

    return isCloseEnough(guess, nextGuess(guess))
        ? nextGuess(guess)
        : fixedPoint(f, nextGuess(guess))
}

let square: (Double) -> Double = { x in x * x }
let cube: (Double) -> Double = { x in x * x * x }

averageDamp(square)(10)

func sqrt(_ x: Double) -> Double {
    return fixedPoint(averageDamp({ y in x / y }), 1.0)
}

sqrt(9)

func cubeRoot(_ x: Double) -> Double {
    return fixedPoint(averageDamp({ y in x / square(y) }), 1.0)
}

cubeRoot(27)

func deriv(_ g: @escaping (Double) -> Double) -> (Double) -> Double {
    let dx = 0.00001
    return { x in
        (g(x + dx) - g(x)) / dx
    }
}

deriv(cube)(5)

func newtonsTransform(_ g: @escaping (Double) -> Double) -> (Double) -> Double {
    return { x in
        x - (g(x) / deriv(g)(x))
    }
}

func newtonsMethod(_ g: @escaping (Double) -> Double, _ x: Double) -> Double {
    return fixedPoint(newtonsTransform(g), x)
}

func newtonSqrt(_ x: Double) -> Double {
    return newtonsMethod({ y in square(y) - x }, 1.0)
}

newtonSqrt(9)

// Exercise 1.41

func double(_ g: @escaping (Double) -> Double) -> (Double) -> Double {
    return { x in
        g(g(x))
    }
}

let inc: (Double) -> Double = { x in x + 1 }

double(inc)(0)

double(double(inc))(5)

// Exercise 1.42

func compose<A, B, C>(_ f: @escaping (B) -> C, _ g: @escaping (A) -> B) -> (A) -> C {
    return { a in
        f(g(a))
    }
}

compose(square, inc)(6)
