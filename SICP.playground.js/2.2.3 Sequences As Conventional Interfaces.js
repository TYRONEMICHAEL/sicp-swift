module.exports = () => {
	// cons = λx.λy.λz . z x y
	let cons = (x, y) => z => z(x, y)
	// λz.z(λx.λy.x)
	let car = z => z((x, y) => x)
	// λz.z(λx.λy.y)
	let cdr = z => z((x, y) => y)

	let isPair = (list) => {
		return typeof(list) != 'number'
	}

	let printList = (list) => {
		let getStr = (list) => {
			if(!isPair(list)) {
				return `${list}`
			}

			if (list == null) {
				return ''
			}
			return `(${getStr(car(list))}${getStr(cdr(list))})`
		}
		
		console.log(getStr(list))
	}

	let accumulate = (fn, initial, sequence) => {
		if (sequence == null) {
			return initial
		}

		return fn(car(sequence), accumulate(fn, initial, cdr(sequence)))
	}

	let list2 = cons(1, cons(2, cons(3, cons(4, null))))
	let list3 = cons(5, cons(6, cons(7, cons(8, null))))

	let add = (initial, result) =>  initial + result
	let result = accumulate(add, 0, list2)
	console.log(result)

	let map = (p , sequence) => {
		return accumulate(function(value, result) {
			return cons(p(value), result)
		}, null, sequence)
	}

	let append = (seq1, seq2) => {
		return accumulate(cons, seq2, seq1)
	}

	let square = (n) => n * n

	let length = (sequence) => {
		return accumulate(function(value, result) {
			return result + 1
		}, 0, sequence)
	}

	// printList(map(square, list2))
	printList(append(list2, list3))
	console.log(length(append(list2, list3)))

	let fringe = (list) => {
		printList(list)
		if(!isPair(list)) {
			return cons(list, null)
		}

		if (list == null) {
			return null
		}

		return append(fringe(car(list)), fringe(cdr(list)))
	}

	let countLeaves = (t) => {
		return accumulate(function(value, result) {
			return value + result
		}, 0, map(function(n) {
			if(isPair(n)) {
				return countLeaves(n)
			}
			return 1
		}, t))
	}

	let list4 = cons(cons(1, cons(2, cons(3, cons(4, cons(5, null))))), cons(6, cons(7, null)))
	console.log(countLeaves(list4))
	
}