@tool
extends Node

var dialogue: Array = [{
	"isMessage": true,
	"message": ""
}]

func _get_property_list() -> Array:
	var ret: Array = []

	ret.append({
		"name": "Messages",
		"type": TYPE_ARRAY,
		"hint": PROPERTY_HINT_ARRAY_TYPE,
		"hint_string": ""
	})

	return ret

func _set(prop_name: StringName, val) -> bool:
	match prop_name:
		"Messages":
			dialogue = val
			_update_fields()
			return true
		_:
			return false

func _get(prop_name: StringName):
	match prop_name:
		"Messages":
			return dialogue
		_:
			return null
			
func _update_fields():
	for index in range(dialogue.size()):
		var item = dialogue[index]
		
		if item == null:
			dialogue[index] = {
				"isMessage": true,
				"message": ""
			}
		else:
			if item.has("isMessage"):
				if item["isMessage"]:
					# When isMessage is true, clear message and ensure no event/params
					item["message"] = ""
					item.erase("event")
					item.erase("params")
					
				else:
					# When isMessage is false, ensure event and params are set
					if not item.has("event"):
						item["event"] = ""
					if not item.has("params"):
						item["params"] = [""]
						
					# Remove message if it exists
					item.erase("message")
	
	print_debug(dialogue)
