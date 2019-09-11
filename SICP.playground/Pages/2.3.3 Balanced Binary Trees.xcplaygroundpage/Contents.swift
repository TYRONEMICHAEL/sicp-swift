import Foundation

enum BinaryTree<T> {
    case empty
    indirect case node(BinaryTree, T, BinaryTree)
}

let node5 = BinaryTree<Int>.node(.empty, 5, .empty)
let node1 = BinaryTree<Int>.node(.empty, 1, .empty)
let node3 = BinaryTree<Int>.node(node1, 3, node5)
let node11 = BinaryTree<Int>.node(.empty, 11, .empty)
let node9 = BinaryTree<Int>.node(.empty, 9, node11)
let root = BinaryTree<Int>.node(node3, 7, node9)

func value<A>(_ tree: BinaryTree<A>) -> A? {
    switch tree {
    case .node(_, let v, _):
        return v
    default:
        return nil
    }
}

func left<A>(_ tree: BinaryTree<A>) -> BinaryTree<A> {
    switch tree {
    case .node(let left, _, _):
        return left
    default:
        return .empty
    }
}

func right<A>(_ tree: BinaryTree<A>) -> BinaryTree<A> {
    switch tree {
    case .node(_, _, let right):
        return right
    default:
        return .empty
    }
}

func hasElement<A: Equatable & Comparable>(_ x: A, _ tree: BinaryTree<A>?) -> Bool {
    guard let tree = tree,
        let value = value(tree) else {
        return false
    }

    return value == x
        ? true
        : value < x
        ? hasElement(x, right(tree))
        : hasElement(x, left(tree))
}

func adjoin<A: Equatable & Comparable>(_ x: A, _ tree: BinaryTree<A>) -> BinaryTree<A> {
    guard let value = value(tree) else {
        return BinaryTree<A>.node(.empty, x, .empty)
    }

    return value == x
    ? tree
    : value < x
    ? BinaryTree<A>.node(left(tree), value, adjoin(x, right(tree)))
    : BinaryTree<A>.node(adjoin(x, left(tree)), value, right(tree))
}

func lookup<A: Equatable & Comparable>(_ x: A, _ tree: BinaryTree<A>) -> Bool {
    guard case let BinaryTree.node(_, value, _) = tree else {
        return false
    }

    return x == value ? true : value < x ? lookup(x, right(tree)) : lookup(x, left(tree))
}

struct Record: Equatable, Comparable {
    static func < (lhs: Record, rhs: Record) -> Bool {
        return lhs.key < rhs.key
    }

    let key: Int
}

lookup(9, root)

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

func getHeight(of tree: TreeNode?) -> Int {
    guard let tree = tree else {
        return 0
    }

    return 1 + max(getHeight(of: tree.left), getHeight(of: tree.right))
}

//func isBalanced(_ tree: TreeNode?) -> Bool {
//    guard let tree = tree else {
//        return true
//    }
//    return abs(getHeight(of: tree.left) - getHeight(of: tree.right)) <= 1
//}

let tree = TreeNode(4)
let left1 = TreeNode(3)
let left2 = TreeNode(2)
let left3 = TreeNode(1)
let right1 = TreeNode(5)
let right2 = TreeNode(5)

tree.left = left1
tree.right = right1
left1.left = left2


//dump(getHeight(of: tree))
//dump(isBalanced(tree))

func isBalanced(_ tree: TreeNode?) -> Int {
    dump(tree)
    guard let tree = tree else {
        return 0
    }

    let leftHeight = isBalanced(tree.left)

    guard leftHeight != -1 else {
        return -1
    }

    let rightHeight = isBalanced(tree.right)

    guard rightHeight != -1 else {
        return -1
    }

    print(leftHeight, rightHeight)

    guard abs(leftHeight - rightHeight) <= 1 else {
        return -1
    }

    return max(leftHeight, rightHeight) + 1
}

dump(isBalanced(tree))
