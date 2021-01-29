extends CPUParticles2D

onready var sound = $sound

func _ready():
	self.emitting = true
	$smoke.emitting = true
	if sound != null:
		sound.play()
	if get_parent().name == "player" or get_parent().name != "earth":
		$Timer.start()

func _on_Timer_timeout():
	get_parent().queue_free()
