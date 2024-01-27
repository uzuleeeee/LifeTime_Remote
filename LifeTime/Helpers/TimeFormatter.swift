//
//  TimeFormatter.swift
//  LifeTime
//
//  Created by Mac-aroni on 1/27/24.
//

import Foundation

func durationInSeconds(startDate: Date, endDate: Date) -> Int32 {
    return Int32(endDate.timeIntervalSince(startDate))
}

func getSeconds(seconds: Int32) -> Int32 {
    return seconds % 60
}

func getMinutes(seconds: Int32) -> Int32 {
    return (seconds % 3600) / 60
}

func getHours(seconds: Int32) -> Int32 {
    return (seconds % 86400) / 3600
}

func getDays(seconds: Int32) -> Int32 {
    return (seconds % 2628000) / 86400
}

func getMonths(seconds: Int32) -> Int32 {
    return (seconds % 31540000) / 2628000
}

func getYears(seconds: Int32) -> Int32 {
    return seconds / 31540000
}

func formatSeconds(seconds: Int32) -> String {
    switch seconds {
    case 0:
        return ""
    case 1...60:
        return "\(seconds)s"
    case 61...3600:
        return "\(getMinutes(seconds: seconds))m \(getSeconds(seconds: seconds))s"
    case 3601...86400:
        return "\(getHours(seconds: seconds))h \(getMinutes(seconds: seconds))m"
    case 86401...2628000:
        return "\(getDays(seconds: seconds))d \(getHours(seconds: seconds))h"
    case 2628001...31540000:
        return "\(getMonths(seconds: seconds))m \(getDays(seconds: seconds))d"
    default:
        return "\(getYears(seconds: seconds))y \(getMonths(seconds: seconds))m"
    }
}
