extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.transition_scene == true:
		$AnimationPlayer.play("transition_from_scene")
	else:
		Global.transition_scene = true
