extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../AnimationPlayer".play("animation_to_scene")