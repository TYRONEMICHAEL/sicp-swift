import Foundation

struct Set<A:Equatable> {
    let values: [A]

    init(_ values: [A] = []) {
        self.values = values
    }

    func insert(_ value: A) -> Set<A> {
        guard !contains(value) else { return self }
        return Set<A>(values + [value])
    }

    func car() -> A {
        return values[0]
    }

    func cdr() -> Set<A> {
        return Set<A>(Array(values.dropFirst()))
    }

    func isEmpty() -> Bool {
        return values.isEmpty
    }

    func contains(_ value: A) -> Bool {
        return values.contains(value)
    }

}

func intersection<A: Equatable>(_ a: Set<A>, _ b: Set<A>) -> Set<A> {
    if a.isEmpty() || b.isEmpty()  {
        return Set<A>()
    }

    if b.contains(a.car()) {
        return Set<A>([a.car()] + intersection(a.cdr(), b).values)
    }

    return intersection(a.cdr(), b)
}

func union<A: Equatable>(_ a: Set<A>, _ b: Set<A>) -> Set<A> {
    if a.isEmpty() || b.isEmpty()  {
        return a.isEmpty() ? b : a
    }

    if b.contains(a.car()) {
        return union(a.cdr(), b)
    }

    return Set<A>([a.car()] + union(a.cdr(), b).values)
}

let a = Set<Int>([1, 3, 5, 6, 10])
let b = Set<Int>([3, 5, 6, 7, 8, 9])

func intersectionOrderedSet<A: Equatable & Comparable>(_ a: Set<A>, _ b: Set<A>) -> Set<A> {
    if a.isEmpty() || b.isEmpty() {
        return Set<A>()
    }

    return a.car() == b.car()
        ? Set<A>([a.car()] + intersectionOrderedSet(a.cdr(), b.cdr()).values)
        : a.car() > b.car()
        ? intersectionOrderedSet(a, b.cdr())
        : intersectionOrderedSet(a.cdr(), b)
}

//dump(intersectionOrderedSet(a, b))

func hasElement<A: Equatable & Comparable>(_ e: A, _ s: Set<A>) -> Bool {
    guard !s.isEmpty() else {
        return false
    }

    guard e != s.car() else {
        return true
    }

    return e > s.car() ? hasElement(e, s.cdr()) : false
}

func adjoinSet<A: Equatable & Comparable>(_ a: A, _ s: Set<A>) -> Set<A> {
    guard !s.isEmpty() else {
        return Set<A>([a])
    }

    return a == s.car() ? s : a < s.car()
        ? Set<A>([a] + s.values)
        : Set<A>([s.car()] + adjoinSet(a, s.cdr()).values)
}

func unionOrderedSet<A: Equatable & Comparable>(_ a: Set<A>, _ b: Set<A>) -> Set<A> {
    if a.isEmpty() || b.isEmpty() {
        return a.isEmpty() ? b : a
    }

    return a.car() == b.car()
        ? Set<A>([a.car()] + unionOrderedSet(a.cdr(), b.cdr()).values)
        : a.car() < b.car()
        ? Set<A>([a.car()] + unionOrderedSet(a.cdr(), b).values)
        : Set<A>([b.car()] + unionOrderedSet(a, b.cdr()).values)
}

dump(unionOrderedSet(a, b))

