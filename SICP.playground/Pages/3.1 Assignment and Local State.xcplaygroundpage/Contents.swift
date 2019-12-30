func makeAccumulator(_ value: Int) -> (Int) -> Int {
    var current = value
    return { x in
        current += x
        return x
    }
}

let m = makeAccumulator(5)
print(m(10))

enum MonitorFunctionInput<T> {
    case reset
    case callCount
    case value(T)
}

enum MonitorFunctionOutput<T> {
    case reset
    case callCount(Int)
    case value(T)
}

func makeMonitored<A, B>(_ fn: @escaping (A) -> B) -> (MonitorFunctionInput<A>) -> MonitorFunctionOutput<B> {
    var counter = 0
    return { state in
        switch state {
        case .reset:
            counter = 0
            return .reset
        case .value(let value):
            counter += 1
            return .value(fn(value))
        case .callCount:
            return .callCount(counter)
        }
    }
}

let sum = { x in x + 1}

let monitoredFunction = makeMonitored(sum)
let result = monitoredFunction(.value(4))
let callCount = monitoredFunction(.callCount)

switch result {
case .value(let value):
    print(value)
default:
    print("...")
}

switch callCount {
case .callCount(let count):
    print(count)
default:
    print("...")
}

func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    }

    return gcd(b, a % b)
}

func estimatePi(_ trials: Double) -> Double {
    let result: Double = (6 / monteCarlo(trials, cesaroTest))
    return result.squareRoot()
}

func cesaroTest() -> Bool {
    return gcd(Int.random(in: 0 ..< 10), Int.random(in: 0 ..< 10)) == 1
}

func monteCarlo(_ trials: Double, _ experiment: @escaping () -> Bool) -> Double {
    func iter(_ remaining: Double, _ trialsPassed: Double) -> Double {
        guard remaining != 0 else {
            return trialsPassed / trials
        }

        guard !experiment() else {
            return iter(remaining - 1, trialsPassed + 1)
        }

        return iter(remaining - 1, trialsPassed)
    }

    return iter(trials, 0)
}

estimatePi(10)
