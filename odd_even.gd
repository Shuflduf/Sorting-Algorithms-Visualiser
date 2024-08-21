extends Sorter


func sort():
	while !owner.sorted():
		#var bar = %Bars.get_child(pos)
		#var prev_bar = %Bars.get_child(pos - 1)

		for i in range(1, %Bars.get_child_count() - 1, 2):
			if %Bars.get_child(i).custom_minimum_size.y > \
					%Bars.get_child(i + 1).custom_minimum_size.y:
				await owner.swap_bars(i, i + 1)

		for i in range(0, %Bars.get_child_count() - 1, 2):
			if %Bars.get_child(i).custom_minimum_size.y > \
					%Bars.get_child(i + 1).custom_minimum_size.y:
				await owner.swap_bars(i, i + 1)
