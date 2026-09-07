//
//  main.swift
//  Tasksbook
//
//  Created by Валерия Пономарева on 06.09.2026.
//

import Foundation

// MARK: - '🛠 ПЕРВАЯ ЗАДАЧА (НА ФУНКЦИЮ)'
/*
Напиши функцию `divide(_:by:) throws -> Double`:
- Если делитель == 0 → выбросить ошибку `.divisionByZero`
- Иначе → вернуть результат */

enum DivisionZero: Error {
    case divisionByZero
}

func divide(_ a: Double, by b: Double) throws -> Double {
    guard b != 0 else {
        throw DivisionZero.divisionByZero
    }
    let result = a / b
    return result
}

do {
let c = try divide(12.0, by: 3.0)
print(c)
} catch DivisionZero.divisionByZero {
    print("❌ Division by zero is not allowed!")
} catch {
    print("Unexpected error: \(error)")
}

do {
    let d = try divide(12.0, by: 0)
    print(d)
} catch DivisionZero.divisionByZero {
    print("❌ Division by zero is not allowed!")
} catch {
    print("Unexpected error: \(error)")
}

/*
 4.0
 ❌ Division by zero is not allowed!
 Program ended with exit code: 0
 */

/** MARK: - '🛠 ВТОРАЯ ЗАДАЧА (НА ФУНКЦИЮ)': Напиши функцию findIndex(of target: Int, in array: [Int]) throws -> Int`:
- Если массив пуст → ошибка `.emptyArray`
- Если элемент не найден → ошибка `.notFound`
- Иначе → вернуть индекс
🧩 ТРЕБОВАНИЯ
    Создай enum FindError: Error с кейсами .emptyArray, .notFound
        - Напиши функцию
        - Проверь в do-catch:
        - пустой массив
        - массив не пуст, но без искомого элемента
        - массив с элементом */
enum FindError: Error {
    case emptyArray
    case notFound
}

func findIndex(of target: Int, in array: [Int]) throws -> Int {
    guard !array.isEmpty else {
        throw FindError.emptyArray
    }
    guard let index = array.firstIndex(of: target) else { 
        throw FindError.notFound
    }
    return index
}

do {
    let indexInEmptyArray = try findIndex(of: 3, in: [])
print(indexInEmptyArray)
} catch FindError.emptyArray {
    print("❌ Index of target in empty array is absent")
} catch {
    print("Unexpected error: \(error)")
}

do {
    let indexOfAbsentTarget = try findIndex(of: 3, in: [2, 4, 6, 8])
print(indexOfAbsentTarget)
} catch FindError.notFound {
    print("❌ Index of target not dound in array")
} catch {
    print("Unexpected error: \(error)")
}

do {
    let indexOfTargetInArray = try findIndex(of: 3, in: [3, 3, 3])
print(indexOfTargetInArray)
} catch FindError.notFound {
    print("❌ Index of target not found in array")
} catch {
    print("Unexpected error: \(error)")
}
/*
 ❌ Index of target in empty array is absent
 ❌ Index of target not dound in array
 0
 */
