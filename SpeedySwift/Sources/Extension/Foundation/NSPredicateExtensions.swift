//
//  NSPredicateExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 04.10.17.
//  Copyright © 2017 SpeedySwift
//
/// Cocoa框架中的NSPredicate用于查询，原理和用法都类似于SQL中的where，作用相当于数据库的过滤取
#if canImport(Foundation)
import Foundation

// MARK: - Properties
public extension NSPredicate {

    /// SpeedySwift: Returns a new predicate formed by NOT-ing the predicate.
    public var not: NSCompoundPredicate {
        return NSCompoundPredicate(notPredicateWithSubpredicate: self)
    }

}

// MARK: - Methods
public extension NSPredicate {

    /// SpeedySwift: Returns a new predicate formed by AND-ing the argument to the predicate.
    ///
    /// - Parameter predicate: NSPredicate
    /// - Returns: NSCompoundPredicate
    public func and(_ predicate: NSPredicate) -> NSCompoundPredicate {
        return NSCompoundPredicate(andPredicateWithSubpredicates: [self, predicate])
    }

    /// SpeedySwift: Returns a new predicate formed by OR-ing the argument to the predicate.
    ///
    /// - Parameter predicate: NSPredicate
    /// - Returns: NSCompoundPredicate
    public func or(_ predicate: NSPredicate) -> NSCompoundPredicate {
        return NSCompoundPredicate(orPredicateWithSubpredicates: [self, predicate])
    }

}

// MARK: - Operators
public extension NSPredicate {

    /// SpeedySwift: Returns a new predicate formed by NOT-ing the predicate.
    /// - Parameters: rhs: NSPredicate to convert.
    /// - Returns: NSCompoundPredicate
    static public prefix func ! (rhs: NSPredicate) -> NSCompoundPredicate {
        return rhs.not
    }

    /// SpeedySwift: Returns a new predicate formed by AND-ing the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate
    static public func + (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        return lhs.and(rhs)
    }

    /// SpeedySwift: Returns a new predicate formed by OR-ing the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate
    static public func | (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        return lhs.or(rhs)
    }

    /// SpeedySwift: Returns a new predicate formed by remove the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate
    static public func - (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        return lhs + !rhs
    }

}
#endif
