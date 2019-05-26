// a = 1 + xy
// b = 1 - y
// f(x, y) = xa^2 + yb

func f(_ x: Int, _ y: Int) -> Int {
    return { a, b in (x * a * a) + (y * b) }(1 + (x * y), 1 - y)
}

f(3, 3)

func xOf5(_ x: Int) -> Int {
    return { x in x + (x * 10) }(3) + x
}

xOf5(5)

func xOfY(_ x: Int) -> Int {
    return { x in x }(3) * { x + 2 }()
}

xOfY(2)
