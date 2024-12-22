extends Button

var changeScene = 0

func _on_AnimationPlayer_animation_finished(anim_name):
	if changeScene == 1:
		get_tree().change_scene("res://Scenes/Minesweeper/Minesweeper.tscn")

func _on_Button_pressed():
	changeScene=1
	$"../../../../../../AnimationPlayer".play("transition_to_new_scene")
