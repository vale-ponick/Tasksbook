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
    print("Unexpected error \(error)")
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

// MARK: - 🛠 ТРЕТЬЯ ЗАДАЧА 3: ВАЛИДАЦИЯ EMAIL - Иоанна проверяет, можно ли отправить сообщение контакту. Email должен содержать "@" и ".". Напиши функцию validateEmail(_ email: String) throws -> Bool: Если email пустой → .empty. Если нет "@" → .noAtSymbol, если нет "." → .noDot, если всё ок → true

enum EmailError: Error { // подписала под тип Error
    case empty // email пустой
    case noAtSymbol // нет "@"
    case noDot // нет "."
    case invalidPosition
    case containsSpaces
    case consecutiveDot
}

func validateEmail(_ email: String) throws -> Bool {
    guard !email.isEmpty else {
        throw EmailError.empty
    }
    
    guard !email.contains(" ") else {
        throw EmailError.containsSpaces
    }
    
    guard !email.contains("..") else {
        throw EmailError.consecutiveDot
    }
    guard email.contains("@") else {
        throw EmailError.noAtSymbol
    }
    
    let parts = email.split(separator: "@")
    guard parts.count == 2,
        !parts[0].isEmpty,
        !parts[1].isEmpty else {
        throw EmailError.invalidPosition
    }

    guard let domain = email.split(separator: "@").last, // split == надежно и читаемо
          domain.contains(".") else { // split(separator: "@").last == разбей строку символом на части + часть строки после символа проверяем на точку? // parts = ["vale.ponick", "gmailcom"]
        throw EmailError.noDot
    }
    print(email)
    return true
}

do {
    let emptyEmail = try validateEmail("vale.ponick@gmail.com")
    print(emptyEmail)
} catch EmailError.empty {
    print("❌ Email is empty!")
} catch EmailError.containsSpaces {
    print("❌ Email contains spaces!")
} catch {
    print("Unexpected error: \(error)")
}

do {
    let emailWithSpaces = try validateEmail("va  le.ponick@gmail.com")
    print(emailWithSpaces)
} catch EmailError.containsSpaces {
    print("❌ Email contains spaces!")
} catch {
    print("Unexpected error: \(error)")
}

do {
    let emailWithConsecutiveDots = try validateEmail("vale...ponick@gmail.com")
    print(emailWithConsecutiveDots)
} catch EmailError.consecutiveDot {
    print("❌ Email with consecutive dots!")
} catch EmailError.containsSpaces {
    print("❌ Email contains spaces!")
} catch {
    print("Unexpected error: \(error)")
}

do {
    let noDomain = try validateEmail("vale@ponick@gmail.com")
    print(noDomain)
} catch EmailError.invalidPosition {
    print("❌ Domain not found!")
} catch EmailError.containsSpaces {
    print("❌ Email contains spaces!")
} catch {
    print("Unexpected error: \(error)")
}


do {
    let emailWithoutSymbol = try validateEmail("vale.ponickgmail.com")
    print(emailWithoutSymbol)
} catch EmailError.noAtSymbol {
    print("❌ Email without symbol '@'")
} catch EmailError.containsSpaces {
    print("❌ Email contains spaces!")
} catch {
    print("Unexpected error: \(error)")
}

do {
    let domainlWithoutDot = try validateEmail("vale.ponick@gmailcom")
    print(domainlWithoutDot)
} catch EmailError.noDot {
    print("❌ Email without dote '.'")
} catch EmailError.containsSpaces {
    print("❌ Email contains spaces!")
} catch {
    print("Unexpected error: \(error)")
}

/*
 vale.ponick@gmail.com
 true
 ❌ Email contains spaces!
 ❌ Email with consecutive dots!
 ❌ Domain not found!
 ❌ Email without symbol '@'
 ❌ Email without dote '.'
 Program ended with exit code: 0
 */

