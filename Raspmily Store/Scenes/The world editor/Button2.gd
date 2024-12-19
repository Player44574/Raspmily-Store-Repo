extends Button


var version = 1.0

var exe_path = "user://The world editor " + str(version) +"/The world editor.exe"
var win_path = "user://The world editor " + str(version) +"/data.win"
var options_path = "user://The world editor " + str(version) +"/options.ini"
var version_path = "user://The world editor " + str(version) +"/verionList.txt"
var fmodL_path = "user://The world editor " + str(version) +"/fmodL.dll"
var fmodStudioL_path = "user://The world editor " + str(version) +"/fmodstudioL.dll"
var YYFMOD_path = "user://The world editor " + str(version) +"/YYFMOD.dll"

const install_icon = preload("res://Icons/download_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png")
const play_icon = preload("res://Icons/stadia_controller_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png")
const update_icon = preload("res://Icons/update_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png")

func _ready():
	#var directory = Directory.new()
	#if not directory.dir_exists("user://The world editor " + str(version) +"/"):
	#	self.disabled = true
	pass

func _on_Button2_pressed():
	version = $"../../../OptionButton".text
	var dir = Directory.new()
	dir.remove(exe_path)
	dir.remove(win_path)
	dir.remove(options_path)
	dir.remove(version_path)
	if version >= "1.3.3":
		dir.remove(fmodL_path)
		dir.remove(fmodStudioL_path)
		dir.remove(YYFMOD_path)
	dir.remove("user://The world editor " + str(version) +"/")
	self.disabled = true
	$"../../Play_Install_button/TextureRect".texture = install_icon


func _on_OptionButton_item_selected(index):
	version = $"../../../OptionButton".text
	exe_path = "user://The world editor " + str(version) +"/The world editor.exe"
	win_path = "user://The world editor " + str(version) +"/data.win"
	options_path = "user://The world editor " + str(version) +"/options.ini"
	version_path = "user://The world editor " + str(version) +"/verionList.txt"
	fmodL_path = "user://The world editor " + str(version) +"/fmodL.dll"
	fmodStudioL_path = "user://The world editor " + str(version) +"/fmodstudioL.dll"
	YYFMOD_path = "user://The world editor " + str(version) +"/YYFMOD.dll"
