# TaskManager - Ruby CLI Application

### Description
This Ruby application is a simple **Task Manager** that allows users to register, login, and manage their tasks through a command-line interface (CLI). Users can perform various operations, such as adding, editing, deleting tasks, and marking them as completed or pending.

### Features
- User registration and login.
- Task creation with optional categories.
- Edit tasks (title, description, category).
- Mark tasks as completed or pending.
- Delete tasks.
- List all tasks of a user.

### Requirements
- Ruby 2.5 or higher.

### Setup Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/task-manager.git
   cd task-manager
   ```

2. **Run the Application:**
   Run the following command in your terminal:
   ```bash
   ruby task_manager.rb
   ```

### Usage

1. Upon launching the application, you will be prompted to log in with your username and password.
   
2. If the username does not exist, you will need to register. After registration, log in again to start managing tasks.

3. **Main Menu:**
   Once logged in, you will see a menu with the following options:
   ```
   1. Add task
   2. Edit task
   3. Delete task
   4. Mark task as completed
   5. Mark task as pending
   6. List tasks
   7. Exit
   ```

4. Follow the prompts to add, edit, delete, and view tasks.

