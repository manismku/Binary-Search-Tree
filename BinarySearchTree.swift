//
//  BinarySearchTree.swift
//  CountSortProject
//
//  Created by manish kumar on 23/01/18.
//  Copyright © 2018 manish kumar. All rights reserved.
//

import Foundation

class BSTNode {
    var value: Int = 0
    var left:  BSTNode?
    var right: BSTNode?
    
    init(value: Int) {
        self.value = value
    }
}

class BST {
    
    private var input: [Int]
    private var rootNode: BSTNode?
    private var output = [Int]()
    
    init(input: [Int]) {
        self.input = input
        insert()
    }
    
    func left(i: Int) -> Int {
        return 2*i + 1
    }

    func right(i: Int) -> Int {
        return 2*i + 2
    }
    
    
    private func insert() {
        for item in self.input {
            rootNode = create(key: item, node: rootNode)
        }
    }
    
    private func create(key: Int, node: BSTNode?) -> BSTNode? {
        
        guard node != nil else {
            return BSTNode(value: key)
        }
        
        if key < (node?.value)! {
            node?.left = create(key: key, node: node?.left)
        }
        
        if key > (node?.value)! {
            node?.right =  create(key: key, node: node?.right)
        }
        
        return node
    }
    
    
    private func inorder(node: BSTNode?) {
        if let aNode = node {
            inorder(node: aNode.left)
            print("\(aNode.value) ")
            output.append(aNode.value)
            inorder(node: aNode.right)
        }
    }
    
    
    func sort() -> [Int] {
        output.removeAll()
        inorder(node: rootNode)
        return output
    }
    
    
    private func find(key: Int, node: BSTNode?) -> Bool {
        
        var found = false
        
        guard let _ = node else {
            return found
        }
        
        if key < (node?.value)! {
            found = find(key: key, node: node?.left)
        } else if key > (node?.value)! {
            found = find(key: key, node: node?.right)
        } else {
            found = true
        }
        
        return found
    }
    
    func search(value: Int) -> Bool {
        return find(key: value, node: rootNode)
    }
    
    func delete() {
      rootNode = deleteMax(node: rootNode)
    }
    

    private func deleteMax(node: BSTNode?) -> BSTNode? {
        if node?.right == nil  {
            return node?.left
        }
        node?.right = deleteMax(node: node?.right)
        return node
    }
    
    private func deleteNode(key: Int, node: BSTNode?) -> BSTNode? {

        guard let aNode  = node else {
            return nil
        }
        
        
        // find the key inside the node - recursively
        if key > aNode.value {
            aNode.right = deleteNode(key: key, node: aNode.right)
        } else if key < aNode.value {
            aNode.left = deleteNode(key: key, node: aNode.left)
        } else {
            
        
            if aNode.right == nil {
                return aNode.left
            } else if aNode.left == nil {
                return aNode.right
            } else {
                
                // find the maxium on left subtree
                var temp = aNode.left
                
                while let rightNode = temp {
                    if rightNode.right == nil {
                        break
                    }
                    temp = rightNode.right
                }                
                // Temp is maximum node on left sub
                aNode.value = (temp?.value)!
                aNode.left = deleteMax(node: aNode.left)
            }
            
        }
        
        return node
    }
    
}



