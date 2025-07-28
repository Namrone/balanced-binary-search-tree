require_relative "BST"

tree = Tree.new((Array.new(15) { rand(1..100) }))
tree.balanced?
pp tree.preorder
pp tree.postorder
pp tree.inorder
tree.insert(105)
tree.insert(110)
tree.insert(120)
tree.insert(135)
tree.insert(150)
tree.balanced?
tree.rebalance
tree.balanced?
pp tree.preorder
pp tree.postorder
pp tree.inorder