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

def show_menu
  puts "\n--- Menú de Opciones ---"
  puts "1. Añadir tarea"
  puts "2. Editar tarea"
  puts "3. Eliminar tarea"
  puts "4. Marcar tarea como completada"
  puts "5. Marcar tarea como pendiente"
  puts "6. Listar tareas"
  puts "7. Salir"
end

def main
  manager = TaskManager.new

  # Registrar usuarios
  manager.register_user("alice", "password123")
  manager.register_user("bob", "securepass")

  # Iniciar sesión
  puts "Bienvenido, por favor inicie sesión"
  print "Nombre de usuario: "
  username = gets.chomp
  print "Contraseña: "
  password = gets.chomp

  current_user = manager.login(username, password)

  if current_user
    loop do
      show_menu
      print "\nElige una opción: "
      option = gets.chomp.to_i

      case option
      when 1
        # Añadir tarea
        print "Título de la tarea: "
        title = gets.chomp
        print "Descripción de la tarea: "
        description = gets.chomp
        print "Categoría de la tarea (opcional): "
        category = gets.chomp
        category = nil if category.empty?
        manager.add_task(current_user, title, description, category)

      when 2
        # Editar tarea
        manager.list_tasks(current_user)
        print "Número de la tarea a editar: "
        task_index = gets.chomp.to_i - 1
        print "Nuevo título: "
        title = gets.chomp
        print "Nueva descripción: "
        description = gets.chomp
        print "Nueva categoría (opcional): "
        category = gets.chomp
        category = nil if category.empty?
        manager.edit_task(current_user, task_index, title, description, category)

      when 3
        # Eliminar tarea
        manager.list_tasks(current_user)
        print "Número de la tarea a eliminar: "
        task_index = gets.chomp.to_i - 1
        manager.delete_task(current_user, task_index)

      when 4
        # Marcar tarea como completada
        manager.list_tasks(current_user)
        print "Número de la tarea a marcar como completada: "
        task_index = gets.chomp.to_i - 1
        manager.mark_task(current_user, task_index, true)

      when 5
        # Marcar tarea como pendiente
        manager.list_tasks(current_user)
        print "Número de la tarea a marcar como pendiente: "
        task_index = gets.chomp.to_i - 1
        manager.mark_task(current_user, task_index, false)

      when 6
        # Listar tareas
        manager.list_tasks(current_user)

      when 7
        # Salir
        puts "Saliendo del sistema..."
        break

      else
        puts "Opción no válida, intenta de nuevo."
      end
    end
  else
    puts "Error al iniciar sesión"
  end
end

# Ejecutar el programa
main
