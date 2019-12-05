using AbstractTrees

AbstractTrees.children(x::Type) = subtypes(x)

print_tree(Number)

print_tree(AbstractArray)

using Yao

print_tree(AbstractBlock)
