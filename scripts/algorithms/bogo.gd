extends Sorter


func sort():
	while !owner.is_sorted():
		await get_tree().process_frame
		owner.shuffle_bars()
