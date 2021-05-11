//
//  PizzaBotTests.swift
//  PizzaBotTests
//
//  Created by Ignacio Mariani on 10/05/2021.
//

import XCTest
@testable import PizzaBot

class PizzaBotTests: XCTestCase {
    
    let pizzaBot = PizzaBot()
    
    func testOk() {
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x5 (0, 0) (1, 3) (4,4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"), "DENNNDEEENDSSDDWWWWSDEEENDWNDEESSD")
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x 5(1,1)(3,5)(2,4)"), "ENDEENNNNDWSD")
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5 x5(1,1)(3,5)"), "ENDEENNNND")
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5X5 (1,3)(4,4)"), "ENNNDEEEND")
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "2x3(0,0) (1,3)"), "DENNND")
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "3X3(1,1)(3,3)(2,1)(2, 0)"), "ENDEENNDWSSDSD")
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "1x1(1,  0)"), "ED")
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "1x1(0,1)"), "ND")
    }
    
    func testEmptyInput() {
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: ""), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "(2,4)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x3"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x3()"), kWrongFormat)
    }
    
    func testOutOfBounds() {
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x5(1,1)(3,6)"), kOutOfBounds)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x5(1,1)(3,6))"), kOutOfBounds)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "6x4(7,1)(3,5))"), kOutOfBounds)
    }
    
    func testLetters() {
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "ax5(1,1)(3,6)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "3xf(1,1)(3,6)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "3xf(1,r)(3,6)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "3xf(1,1)(3,g)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "3xf(y,1)(3,6)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "3xf(1,1)(u,6)"), kWrongFormat)
    }
    
    func testExtraBracket() {
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x5((1,1)(3,6)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x5(1,1)(3,6()"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "(5x5(1,1)(3,6)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5(x5(1,1)(3,6)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x5(1,1"), kWrongFormat)
    }
    
    func testWrongSymbols() {
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x5{1,1}{3,5}"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5*5(1,1)(3,6)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x5(1-1)(3,6)"), kWrongFormat)
    }
    
    func testNegativeNumbers() {
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "-5x5(1,1)(3,5)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x5(1,-1)(3,5)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x5(1,1)(-3,5)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x-5(1,1)(3,5)"), kWrongFormat)
    }
    
    func testExtraCoordinate() {
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "2x4(1,1,3)(3,6)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x5x2(1,1)(3,6)"), kWrongFormat)
        XCTAssertEqual(pizzaBot.getDeliveryRoute(rawInput: "5x3(1,1)(3,6,10)"), kWrongFormat)
    }

}
