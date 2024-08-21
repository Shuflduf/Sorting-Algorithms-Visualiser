extends Sorter


func sort():
	var pos = 0
	while !owner.is_sorted():
		#await get_tree().process_frame
		#for i in %Bars.get_child_count() - 1:
		var bar = %Bars.get_child(pos)
		var prev_bar = %Bars.get_child(pos - 1)

		if pos == 0 or bar.custom_minimum_size.y >= prev_bar.custom_minimum_size.y:
			pos += 1
		else:
			await owner.swap_bars(pos, pos - 1)
			pos -= 1
