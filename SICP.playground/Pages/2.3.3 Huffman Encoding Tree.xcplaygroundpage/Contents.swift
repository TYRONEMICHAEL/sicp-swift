import Foundation

enum BinaryTree<T> {
    case empty
    indirect case node(BinaryTree, [T], Int, BinaryTree)
    indirect case leaf(T, Int)
}

func makeLeaf(_ symbol: String, _ weight: Int) -> BinaryTree<String> {
    return .leaf(symbol, weight)
}

func isLeaf(_ tree: BinaryTree<String>) -> Bool {
    switch tree {
    case .leaf(_, _):
        return true
    default:
        return false
    }
}

func getSymbol(_ tree: BinaryTree<String>) -> [String] {
    switch tree {
    case .leaf(let symbol, _):
        return [symbol]
    case .node(_, let symbol, _, _):
        return symbol
    default:
        return []
    }
}

func getWeight(_ tree: BinaryTree<String>) -> Int? {
    switch tree {
    case .leaf(_, let weight):
        return weight
    default:
        return nil
    }
}

func makeCodeTree(_ left: BinaryTree<String>, _ right: BinaryTree<String>) -> BinaryTree<String>? {

    switch (left, right) {
    case (let .leaf(leftSymbol, leftWeight), let .leaf(rightSymbol, rightWeight)):
        return .node(left, [leftSymbol, rightSymbol], leftWeight + rightWeight, right)
    case (let .leaf(leftSymbol, leftWeight), let .node(_ , rightSymbol, rightWeight, _)):
        return .node(left, [leftSymbol] + rightSymbol, leftWeight + rightWeight, right)
    case (let .node(_ , leftSymbol, leftWeight, _), let .leaf(rightSymbol, rightWeight)):
        return .node(left, leftSymbol + [rightSymbol], leftWeight + rightWeight, right)
    case (let .node(_ , leftSymbol, leftWeight, _), let .node(_ , rightSymbol, rightWeight, _)):
        return .node(left, leftSymbol + rightSymbol, leftWeight + rightWeight, right)
    default:
        return nil
    }
}

func leftBranch(_ tree: BinaryTree<String>) -> BinaryTree<String> {
    switch tree {
    case .node(let left, _, _, _):
        return left
    default:
        return tree
    }
}

func rightBranch(_ tree: BinaryTree<String>) -> BinaryTree<String> {
    switch tree {
    case .node(_, _, _, let right):
        return right
    default:
        return tree
    }
}

func symbols(_ tree: BinaryTree<String>) -> [String] {
    switch tree {
    case .node(_, let symbols, _, _):
        return symbols
    case .leaf(let symbol, _):
        return [symbol]
    default:
        return []
    }
}

func weight(_ tree: BinaryTree<String>) -> Int {
    switch tree {
    case .node(_, _, let weight, _):
        return weight
    case .leaf(_, let weight):
        return weight
    default:
        return 0
    }
}

func decode(_ bits: [Int], _ tree: BinaryTree<String>) -> [String] {

    func decodeI(_ bits: [Int], _ currentBranch: BinaryTree<String>) -> [String] {
        guard !bits.isEmpty else {
            return []
        }

        let nextBranch = bits[0] == 0
            ? leftBranch(currentBranch)
            : rightBranch(currentBranch)

        return isLeaf(nextBranch)
            ? getSymbol(nextBranch) + decodeI(Array(bits.dropFirst()), tree)
            : decodeI(Array(bits.dropFirst()), nextBranch)
    }

    return decodeI(bits, tree)
}

let left = BinaryTree<String>.leaf("A", 1)
let right = BinaryTree<String>.leaf("B", 2)

let a = Optional.some("a")
let b = Optional.some("b")

let sampleTree = makeCodeTree(makeLeaf("A", 4), makeCodeTree(makeLeaf("B", 2), makeCodeTree(makeLeaf("D", 1), makeLeaf("C", 1))!)!)

//dump(sampleTree)
//
dump(decode([0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0], sampleTree!))

func getBits(_ symbol: String, _ tree: BinaryTree<String>) -> [Int]? {

    func getBits(_ currentBranch: BinaryTree<String>) -> [Int]? {
        guard !isLeaf(currentBranch) else {
            switch currentBranch {
            case .leaf(let symbol, _):
                print(symbol)
                return symbol == symbol ? [] : nil
            default:

                return nil
            }
        }

        let lhs = getBits(leftBranch(currentBranch)).map { $0 + [0] }
        let rhs = getBits(rightBranch(currentBranch)).map { $0 + [1] }

        print(lhs, rhs)
        
        return (lhs ?? []) + (rhs ?? [])
    }

    return getBits(tree)
}

func containsSymbol(_ symbol: String, _ tree: BinaryTree<String>) -> Bool {
    return symbols(tree).contains(symbol)
}

func encodeSymbol(_ symbol: String, _ tree: BinaryTree<String>) -> [Int] {
    if isLeaf(tree) {
        return []
    }

    let leftTree = leftBranch(tree)
    let rightTree = rightBranch(tree)
    return containsSymbol(symbol, leftTree)
        ? [0] + encodeSymbol(symbol, leftTree)
        : containsSymbol(symbol, rightTree)
        ? [1] + encodeSymbol(symbol, rightTree)
        : []
}



dump(["A", "D", "A", "B", "B", "C", "A"].reduce([], { r, v in
    return r + encodeSymbol(v, sampleTree!)
}))
