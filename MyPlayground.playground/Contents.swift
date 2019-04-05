import UIKit

/**
 Assignment 4
 
 TASK
 
 - Create a function called "timeAdder"
 - Accept four values
    - value1 : positive integer
    - label1 : string
    - value2 : positive integer
    - label2 : string
 - Labels can only be one of the following:
    - seconds
    - minutes
    - hours
    - days
    - second
    - minute
    - hour
    - day
 - Function must include a switch statement
 - Function will add times and return a tuple value of (UInt, String)
 - If there is an error, print the appropriate error and return false
 
 BONUS
 
 - Output 1 day vs 24 hours but if 25 hours output 25
 */


import UIKit

/**
 * Validates if the unit
 *
 * @params unit String String to be validated
 *
 * @returns Bool
 */
func checkTime (unit: String) -> Bool {
    switch (unit) {
        case "seconds", "second", "minutes", "minute", "hours", "hour", "days", "day":
            return true
        default:
            return false
    }
}

/**
 * Returns the total value in seconds based on its unit of time
 *
 * @params value UInt integer of time
 * @params unit String Unit of time
 *
 * @returns UInt
 */
func getSeconds (value: UInt, unit: String) -> UInt {
    switch(unit) {
        case "minutes", "minute":
            return UInt(value * 60)
        case "hours", "hour":
            return UInt(value * 60 * 60)
        case "days", "day":
            return UInt(value * 24 * 60 * 60)
        default: // seconds
            return value
    }
}

/**
 * Validates if the value and unit of time do not match
 *
 * @params value UInt integer of time
 * @params unit String Unit of time
 *
 * @returns String
 */
func validateValueLabels (value: UInt, unit: String) -> String {
    let newUnit : String = String(unit.dropFirst())
    if (value == 1 && newUnit.contains("s")) {
        return "This is imposible because \"\(unit)\" is plural and \(value) is singular."
    } else if (value != 1 && !newUnit.contains("s")) {
        return "This is imposible because \"\(unit)\" is singular and \(value) is plural."
    }
    return ""
}

/**
 * Combines entire functionality to add to units of time and return one Tuple value
 *
 * @params value1 UInt integer of time
 * @params label1 String Unit of time
 * @params value2 UInt integer of time
 * @params label2 String Unit of time
 *
 * @returns Any
 */
func timeAdder (value1: UInt, label1: String, value2: UInt, label2: String) -> Any {
    // Validate the times
    if (!checkTime(unit: label1) || !checkTime(unit: label2)) {
        print("One or more invalid times.")
        return false
    }
    
    // Validate value labels
    let errors : [String] = [validateValueLabels(value: value1, unit: label1), validateValueLabels(value: value2, unit: label2)]
    
    // If errors - print them
    if (errors[0].count > 0 || errors[1].count > 0) {
        for error in errors {
            if (error.count > 0) {
                print("\(error)\n")
            }
        }
        return false
    }
    
    // Convert all values into seconds
    var totalSeconds : UInt = 0;
    totalSeconds += getSeconds(value: value1, unit: label1)
    totalSeconds += getSeconds(value: value2, unit: label2)
    
    // Convert back to days, hours, minutes, seconds
    let days = totalSeconds / (24 * 60 * 60)
    totalSeconds -= (days * 24 * 60 * 60)
    
    let hours = totalSeconds / (60 * 60)
    totalSeconds -= (hours * 60 * 60)
    
    let minutes = totalSeconds / 60
    totalSeconds -= (minutes * 60)
    
    let seconds = totalSeconds;
    
    // Ouput value and unit by lowest value first
    var output : UInt = 0
    if (seconds > 0) {
        output = seconds + (minutes * 60) + (hours * 60 * 60) + (days * 24 * 60 * 60)
        return (output, output == 1 ? "second" : "seconds")
    } else if (minutes > 0) {
        output = minutes + (hours * 60) + (days * 24 * 60)
        return (output, output == 1 ? "minute" : "minutes")
    } else if (hours > 0) {
        output = hours + (days * 24)
        return (output, output == 1 ? "hour" : "hours")
    } else {
        output = days
        return (output, output == 1 ? "day" : "days")
    }
}

// Init
timeAdder(value1: 53, label1: "minutes", value2: 1, label2: "hour") // (113, "minutes")
timeAdder(value1: 25, label1: "hours", value2: 3, label2: "seconds") // (90003, "seconds")
timeAdder(value1: 25, label1: "hour", value2: 3, label2: "seconds") // Error
timeAdder(value1: 23, label1: "hours", value2: 0, label2: "seconds") // (23, "hours")
timeAdder(value1: 23, label1: "hours", value2: 1, label2: "hour") // (1, "day")
timeAdder(value1: 23, label1: "hours", value2: 2, label2: "hours") // (23, "hours")
timeAdder(value1: 25, label1: "hour", value2: 1, label2: "seconds") // Error
