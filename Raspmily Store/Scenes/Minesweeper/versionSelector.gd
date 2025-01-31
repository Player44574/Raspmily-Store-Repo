extends OptionButton

var versionList_link = "https://raw.githubusercontent.com/Player44574/Raspmily-Store-Repo/refs/heads/main/WindowsDesktop/MineSweeper/version.ini"
var versionList_path = "user://MineSweeper/version.ini"

var http_request: HTTPRequest

var configuracion = ConfigFile.new()
var betas = 0

func _ready():
	$"../HBoxContainer/Play_Install_button/Button".disabled = true
	var directory = Directory.new()
	if not directory.dir_exists("user://MineSweeper/"):
		directory.make_dir("user://MineSweeper/")
	directory.remove(versionList_path)
	
	_download_file(versionList_link, versionList_path, false)

func _download_file(link: String, path: String, just_version: bool):
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_install_file", [path, just_version])
	
	#Handle errors
	var error = http_request.request_raw(link)

# This ts called once the download is complete
func _install_file(_result, _response_code, _headers, body, path, just_version: bool):
	var dir = Directory.new()
	dir.remove(path)
	
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_buffer(body)
	file.close()
	
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("user://MineSweeper/version.ini")

	# If the file didn't load, ignore it.
	if err != OK:
		print(err)

	if config.has_section("Versions"):
		print("Section 'Versions' found.")
		# Iterate over all keys in the section "Versions".
		for i in range(0, config.get_section_keys("Versions").size()):
			# Construct the key using the index.
			var key = str(i)
			# Add each key's value to your list
			self.add_item(config.get_value("Versions", key))
			self.select(i)
			var version = config.get_value("Versions", key)
			$"../HBoxContainer/Play_Install_button/Button".disabled = false
			$"../HBoxContainer/Play_Install_button/Button".version = version
			$"../HBoxContainer/Play_Install_button/Button".exe_link = "https://github.com/Player44574/Raspmily-Store-Repo/raw/refs/heads/main/WindowsDesktop/MineSweeper/MineSweeper%20V"+str(version)+"/Buscaminas.exe" 
			$"../HBoxContainer/Play_Install_button/Button".win_link = "https://github.com/Player44574/Raspmily-Store-Repo/raw/refs/heads/main/WindowsDesktop/MineSweeper/MineSweeper%20V"+str(version)+"/data.win"
			$"../HBoxContainer/Play_Install_button/Button".options_link = "https://raw.githubusercontent.com/Player44574/Raspmily-Store-Repo/refs/heads/main/WindowsDesktop/MineSweeper/MineSweeper%20V"+str(version)+"/options.ini"
			$"../HBoxContainer/Play_Install_button/Button".exe_path = "user://MineSweeper " + str(version) +"/MineSweeper.exe"
			$"../HBoxContainer/Play_Install_button/Button".win_path = "user://MineSweeper " + str(version) +"/data.win"
			$"../HBoxContainer/Play_Install_button/Button".options_path = "user://MineSweeper " + str(version) +"/options.ini"

			
			$"../HBoxContainer/Uninstall_button/Button2".version = version
			$"../HBoxContainer/Uninstall_button/Button2".exe_path = "user://MineSweeper " + str(version) +"/MineSweeper.exe"
			$"../HBoxContainer/Uninstall_button/Button2".win_path = "user://MineSweeper " + str(version) +"/data.win"
			$"../HBoxContainer/Uninstall_button/Button2".options_path = "user://MineSweeper " + str(version) +"/options.ini"
			
			$"../HBoxContainer/Play_Install_button/Button"._update_text()
