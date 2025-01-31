extends Area2D

@export var ExplosionObj : PackedScene
@export var speed = 750

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.y * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.hit()
		var Ex = ExplosionObj.instantiate()
		Ex.position = self.global_position
		Ex.rotation = self.global_rotation
		get_parent().add_child(Ex)
		queue_free()

	if body.is_in_group("obstacles"):
#       body.hit()
		var Ex = ExplosionObj.instantiate()
		Ex.position = self.global_position
		Ex.rotation = self.global_rotation
		get_parent().add_child(Ex)
		queue_free()
		
