import Foundation
import Java
import TaskManagementSDK

// Note: Custom Swift/Java Object can't be passed from Swift to Java & Vice Versa as of now
// It will be available in future
// as of now, we will use String type to send from Swift to Java & Vice Versa

public func updateTasksList(activity: JObject) {
    let taskManager = TaskListViewModel.viewModel.getTaskManager()
    // get all task IDs
    var taskIDArray = [String]()

    for task in taskManager.getAllTasks() {
        taskIDArray.append(task.id)
    }

    activity.call(method: "printTasks", taskManager.getAllTasksTitle(), taskIDArray)
}



// NOTE: Use @_silgen_name attribute to set native name for a function called from Java
@_silgen_name("Java_com_example_swiftandroidexample_MainActivity_initTaskManager")
public func MainActivity_initTaskManager(
    env: UnsafeMutablePointer<JNIEnv>, activity: JavaObject
) {
    // Create JObject wrapper for activity object
    let mainActivity = JObject(activity)
    let taskManager = TaskListViewModel.viewModel.getTaskManager()

    taskManager.subscribeToChanges { _ in
        updateTasksList(activity: mainActivity)
    }
}

// NOTE: Use @_silgen_name attribute to set native name for a function called from Java
@_silgen_name("Java_com_example_swiftandroidexample_MainActivity_addTask")
public func MainActivity_addTask(
    env: UnsafeMutablePointer<JNIEnv>, activity: JavaObject,
    taskName: JavaString
) {
    // Convert the Java string to a Swift string
    let mainActivity = JObject(activity)
    let taskTitle:String = String.fromJavaObject(taskName)

    let taskManager = TaskListViewModel.viewModel.getTaskManager()
    taskManager.addTask(taskTitle)

}

// NOTE: Use @_silgen_name attribute to set native name for a function called from Java
@_silgen_name("Java_com_example_swiftandroidexample_MainActivity_removeTask")
public func MainActivity_removeTask(
    env: UnsafeMutablePointer<JNIEnv>, activity: JavaObject,
    taskID: JavaString
) {
    // Convert the Java string to a Swift string
    // let mainActivity = JObject(activity)
    let taskIDStr:String = String.fromJavaObject(taskID)

    let taskManager = TaskListViewModel.viewModel.getTaskManager()

    for task in taskManager.getAllTasks() {
        if task.id == taskIDStr {
            taskManager.removeTask(task)
        }
    }
}

// NOTE: Use @_silgen_name attribute to set native name for a function called from Java
@_silgen_name("Java_com_example_swiftandroidexample_MainActivity_updateTask")
public func MainActivity_updateTask(
    env: UnsafeMutablePointer<JNIEnv>, activity: JavaObject,
    taskID: JavaString, newTaskTitle: JavaString
) {
    // Convert the Java string to a Swift string
    let mainActivity = JObject(activity)
    let taskIDStr:String = String.fromJavaObject(taskID)
    let newTaskTitleStr:String = String.fromJavaObject(newTaskTitle)

    let taskManager = TaskListViewModel.viewModel.getTaskManager()

    taskManager.updateTask(id: taskIDStr, newTaskTitle: newTaskTitleStr)
}

// ViewModel to manage tasks
class TaskListViewModel {
    static let viewModel = TaskListViewModel()
    weak var taskManagerViewModel: TaskManager?
    public init() {
        taskManagerViewModel = TaskManager.viewModel
    }

    public func getTaskManager() -> TaskManager {
        return taskManagerViewModel!
    }
}
