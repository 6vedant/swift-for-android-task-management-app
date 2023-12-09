import Dispatch
import Foundation
import Java

public func updateTasksList(activity: JObject) {
  activity.call(
    // return the error result string
    method: "printText", "Hello World!")
}

// NOTE: Use @_silgen_name attribute to set native name for a function called from Java
@_silgen_name("Java_com_example_swiftandroidexample_MainActivity_printHelloWorld")
public func MainActivity_printHelloWorld(
  env: UnsafeMutablePointer<JNIEnv>, activity: JavaObject
) {
  // Create JObject wrapper for activity object
  let mainActivity = JObject(activity)


  updateTasksList(activity: mainActivity)
}

