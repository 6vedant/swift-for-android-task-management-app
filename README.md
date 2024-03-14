# Android Task Management App with Swift Integration

This Android app is a simple task management application that utilizes Swift for calling a Swift Package Manager (SPM) library for task management. The SPM library internally uses OpenCombine for publishing and subscribing to task modification changes.

![Task Management App Demo](images/app.gif)


## Features

- Display tasks in a RecyclerView.
- Add new tasks.
- Delete existing tasks.
- Update task titles.

## Swift Integration

The app utilizes JNI (Java Native Interface) and the Swift-Java compiler provided by the SCADE Swift toolchain library to communicate between Swift and Java. Data is sent between Swift and Java using `String` types.

### Swift Code Integration

```swift
// Swift code calling Java methods
public func updateTasksList(activity: JObject) {
    // Swift logic to update task list
}

// JNI methods called from Java
@_silgen_name("Java_com_example_swiftandroidexample_MainActivity_initTaskManager")
public func MainActivity_initTaskManager(
    env: UnsafeMutablePointer<JNIEnv>, activity: JavaObject
) {
    // Initialize task manager and subscribe to changes
}

// Other JNI methods for adding, removing, and updating tasks
```

### Java Activity Code

```java
// Android activity code
public class MainActivity extends AppCompatActivity {
    // Android activity logic for UI and task management

    // Method called from Swift to print tasks
    public void printTasks(String[] taskResultString, String[] taskIDs) {
        // Logic to update RecyclerView with tasks
    }

    // Other methods for UI interactions and task management
}
```

## SPM Library

The task management functionality is provided by the [TaskManagementSDK](https://github.com/6vedant/TaskManagementSDK) Swift Package Manager library.

## Installation

1. Clone this repository.
2. Open the project in Android Studio.
3. Build and run the project on an Android device or emulator.

## Contribution

<p>Consider contributing by creating a pull request (PR) or opening an issue. By creating an issue, you can alert the repository's maintainers to any bugs or missing documentation you've found. 🐛📝 If you're feeling confident and want to make a bigger impact, creating a PR, can be a great way to help others. 📖💡 Remember, contributing to open source is a collaborative effort, and any contribution, big or small, is always appreciated! 🙌 So why not take the first step and start contributing today? 😊</p>

#### Join SCADE Community: [SCADE Discord Channel](https://discord.gg/6PRedqCK)

