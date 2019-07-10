module.exports = () => {

	// cons = λx.λy.λz . z x y
	let cons = (x, y) => z => z(x, y)
	// λz.z(λx.λy.x)
	let car = z => z((x, y) => x)
	// λz.z(λx.λy.y)
	let cdr = z => z((x, y) => y)

	let listRef = (list, index) => {
		if (index == 0) {
			return car(list)
		}

		return listRef(cdr(list), index - 1)
	}

	let length = (list) => {
		if (list == null) {
			return 0
		}

		return 1 + length(cdr(list))
	}

	let lengthIter = (list) => {
		let length = (list, count) => {
			if (list == null) {
				return count
			}

			length(cdr(list), count + 1)
		}

		return length(list, 0)
	}

	let append = (list1, list2) => {
		if (list1 == null) {
			return list2
		}

		return cons(car(list1), append(cdr(list1), list2))
	}

	let printList = (list) => {
		let getStr = (list, str) => {
			if (list == null) {
				return  `${str})`
			}
			return getStr(cdr(list), `${str}${car(list)} `) 
		}

		let str = getStr(list, "( ")
		console.log(str)
	}

	let list = cons(1, cons(2, cons(3, null)))
	let list2 = cons(4, cons(5, cons(6, null)))
	let list3 = append(list, list2)
	let first = car(list)
	let remaining = cdr(list)
	let item = listRef(list, 1)
	let listLength = length(list)
	let listLengthIter = length(list)
	
	// printList(append(list, list2))

	// Exercise 2.17

	let lastItem = (list) => {
		if(cdr(list) == null) {
			return car(list)
		}

		return lastItem(cdr(list))
	}
	
	//console.log(lastItem(list2))

	// Exercise 2.17

	let reverse = (list) => {
		let reversed = (list, reversedList) => {
			if(car(cdr(list)) == lastItem(list)) {
				return append(cons(car(cdr(list)), cons(car(list), null)), reversedList)
			}

			return reversed(
				cdr(cdr(list)), 
				append(cons(car(cdr(list)), cons(car(list), null)), reversedList)
			)
		}

		return reversed(list, null)
	}

	let betterReverse = (list) => {
		if(cdr(list) == null) {
			return list
		}

		return append(betterReverse(cdr(list)), cons(car(list), null))
	}

	// Exercise 2.20

	let makeConsList = (arr) => {
		if (arr.length == 0) {
			return null
		}

		return append(makeConsList(arr.slice(0, -1)), cons(arr[arr.length - 1], null))
	}

	let sameParity = (...args) => {
		let isEven = (n) => n % 2 == 0 
		let isOdd = (n) => !isEven(n)

		let parity = (list, pred) => {
			if(cdr(list) == null) {
				return pred(car(list)) ? list : null
			}
			
			if(!pred(car(list))) {
				return parity(cdr(list), pred) 
			}

			return append(
				cons(car(list), null),
				parity(cdr(list), pred)
			)
		}

		return parity(makeConsList(args), isEven(car(makeConsList(args))) ? isEven : isOdd)
	}

	// Maps

	let map = (fn, list) => {
		if(list == null) {
			return null
		}

		return cons(fn(car(list)), map(fn, cdr(list)))
	}

	let times2 = (n) => n * 2

	// printList(map(times2, list))

	// 2.21

	let square = (n) => n * n

	let squareList = (items) => {
		if (items == null) {
			return null
		}

		return cons(square(car(items)), squareList(cdr(items)))
	}

	let mapSquareList = (items) => {
		return map(square, items)
	}

	printList(mapSquareList(list))

	// 2.23

	let print = (v) => console.log(v)

	let foreach = (fn, list) => {
		if(list == null) {
			return null
		}

		fn(car(list))
		foreach(fn, cdr(list))
	}

	foreach(print,list)

}