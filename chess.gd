extends Sprite2D

const TEXTURE_HOLDER = preload("uid://cm3na3m4st3es")

const BOARD_SIZE = 8
const CELL_WIDTH = 18

const BLACK_BISHOP = preload("uid://iriq5b3cvgk1")
const BLACK_KING = preload("uid://bscyoebj3nu4o")
const BLACK_KNIGHT = preload("uid://csrworn4naka7")
const BLACK_PAWN = preload("uid://bxrbu0o7w3uem")
const BLACK_QUEEN = preload("uid://bw36kll3arest")
const BLACK_ROOK = preload("uid://cinio41yurxv7")
const WHITE_KING = preload("uid://blnyy3g18ivql")
const WHITE_KNIGHT = preload("uid://b6aqfckmx1avm")
const WHITE_PAWN = preload("uid://bexn04pp3oix2")
const WHITE_QUEEN = preload("uid://kvg3d50spw5n")
const WHITE_BISHOP = preload("uid://bb68wbltklgwt")
const WHITE_ROOK = preload("uid://dty5xen05wmvh")

const TURN_WHITE = preload("uid://06v2lko1cf8n")
const TURN_BLACK = preload("uid://medq52p2ytpn")

@onready var pieces: Node2D = $Pieces
@onready var dots: Node2D = $Dots
@onready var turn: Sprite2D = $Turn


# -6 = black king
# -5 = black queen
# -4 = black rook
# -3 = black bishop
# -2 = black knight
# -1 = black pawn
# 0 = empty
# 6 = white king
# 5 = white queen
# 4 = white rook
# 3 = white bishop
# 2 = white knight
# 1 = white pawn

var board : Array
var white : bool
var state : bool
var moves = []
var selected_piece : Vector2

func _ready() -> void:
	board.append([ 4, 2, 3, 5, 6, 3, 2, 4])
	board.append([ 1, 1, 1, 1, 1, 1, 1, 1])
	board.append([ 0, 0, 0, 0, 0, 0, 0, 0])
	board.append([ 0, 0, 0, 0, 0, 0, 0, 0])
	board.append([ 0, 0, 0, 0, 0, 0, 0, 0])
	board.append([ 0, 0, 0, 0, 0, 0, 0, 0])
	board.append([ -1, -1, -1, -1, -1, -1, -1, -1])
	board.append([ -4, -2, -3, -5, -6, -3, -2, -4])
	
	display_board()

func _input(event):
	if event is InputEventMouseButton && event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if is_mouse_out(): return
			var var1 = snapped(get_global_mouse_position().x, 0) / CELL_WIDTH
			var var2 = abs(snapped(get_global_mouse_position().y, 0)) / CELL_WIDTH
			print(var1, var2)


func is_mouse_out():
	if get_global_mouse_position().x < 0 || get_global_mouse_position().x > 144 || get_global_mouse_position().y > 0 || get_global_mouse_position().y < -144: return true
	return false

func display_board():
	for i in BOARD_SIZE:
		for j in BOARD_SIZE:
			var holder = TEXTURE_HOLDER.instantiate()
			pieces.add_child(holder)
			holder.global_position = Vector2(j * CELL_WIDTH + (CELL_WIDTH/2), -i * CELL_WIDTH - (CELL_WIDTH/2))
			
			
			match board[i][j]:
				-6: holder.texture = BLACK_KING
				-5: holder.texture = BLACK_QUEEN
				-4: holder.texture = BLACK_ROOK
				-3: holder.texture = BLACK_BISHOP
				-2: holder.texture = BLACK_KNIGHT
				-1: holder.texture = BLACK_PAWN
				0: holder.texture = null
				6: holder.texture = WHITE_KING
				5: holder.texture = WHITE_QUEEN
				4: holder.texture = WHITE_ROOK
				3: holder.texture = WHITE_BISHOP
				2: holder.texture = WHITE_KNIGHT
				1: holder.texture = WHITE_PAWN
