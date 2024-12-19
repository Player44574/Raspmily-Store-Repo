extends Node

var configuracion = ConfigFile.new()
var cerrar_launcher = 0
var betas = 0

func _ready():
	# Al iniciar el juego, leer la configuración y configurar los valores predeterminados si es necesario
	leer_configuracion()

	# Configurar estado de los botones basado en la configuración
	actualizar_botones()

# Leer configuración desde un archivo INI
func leer_configuracion():
	if configuracion.load("user://config.ini") != OK:
		print("No se pudo cargar el archivo de configuración.")
		configuracion.set_value("Opciones", "Activar betas", "false") # Configuración predeterminada
		configuracion.set_value("Opciones", "Cerrar launcher al iniciar", "true") # Configuración predeterminada
		guardar_configuracion()

# Guardar configuración en un archivo INI
func guardar_configuracion():
	var result = configuracion.save("user://config.ini")
	if result == OK:
		print("Configuración guardada correctamente.")
	else:
		print("No se pudo guardar la configuración. Código de error:", result)

# Función para manejar el cambio en el botón "Activar betas"
func _on_CheckButton_pressed():
	betas = configuracion.get_value("Opciones", "Activar betas", "false")
	if betas == "true":
		configuracion.set_value("Opciones", "Activar betas", "false")
	else:
		configuracion.set_value("Opciones", "Activar betas", "true")

	# Guardar la configuración actualizada
	guardar_configuracion()
	actualizar_botones()

# Función para manejar el cambio en el botón "Cerrar launcher al iniciar"
func _on_CheckButton2_pressed():
	cerrar_launcher = configuracion.get_value("Opciones", "Cerrar launcher al iniciar", "false")
	if cerrar_launcher == "true":
		configuracion.set_value("Opciones", "Cerrar launcher al iniciar", "false")
	else:
		configuracion.set_value("Opciones", "Cerrar launcher al iniciar", "true")

	# Guardar la configuración actualizada
	guardar_configuracion()
	actualizar_botones()

# Función para actualizar el estado de los botones según la configuración
func actualizar_botones():
	if configuracion.has_section("Opciones"):
		var betas = configuracion.get_value("Opciones", "Activar betas", "false")
		if betas == "true":
			$MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/CheckButton.pressed = true
		else:
			$MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/CheckButton.pressed = false

		var cerrar_launcher = configuracion.get_value("Opciones", "Cerrar launcher al iniciar", "false")
		if cerrar_launcher == "true":
			$MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/CheckButton2.pressed = true
		else:
			$MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/CheckButton2.pressed = false
	else:
		print("La sección 'Opciones' no se encontró en el archivo de configuración.")
