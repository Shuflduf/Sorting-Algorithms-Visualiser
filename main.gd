extends Control

@export var count = 5
@export var bar_scene: PackedScene

var max_size: int

func get_max_size() -> int:
	await get_tree().process_frame
	var max = %Bar.size.y
	%Bar.queue_free()
	return max

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_size = await get_max_size()
	for i in count:
		var height = float(i + 1) / float(count)
		var new_bar: Panel = bar_scene.instantiate()
		%Bars.add_child(new_bar)
		new_bar.custom_minimum_size.y = height * max_size

	await swap_bars(2, 4)
	await swap_bars(1, 3)
	await swap_bars(1, 0)

func swap_bars(first: int, second: int):
	await get_tree().process_frame

	var first_bar = %Bars.get_child(first)
	var second_bar = %Bars.get_child(second)

	var first_pos = first_bar.position.x
	var second_pos = second_bar.position.x
	print(first_pos, ", ", second_pos)

	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC)
	tween.parallel().tween_property(first_bar, "position:x", second_pos, 0.5)
	tween.parallel().tween_property(second_bar, "position:x", first_pos, 0.5)
	await tween.finished

	%Bars.move_child(first_bar, second)
	%Bars.move_child(second_bar, first)

	return

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		print(event.global_position)
