import Foundation

class Solution {
    private struct Pointer {
        enum MoveDirection {
            case left, right, down, up
        }
        var x: Int
        var y: Int
        
        init(x: Int = .zero, y: Int = .zero) {
            self.x = x
            self.y = y
        }
        
        var minPossibleX: Bool {
            self.x == 0
        }
        
        var minPossibleY: Bool {
            self.y == 0
        }
        
        mutating func move(_ direction: MoveDirection) {
            switch direction {
            case .left:
                self.x -= 1
            case .right:
                self.x += 1
            case .down:
                self.y += 1
            case .up:
                self.y -= 1
            }
        }
    }
    
    func search(_ target: Int, inMatrix matrix: [[Int]]) -> Bool {
        if matrix.isEmpty {
            return false
        }
        var pointer = Pointer() // x = 0, y = 0
        var attemptsDone = 0
        let matrixSquare: Int = {
            let width = matrix.first?.count ?? .zero
            let height = matrix.count
            return width * height
        }()
        var currentPointerMoveDirection = Pointer.MoveDirection.right
        
        while attemptsDone < matrixSquare {
            let value = matrix[pointer.y][pointer.x]
            if value == target {
                return true
            }
            let maxPossibleX = matrix[pointer.y].endIndex - 1 == pointer.x
            let maxPossibleY = matrix.count - 1 == pointer.y
            let minPossibleX = pointer.x == 0
            let minPossiblyY = pointer.y == 0
            var newPointerMoveDirection = currentPointerMoveDirection
            switch currentPointerMoveDirection {
            case .right:
                if maxPossibleX {
                    newPointerMoveDirection = .down
                    pointer.move(.down)
                }
                if value < target {
                    pointer.move(.right)
                } else {
                    pointer.move(.left)
                    pointer.move(.down)
                    newPointerMoveDirection = .down
                }
            case .down:
                if maxPossibleY {
                    newPointerMoveDirection = .left
                    pointer.move(.left)
                }
                if value < target {
                    pointer.move(.down)
                } else {
                    pointer.move(.left)
                }
            case .left:
                if pointer.minPossibleX {
                    newPointerMoveDirection = .up
                    pointer.move(.up)
                } else {
                    pointer.move(.left)
                }
            case .up:
                if pointer.minPossibleY {
                    return false
                } else {
                    pointer.move(.up)
                }
            }
            currentPointerMoveDirection = newPointerMoveDirection
            attemptsDone += 1
        }
        return false
    }
}

let solution = Solution()
let result1 = solution.search(5, inMatrix: [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]])
let result2 = solution.search(20, inMatrix: [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]])
print(result1)
print(result2)
