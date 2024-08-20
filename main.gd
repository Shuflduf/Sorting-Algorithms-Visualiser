extends Control

@export var count = 5
@export var bar_scene: PackedScene

var max_size: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	max_size = %Bar.size.y
	%Bar.queue_free()
	for i in count:
		var height = float(i + 1) / float(count)
		var new_bar: Panel = bar_scene.instantiate()
		print(height)
		%Bars.add_child(new_bar)
		new_bar.custom_minimum_size.y = height * max_size
		#new_bar.size_flags_vertical = Control.SIZE_SHRINK_END


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass
