import Foundation

func dropFirst(_ a: [String]) -> [String] {
    return Array(a.dropFirst())
}

func car(_ a: [String]) -> String {
    return a[0]
}

func cdr(_ a: [String]) -> [String] {
    return dropFirst(a)
}

func caddr(_ a: [String]) -> [String] {
    return dropFirst(dropFirst(a))
}

func memq(_ x: String, list: [String]) -> [String] {
    if list.isEmpty {
        return []
    }

    if x == list[0] {
        return list
    }

    return memq(x, list: cdr(list))
}

//dump(memq("Hello", list: ["Hellos", "World", "Hello"]))

func equal(_ a: [String], _ b: [String]) -> Bool {
    if a.isEmpty && b.isEmpty {
        return true
    }

    guard a.count == b.count else {
        return false
    }

    guard a[0] == b[0] else {
        return false
    }

    return equal(cdr(a), cdr(b))
}

//print(equal(["Hello", "Worlsd"], ["Hello", "World"]))

let primitives = ["+", "*"]

func isVariable(_ x: UnicodeScalar) -> Bool {
    return CharacterSet.letters.contains(x)
}

func areVariablesEqual(_ x: UnicodeScalar, _ y: UnicodeScalar) -> Bool {
    return isVariable(x) && isVariable(y) && x == y
}

func makeSum(_ x: String, _ y: String) -> [String] {
    return ["+", x, y]
}

func makeProduct(_ x: String, _ y: String) -> [String] {
    return ["*", x, y]
}

func sum(_ a: [String]) -> Bool {
    return car(a) == "+"
}

func product(_ a: [String]) -> Bool {
    return car(a) == "*"
}


areVariablesEqual("x", "y")
