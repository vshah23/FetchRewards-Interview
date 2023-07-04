//
//  main.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 7/4/23.
//

// https://hacknicity.medium.com/how-to-switch-your-ios-app-and-scene-delegates-for-improved-testing-9746279378c3
import UIKit

// If we have a TestingAppDelegate (i.e. we're running unit tests),
// use that to avoid executing initialisation code in AppDelegate
let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
