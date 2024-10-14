extends Area2D
 
@export var score: int

func _on_body_entered(body: Node2D) -> void:
	$AnimationPlayer.play("pick_up")
	queue_free()
