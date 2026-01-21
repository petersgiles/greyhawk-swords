extends CharacterBody2D
class_name Enemy

@export_category("Stats")
@export var hitpoints: int = 180

func take_damage(damage_taken: int) -> void:
	hitpoints -= damage_taken
	if hitpoints <= 0:
		death()
		
func death() -> void:
	queue_free()
	
