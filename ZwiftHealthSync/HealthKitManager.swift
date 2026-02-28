//
//  HealthKitManager.swift
//  ZwiftHealthSync
//
//  Created by Ian Robinson on 2/1/26.
//
import Foundation
import HealthKit
internal import Combine


class HealthKitManager {
    let healthStore = HKHealthStore()
    
    // Types we want to read/write
    let typesToRead: Set<HKSampleType> = [
        .workoutType(),
        .quantityType(forIdentifier: .heartRate)!,
        .quantityType(forIdentifier: .activeEnergyBurned)!,
        .quantityType(forIdentifier: .distanceCycling)!
    ]
    
    let typesToWrite: Set<HKSampleType> = [
        .workoutType(),
        .quantityType(forIdentifier: .heartRate)!,
        .quantityType(forIdentifier: .activeEnergyBurned)!,
        .quantityType(forIdentifier: .distanceCycling)!,
        .quantityType(forIdentifier: .cyclingPower)!,
        .quantityType(forIdentifier: .cyclingCadence)!
    ]
    
    @Published var isAuthorizaed = false
    
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("Health data not avaialble")
            return
        }
        
//        healthStore.requestAuthorization(toShare: typesToWrite, read: type)
//        healthStore.requestAuthorization(toShare: <#T##Set<HKSampleType>?#>, read: <#T##Set<HKObjectType>?#>, completion: <#T##(Bool, (any Error)?) -> Void#>)
    }
}
