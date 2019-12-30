typealias Wire = Void

func make_wire() -> Wire {}

var a = make_wire()
var b = make_wire()
var c = make_wire()
var d = make_wire()
var e = make_wire()
var s = make_wire()

func and(_ a: Wire, _ b: Wire) -> Wire {}
func or(_ a: Wire, _ b: Wire) -> Wire {}
func inverter(_ a: Wire) -> Wire {}

c = and(a, b)
d = or(a, b)
e = inverter(c)
s = and(d, e)

func halfAdder(_ a: inout Wire, _ b: inout Wire, _ s: inout Wire, _ c: inout Wire) {
    var d = make_wire()
    var e = make_wire()
    d = or(a, b)
    c = and(a, b)
    e = inverter(s)
    s = and(d, e)
}

func fullAdder(_ a: inout Wire, _ b: inout Wire, _ cIn: inout Wire, _ sum: inout Wire, _ cOut: inout Wire) {
    var s = make_wire()
    var c1 = make_wire()
    var c2 = make_wire()
    halfAdder(&b, &cIn, &sum, &c1)
    halfAdder(&a, &s, &sum, &c2)
    cOut = or(c1, c2)
}
