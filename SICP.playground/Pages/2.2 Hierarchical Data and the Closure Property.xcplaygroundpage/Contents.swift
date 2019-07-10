
// cons = λx.λy.λz . z x y
func cons<A>(_ x: A, _ y: A) -> ((A, A) -> A) -> A {
    return { f in
        f(x, y)
    }
}

// λz.z(λx.λy.x)
func car<A>(_ cons: ((A, A) -> A) -> A) -> A {
    return cons { (a, b) -> A in
        a
    }
}

// λz.z(λx.λy.y)
func cdr<A>(_ cons: ((A, A) -> A) -> A) -> A {
    return cons { (a, b) -> A in
        b
    }
}

car(cons("A", "B"))
cdr(cons("A", "B"))


