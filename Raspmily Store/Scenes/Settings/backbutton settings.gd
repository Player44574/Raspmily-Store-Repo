extends Button

var close = 0

func _on_Button3_pressed():
	$"../../../../AnimationPlayer".play("animation_close_scene")
	close = 1

func _on_AnimationPlayer_animation_finished(anim_name):
	if close == 1:
		get_tree().change_scene("res://Main.tscn")
