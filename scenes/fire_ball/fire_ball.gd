extends RigidBody2D

##################################################
const MOVING_SPEED = 300.0
const TIMER_INTERVAL: float = 0.5

var navigation_agent_node: NavigationAgent2D
var enemy: CharacterBody2D
var timer: float = 0.0

##################################################
func _ready() -> void:
	navigation_agent_node = $NavigationAgent2D
	
	# 코너에서 벽에 끼임을 줄일 수 있는 옵션
	navigation_agent_node.path_postprocessing = \
	NavigationPathQueryParameters2D.PATH_POSTPROCESSING_EDGECENTERED
	
	# 인스턴스화와 함께 Enemy 그룹을 이동 목표로 설정
	enemy = get_tree().get_first_node_in_group("Enemy")
	navigation_agent_node.target_position = enemy.global_position

##################################################
func _process(delta: float) -> void:
	# 파이어볼이 경로에 다다르면 삭제 후 return
	if navigation_agent_node.is_navigation_finished():
		queue_free()
		return
	
	# 실시간 적의 위치를 추적하는데, 너무 잦은 호출을 막기 위함
	timer += delta
	if timer >= TIMER_INTERVAL:
		timer = 0.0
		navigation_agent_node.target_position = enemy.global_position
	
	# get_next_path_position()은 파이어볼이 이동해야 할 다음 위치를 나타냄
	var next_point = navigation_agent_node.get_next_path_position()
	var direction = (next_point - global_position).normalized()
	
	# 파이어볼 움직임 적용
	linear_velocity = direction * MOVING_SPEED
