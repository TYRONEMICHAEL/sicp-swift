final class Cons<A> {
    private let value: A
    private let children: [Cons<A>]

    init(_ value: A, _ children: [Cons<A>] = []) {
        self.value = value
        self.children = children
    }

    var car: A {
        return value
    }

    var cdr: [Cons<A>] {
        return children
    }

    var isLeaf: Bool {
        return children.count == 0
    }
}

final class Queue<A> {
    private var queue: Cons<A>?
    private var head: Cons<A>?
    private var tail: Cons<A>?

    init(_ value: A) {
        self.head = Cons(value)
        self.tail = self.head
        self.queue = self.head
    }

    func insert(_ value: A) {
        guard let tail = self.tail else {
            self.head = Cons(value)
            self.tail = Cons(value)
            self.queue = self.head
            return
        }
        let v = Cons(value)
        self.tail = v
        self.queue = Cons(tail.car, tail.cdr + [v])
    }
}

let queue = Queue(3)
queue.insert(4)
queue.insert(5)
dump(queue)
