//
//  DataManager.swift
//  CCTracker
//
//  Created by Ricardo Quintero on 24/11/15.
//  Copyright © 2015 Arteries Studio. All rights reserved.
//

import Foundation

class DataManager {
  
  let trainingManager = TrainingDataManager()
  
  func fetchConvictConditioningWorkoutNames(completionHandler: CompletionHandlerType) {
    let workoutNames = trainingManager.fetchCCWorkoutNames()
    if(workoutNames.count > 0) {
      completionHandler(Result.Success(workoutNames))
    }else {
      completionHandler(Result.Failure(.LocalDataManagerFailure))
    }
  }
 
  func fetchCurrentWorkout(completionHandler: CompletionHandlerType) {
    let currentTraining = trainingManager.loadTraining()
    if(currentTraining.schedule.count > 0) {
      completionHandler(Result.Success(currentTraining))
    }else {
      completionHandler(Result.Failure(.LocalDataManagerFailure))
    }
  }
  
  func fetchCCworkoutWithName(workoutName: String, completionHandler: CompletionHandlerType) {
    let selectedCCTraining = trainingManager.fetchWorkoutWithName(workoutName)
    completionHandler(Result.Success(selectedCCTraining))
  }
  
  func saveTraining(trainingToSave: Training, completionhandler: CompletionHandlerType) {
    trainingManager.saveTraining(trainingToSave) { (result) -> Void in
      switch (result) {
        case .Success(_):
          completionhandler(Result.Success(true))
        case .Failure(_):
          completionhandler(Result.Failure(.LocalDataManagerFailure))
      }
    }
  }
}