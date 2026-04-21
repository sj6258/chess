extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const SPRITE_SIZE = 16
const CELL_SIZE = 60

const X_OFFSET = 30
const Y_OFFSET = 30

@export var piece_type : Globals.PIECE_TYPES
@export var color : Globals.COLORS
@export var board_position : Vector2

var board_handle;

@export var moved : bool;

func init_piece(
	type : Globals.PIECE_TYPES,
	col : Globals.COLORS,
	board_pos: Vector2,
	board
):
	piece_type = type
	color = col
	board_position = board_pos
	board_handle = board
	moved = false
	
	update_sprite()
	
	position = Vector2(
		X_OFFSET + board_position[0] * CELL_SIZE,
		Y_OFFSET + board_position[1] * CELL_SIZE,
	)
	
func update_sprite():
	if sprite_2d:
		var region_pos = Globals.SPRITE_MAPPING[color][piece_type]
		sprite_2d.region_rect = Rect2(
			region_pos.y * SPRITE_SIZE,
			region_pos.x * SPRITE_SIZE,
			SPRITE_SIZE,
			SPRITE_SIZE
		)

func move_position(to_move: Vector2):
	moved = true
	board_position = to_move
	position =  Vector2(
		X_OFFSET + board_position[0] * CELL_SIZE,
		Y_OFFSET + board_position[1] * CELL_SIZE,
	)
	if piece_type == Globals.PIECE_TYPES.KING:
		board_handle.register_king(board_position, color)
		
		
	if piece_type == Globals.PIECE_TYPES.PAWN and (
		(color == Globals.COLORS.BLACK and to_move[1] == 7) or 
		(color == Globals.COLORS.WHITE and to_move[1] == 0)
	):
		piece_type = Globals.PIECE_TYPES.QUEEN
		update_sprite()

func clone(_board):
	var piece = self.duplicate()
	piece.board_handle = _board
	return piece
