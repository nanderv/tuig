local frame = {}
frame["set_counter"] = {start=function(line, lines, actor)
		pprint(line)
		lines["current_line"] = line["counter"]

		if lines[lines.current_line] and LINE_HANDLERS[lines[lines.current_line].name].start then
			LINE_HANDLERS[lines[lines.current_line].name].start(lines[lines.current_line], lines)
		end
	end
}

frame["idle"] ={start=function(line, _ , _)
	if line.duration then
		line.remaining_time = line.duration
	 	end
	end,
	 update= function(line, dt, object, lines)
	 	if not line.remaining_time and line.duration then
	 				line.remaining_time = line.duration
	 		end
	 	if line.remaining_time then
	 		if dt >= line.remaining_time then
	 			local return_value = dt - line.remaining_time
 				line.remaining_time = line.duration
 				print("BOINC")
	 			return return_value
	 		end

	 		line.remaining_time = line.remaining_time - dt
	 	end
	 		return 0
	end,
	draw=function(line, object)
		love.graphics.setColor(1,0,0)
		love.graphics.circle("fill", object.x,object.y, 50)
		love.graphics.setColor(1,1,1)
	end
	}

frame["cam_to_room"] = {start=function(_, _, _)
	end,
	 update=function(line, dt, object, lines)
	 	line.scene.scene_collection.current_room=line.room
	 	return dt
	end,
	draw=function(line, object)
		
	end
	}

return frame