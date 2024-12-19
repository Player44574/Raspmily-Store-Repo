extends Button

var changeScene = 0

func _on_Button_pressed():
	$"../../../../../../AnimationPlayer".play("transition_to_new_scene")
	changeScene=1

func _on_AnimationPlayer_animation_finished(anim_name):
	if changeScene == 1:
		get_tree().change_scene("res://Scenes/The world editor/The world editor.tscn")
