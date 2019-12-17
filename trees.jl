using AbstractTrees

AbstractTrees.children(x::Type) = subtypes(x)

AbstractTrees.print_tree(Number)

AbstractTrees.print_tree(AbstractArray)

using Yao

AbstractTrees.print_tree(AbstractBlock)
