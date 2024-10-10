class User
  attr_reader :username, :password, :tasks

  def initialize(username, password)
    @username = username
    @password = password
    @tasks = []
  end

  def authenticate(password)
    @password == password
  end
end

class Task
  attr_accessor :title, :description, :completed, :category

  def initialize(title, description, category = nil)
    @title = title
    @description = description
    @completed = false
    @category = category
  end

  def mark_as_completed
    @completed = true
  end

  def mark_as_pending
    @completed = false
  end
end

class TaskManager
  def initialize
    @users = {}
  end

  def register_user(username, password)
    if @users[username]
      puts "Usuario ya existe"
    else
      @users[username] = User.new(username, password)
      puts "Usuario registrado exitosamente"
    end
  end

  def login(username, password)
    user = @users[username]
    if user && user.authenticate(password)
      puts "Inicio de sesión exitoso"
      return user
    else
      puts "Usuario o contraseña incorrectos"
      return nil
    end
  end

  def add_task(user, title, description, category = nil)
    task = Task.new(title, description, category)
    user.tasks << task
    puts "Tarea añadida"
  end

  def edit_task(user, index, title, description, category = nil)
    if task = user.tasks[index]
      task.title = title
      task.description = description
      task.category = category
      puts "Tarea editada"
    else
      puts "Tarea no encontrada"
    end
  end

  def delete_task(user, index)
    if user.tasks[index]
      user.tasks.delete_at(index)
      puts "Tarea eliminada"
    else
      puts "Tarea no encontrada"
    end
  end

  def mark_task(user, index, completed)
    if task = user.tasks[index]
      completed ? task.mark_as_completed : task.mark_as_pending
      puts "Estado de la tarea actualizado"
    else
      puts "Tarea no encontrada"
    end
  end

  def list_tasks(user)
    puts "Tareas de #{user.username}:"
    user.tasks.each_with_index do |task, index|
      status = task.completed ? "Completada" : "Pendiente"
      puts "#{index + 1}. #{task.title} (#{status}) - Categoría: #{task.category || 'N/A'}"
      puts "   Descripción: #{task.description}"
    end
  end
end

# Ejemplo de uso
manager = TaskManager.new

# Registrar usuarios
manager.register_user("alice", "password123")
manager.register_user("bob", "securepass")

# Iniciar sesión
current_user = manager.login("alice", "password123")

if current_user
  # Añadir tareas
  manager.add_task(current_user, "Comprar groceries", "Leche, pan, huevos", "Personal")
  manager.add_task(current_user, "Preparar presentación", "Para la reunión del lunes", "Trabajo")

  # Listar tareas
  manager.list_tasks(current_user)

  # Editar una tarea
  manager.edit_task(current_user, 0, "Comprar groceries", "Leche, pan, huevos, frutas", "Personal")

  # Marcar una tarea como completada
  manager.mark_task(current_user, 1, true)

  # Eliminar una tarea
  manager.delete_task(current_user, 0)

  # Listar tareas actualizadas
  manager.list_tasks(current_user)
end
