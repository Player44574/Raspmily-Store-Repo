extends Button

var version = "1.0"

var configuracion = ConfigFile.new()
var cerrar_launcher = 0

var exe_link = "https://github.com/Player44574/Raspmily-Store-Repo/raw/refs/heads/main/WindowsDesktop/MineSweeper/MineSweeper%20V"+str(version)+"/Buscaminas.exe" 
var win_link = "https://github.com/Player44574/Raspmily-Store-Repo/raw/refs/heads/main/WindowsDesktop/MineSweeper/MineSweeper%20V"+str(version)+"/data.win"
var options_link = "https://raw.githubusercontent.com/Player44574/Raspmily-Store-Repo/refs/heads/main/WindowsDesktop/MineSweeper/MineSweeper%20V"+str(version)+"/options.ini"

var exe_path = "user://MineSweeper " + str(version) +"/MineSweeper.exe"
var win_path = "user://MineSweeper " + str(version) +"/data.win"
var options_path = "user://MineSweeper " + str(version) +"/options.ini"

var http_request: HTTPRequest

const install_icon = preload("res://Icons/download_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png")
const play_icon = preload("res://Icons/stadia_controller_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png")
const update_icon = preload("res://Icons/update_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png")

const clock_loader_20 = preload("res://Icons/clock_loader_20_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png")
const clock_loader_60 = preload("res://Icons/clock_loader_60_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png")
const clock_loader_90 = preload("res://Icons/clock_loader_90_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png")

func _ready():
	leer_configuracion()

func leer_configuracion():
	if configuracion.load("user://config.ini") != OK:
		print("No se pudo cargar el archivo de configuración.")
		configuracion.set_value("Opciones", "Cerrar launcher al iniciar", "true") # Configuración predeterminada

func _update_text():
	if not file_exists(exe_path) or not file_exists(win_path) or not file_exists(options_path):
		$"../TextureRect".texture = install_icon
	else:
		$"../TextureRect".texture = play_icon

func file_exists(path: String) -> bool:
	var dir = Directory.new()
	return dir.file_exists(path)

func _verify_game_files():
	var directory = Directory.new()
	if not directory.dir_exists("user://MineSweeper " + str(version) +"/"):
		directory.make_dir("user://MineSweeper " + str(version) +"/")
	
	if not file_exists(exe_path) && not file_exists(win_path) && not file_exists(options_path):
		_check_integrity()

func _download_file(link: String, path: String):
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_install_file", [path])
	
	#Handle errors
	var error = http_request.request_raw(link)
	if error!= OK:
		#self.text = "Download error: " + str(error)
		pass

# This ts called once the download is complete
func _install_file(_result, _response_code, _headers, body, path):
	var dir = Directory.new()
	dir.remove(path)
	
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_buffer(body)
	file.close()
	_check_integrity()
	
func _check_integrity():
	if !file_exists(exe_path):
		_download_file(exe_link, exe_path)
		$"../TextureRect".texture = clock_loader_20
		print("no exe")
		return
	
	if !file_exists(win_path):
		_download_file(win_link, win_path)
		$"../TextureRect".texture = clock_loader_60
		print("no win")
		return
		
	if !file_exists(options_path):
		_download_file(options_link, options_path)
		$"../TextureRect".texture = clock_loader_90
		print("no options")
		return
	
	$"../TextureRect".texture = play_icon
	self.disabled = false
	$"../../Uninstall_button/Button2".disabled = false

func _start_game():
	OS.shell_open(OS.get_user_data_dir() + "/MineSweeper " + str(version) +"/MineSweeper.exe")
	cerrar_launcher = configuracion.get_value("Opciones", "Cerrar launcher al iniciar", "false")
	if cerrar_launcher == "true":
		get_tree().quit()

func _on_OptionButton_item_selected(index):
	version = $"../../../OptionButton".text
	
	exe_link = "https://github.com/Player44574/Raspmily-Store-Repo/raw/refs/heads/main/WindowsDesktop/MineSweeper/MineSweeper%20V"+str(version)+"/Buscaminas.exe" 
	win_link = "https://github.com/Player44574/Raspmily-Store-Repo/raw/refs/heads/main/WindowsDesktop/MineSweeper/MineSweeper%20V"+str(version)+"/data.win"
	options_link = "https://raw.githubusercontent.com/Player44574/Raspmily-Store-Repo/refs/heads/main/WindowsDesktop/MineSweeper/MineSweeper%20V"+str(version)+"/options.ini"

	exe_path = "user://MineSweeper " + str(version) +"/MineSweeper.exe"
	win_path = "user://MineSweeper " + str(version) +"/data.win"
	options_path = "user://MineSweeper " + str(version) +"/options.ini"
	
	if not file_exists(exe_path) or not file_exists(win_path) or not file_exists(options_path):
		$"../TextureRect".texture = install_icon
		$"../../Uninstall_button/Button2".disabled = true
	else:
		$"../TextureRect".texture = play_icon
		$"../../Uninstall_button/Button2".disabled = false

func _on_Button_pressed():
	if $"../TextureRect".texture == install_icon:
		_verify_game_files()
		self.disabled = true
	else:
		_start_game()
