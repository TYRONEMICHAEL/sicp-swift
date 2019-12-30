func makeAccumulator(_ value: Int) -> (Int) -> Int {
    var current = value
    return { x in
        current += x
        return x
    }
}

func makeAccumulatorNoAssignment(_ value: Int) -> (Int) -> Int {
    return { x in
        return value + x
    }
}
