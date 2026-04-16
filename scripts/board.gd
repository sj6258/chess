extends Node2D

@export var pieces = [] ;
@export var piece_scene = preload("res://scene/piece.tscn")

@export var white_king_pos : Vector2
@export var black_king_pos : Vector2

const CELL_SIZE = 60


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_board()


func draw_board():
	for x in range(8):
		for y in range(8):
			draw_cell(x , y)

func draw_cell(x,y):
	var rect = ColorRect.new()
	rect.color = Color(1, 0.9, 0.7) if (x + y) % 2 == 0 else Color(0.3, 0.2, 0.1)
	rect.size = Vector2(CELL_SIZE, CELL_SIZE)
	rect.position = Vector2(
		x * CELL_SIZE,
		y * CELL_SIZE
	)
	rect.z_index = -100
	add_child(rect)
