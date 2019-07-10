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

	let length = (list) => {
		if (list == null) {
			return 0
		}

		return 1 + length(cdr(list))
	}

	let countLeaves = (list) => {
		if (list == null) {
			return 0
		}

		if(!isPair(list)) {
			return 1
		}

		return countLeaves(car(list)) + countLeaves(cdr(list))
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

	let list = cons(cons(1, cons(2, null)), cons(cons(3, cons(4, null))))

	//console.log(countLeaves(list))

	// Ex 2.27

	let append = (list1, list2) => {
		if (list1 == null) {
			return list2
		}

		return cons(car(list1), append(cdr(list1), list2))
	}

	let deepReverse = (list) => {
		if (list == null) {
			return list
		}

		if(!isPair(list)) {
			return list
		}

		return append(deepReverse(cdr(list)), cons(deepReverse(car(list)), null))
	}

	printList(deepReverse(list))

	// Ex 2.28

	let fringe = (list) => {
		if(!isPair(list)) {
			return cons(list, null)
		}

		if (list == null) {
			return null
		}

		return append(fringe(car(list)), fringe(cdr(list)))
	}
	
	printList(fringe(list))
	printList(cons(1, cons(2, cons(3, cons(4, null)))))

	// Mapping Trees

	// Ex 2.30 
	let square = (n) => n * n
	let list2 = cons(cons(1, cons(2, cons(3, cons(4, cons(5, null))))), cons(6, cons(7, null)))

	let squareTrees = (tree) => {
		if(!isPair(tree)) {
			return square(tree)
		}

		if(tree == null) {
			return null
		}

		return cons(squareTrees(car(tree)), squareTrees(cdr(tree)))
	}

	let map = (fn, list) => {
		if(list == null) {
			return null
		}

		return cons(fn(car(list)), map(fn, cdr(list)))
	}

	let squareTreesMap = (tree) => {
		return map(function(subtree) {
			if(!isPair(subtree)) {
				return square(subtree)
			}

			return squareTreesMap(subtree)
		}, tree)
	}

	printList(list2)
	printList(squareTrees(list2))
	printList(squareTreesMap(list2))

}