// MARK: - 🛠 ЧЕТВЕРТАЯ ЗАДАЧА. ПАРСЕР температуры. Напиши функцию - парсер, которая преобразует строку в число: parseTemperature(_ input: String) throws -> Double: Условие    Ошибка. Строка пустая    .emptyInput. Строка содержит буквы (кроме - и .).invalidCharacter. Строка не может быть преобразована в число.notANumber. Температура ниже -273.15 (абсолютный ноль).belowAbsoluteZero. Если всё ок → вернуть Double

enum TemperatureError: Error {
    case emptyInput // cтрока пустая
    case notNumber // Строка не м.б. преобразована в число
    case belowAbsoluteZero // Температура ниже -273.15
}

func parseTemperature(_ input: String) throws -> Double {
    guard !input.isEmpty else {
        throw TemperatureError.emptyInput
    }
    guard let value = Double(input) else { // Если в строке есть буквы → Double(input) вернёт nil
        throw TemperatureError.notNumber
    }
    guard value >= -273.15 else {
        throw TemperatureError.belowAbsoluteZero
    }
    return value
}
do {
    let temp = try parseTemperature("25.0")
    print("✅ \(temp)°C") // ✅ 25.0°C
} catch TemperatureError.emptyInput {
    print("❌ Empty input")
} catch TemperatureError.notNumber {
    print("❌ Not a number")
} catch TemperatureError.belowAbsoluteZero {
    print("❌ Below absolute zero")
} catch {
    print("Unexpected error: \(error)")
}

do {
    let temp = try parseTemperature("25.a")
    print("✅ \(temp)°C") // ❌ Not a number
} catch TemperatureError.emptyInput {
    print("❌ Empty input")
} catch TemperatureError.notNumber {
    print("❌ Not a number")
} catch TemperatureError.belowAbsoluteZero {
    print("❌ Below absolute zero")
} catch {
    print("Unexpected error: \(error)")
}

do {
    let temp = try parseTemperature("-325.0")
    print("✅ \(temp)°C")
} catch TemperatureError.emptyInput {
    print("❌ Empty input")
} catch TemperatureError.notNumber {
    print("❌ Not a number")
} catch TemperatureError.belowAbsoluteZero {
    print("❌ Below absolute zero") // ❌ Below absolute zero
} catch {
    print("Unexpected error: \(error)")
}

// MARK: - 🛠 ТЗ Напиши функцию convertCurrency(amount: Double, to currency: String) throws -> Double:
/** Условие    Ошибка
Сумма отрицательная или ноль    .invalidAmount
Валюта не поддерживается    .unsupportedCurrency
Сумма слишком большая (> 1 000 000)    .amountTooLarge
Если всё ок → вернуть сконвертированную сумму */

enum CurrencyError: Error {
    case invalidAmount // сумма <= 0
    case unsuppertedCurrency // валюта НЕ поддерживается
    case amountTooLarge // сумма слишком велика > 1 000 000
}

enum Currency: String { // Перечисление со строковым типом (Raw-value)
    case usd
    case euro
    case rub
    case cny
    
    var rateFromUSD: Double {
        switch self {
        case .usd: return 1.0
        case .euro: return 0.92 // 1 usd = 0.92 euro
        case .rub: return 92.5 // 1 usd = 92.5 rub
        case .cny: return 7.25 // 1 usd = 7.25 cny
        }
    }
}

func convertCurrency(amount: Double, to currency: String) throws -> Double {
    guard amount > 0 else {  // 1. Проверяем валидность суммы
        throw CurrencyError.invalidAmount
    }
    let maxAmount = 1000000.0
    guard amount < maxAmount else { // 2. Проверяем размер суммы
        throw CurrencyError.amountTooLarge
    }
    guard let validCurrency = Currency(rawValue: currency.lowercased()) else {
        throw CurrencyError.unsuppertedCurrency
    }
    
    return amount * validCurrency.rateFromUSD
}

do {
    let convertEuro = try convertCurrency(amount: 100.0, to: "euro")
    print("✅ Converted summa: \(convertEuro) \(Currency.euro.rawValue.uppercased())") // ✅ Converted summa: 92.0 EURO
} catch CurrencyError.unsuppertedCurrency {
    print("❌ unsupperted Currency")
}
