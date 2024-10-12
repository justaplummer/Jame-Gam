extends Node

class_name Stopwatch

var time = 0.0
var stopped = false

func _process(delta: float) -> void:
	if stopped:
		return
	time += delta
	#print(time_to_string())
	
func reset():
	time = 0.0

func time_to_string() -> String:
	#turns time into a string for UI Display format 00:00:000
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var minute = time / 60
	var format_string = "%02d : %02d : %03d"
	var actual_string = format_string % [minute, sec, msec]
	return actual_string 

func get_time_as_number() -> float:
	return time
	
