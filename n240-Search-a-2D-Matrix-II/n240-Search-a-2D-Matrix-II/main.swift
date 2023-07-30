import Foundation

class Solution {
    // MARK: - Pointer
    
    private struct TwoDimensionalPointer {
        enum MoveDirection {
            case up, right, down, left
        }
        
        private var x: Int
        private var y: Int
        
        var rowIndex: Int { y }
        var columnIndex: Int { x }
        
        init() {
            self.x = 0
            self.y = 0
        }
        
        mutating func move(_ direction: MoveDirection) {
            switch direction {
            case .up:
                self.y -= 1
            case .right:
                self.x += 1
            case .down:
                self.y += 1
            case .left:
                self.x -= 1
            }
        }
    }
    
    // MARK: - Solution itself
    
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        if matrix.isEmpty {
            return false
        }
        var pointer = TwoDimensionalPointer() // x: 0 (column), y: 0 (row)
        if target < matrix[pointer.rowIndex][pointer.columnIndex] {
            return false
        }
        let rows = matrix.count
        var currentPointerMoveDirection = TwoDimensionalPointer.MoveDirection.right
        while pointer.rowIndex < rows {
            let currentValue = matrix[pointer.rowIndex][pointer.columnIndex]
            if currentValue == target {
                return true
            }
            var newPointerMoveDirection = currentPointerMoveDirection
            let maxColumn = matrix[pointer.rowIndex].endIndex - 1 == pointer.columnIndex
            let minColumn = 0 == pointer.columnIndex
            let maxRow = matrix.endIndex - 1 == pointer.rowIndex
            switch currentPointerMoveDirection {
            case .right:
                if target > currentValue && maxColumn && maxRow {
                    return false
                } else if target > currentValue && maxColumn {
                    pointer.move(.down)
                    newPointerMoveDirection = .down
                    break
                }
                if target > currentValue {
                    pointer.move(.right)
                    break
                }
                if target < currentValue && minColumn {
                    return false
                }
                if target < currentValue && maxRow {
                    return false
                }
                if target < currentValue {
                    pointer.move(.left)
                    pointer.move(.down)
                    newPointerMoveDirection = .down
                    break
                }
            case .down:
                if target > currentValue && maxRow && minColumn {
                    return false
                }
                if target > currentValue && maxRow {
                    pointer.move(.left)
                    newPointerMoveDirection = .left
                    break
                }
                if target > currentValue {
                    pointer.move(.down)
                    break
                }
                if target < currentValue && minColumn {
                    return false
                }
                if target < currentValue {
                    pointer.move(.up)
                    pointer.move(.left)
                }
            case .up, .left:
                return false
            }
            currentPointerMoveDirection = newPointerMoveDirection
        }
        return false
    }
}

let solution = Solution()
let matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]]
let result1 = solution.searchMatrix(matrix, 5)
let result2 = solution.searchMatrix(matrix, 20)

print(result1)
print(result2)
