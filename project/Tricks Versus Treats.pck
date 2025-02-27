GDPC                �                                                                      !   P   res://.godot/exported/133200997/export-2ddd04d543d5858e7f20c9299a8b5096-main.scnp      p      �:Ӱ|����H(�    T   res://.godot/exported/133200997/export-478521028d04bf07f9c7de24d64609e3-powerup.scn �4            ~��΢�0N�x���V    T   res://.godot/exported/133200997/export-7111e2a4ba75c4a329f0f9553f2950f2-enemy.scn   P      �      K���U��l8�go�]�    T   res://.godot/exported/133200997/export-ebb3521b4f0ab2fc80eef1183e18e924-bullet.scn          \      C0����ؚ̄��q��    ,   res://.godot/global_script_class_cache.cfg  p�             ��Р�8���8~$}P�    L   res://.godot/imported/hitHurt(1).wav-6e5667bb59306c6f633cb842eb5aa9ff.samplep<      2      �S�?E�ٯs�͘�W�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexPV            ：Qt�E�cO���    P   res://.godot/imported/laserShoot(1).wav-8380dfe10a9fb346f78362164eb53ebf.sample @d      �      ��,��錥�5���    P   res://.godot/imported/pixil-frame-0(2).png-5822c6eb8494c6407bfe1c5b62c42373.ctex�p      �       mh�8�t�H����XBx�    P   res://.godot/imported/pixil-frame-0(3).png-68bd815c95e3878ae3083d23dd2c52ef.ctex`r      �      i{�x�YL���8���    P   res://.godot/imported/pixil-frame-0(4).png-4aa065ee58ec3b42fb204cf8f0376d7a.ctex0w            ���"��	����    H   res://.godot/imported/witch.png-575be3cff0e2173a9820c570825795de.ctex    y      F      ' ��hM3@>�Mn#q�    H   res://.godot/imported/zombie.png-c3b3bc9d5f5ee77c87d3298dd185606a.ctex  @|      �      �f��{��;���~J�       res://.godot/uid_cache.bin  P�      �      n�v^�\��X���b       res://Bullet.gd P:            k��]:�]�A�����       res://Scenes/EnemySpawn.gd  P             ����'��'*�4���        res://Scenes/bullet.tscn.remap  �      c       d|t�l~��*N��Y�       res://Scenes/enemy.gd   `      �      ���fo-���oW)�l@        res://Scenes/enemy.tscn.remap    �      b       �n�O�H'�6�YYh+       res://Scenes/main.tscn.remap��      a       F�����X�����       res://Scenes/player.gd  �.      �      W��-�GV��>��]?Fs       res://Scenes/powerup.gd @9            :{!rXS"�Y�����        res://Scenes/powerup.tscn.remap  �      d       ����Շi합}�3�\       res://hitHurt(1).wav.import �U      �       �q����H��J16���3       res://icon.svg  ��      �      k����X3Y���f       res://icon.svg.import   pc      �       c�N���o���[�"�d        res://laserShoot(1).wav.import  p      �       �Tk�.���;�n��W�    $   res://pixil-frame-0(2).png.import   �q      �       �`�w&�i��.1o�Xl    $   res://pixil-frame-0(3).png.import   `v      �       �8��)D{���/x    $   res://pixil-frame-0(4).png.import   Px      �       5�Q2�
�j,U�6�       res://project.binary �      �      �}ęM��x�3�2�b�       res://witch.png.import  p{      �       /˷jdޖ�Il^cy��       res://zombie.png.import �~      �       ����2&(�w���                RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       Script    res://Bullet.gd ��������
   Texture2D    res://pixil-frame-0(2).png �*-
��c[      local://CircleShape2D_nftfu �         local://CircleShape2D_s05p3 �         local://PackedScene_agkf1          CircleShape2D            @B         CircleShape2D             B         PackedScene          	         names "         Bullet    z_index    collision_layer    collision_mask    script    CharacterBody2D    CollisionShape2D    shape 	   Sprite2D    texture_filter    scale    texture    Area2D    _on_area_2d_body_entered    body_entered    	   variants    	                                          
     �@  �@                              node_count             nodes     9   ��������       ����                                              ����                           ����   	       
                              ����                                ����                   conn_count             conns                                      node_paths              editable_instances              version             RSRC    extends CharacterBody2D

var player_chase = false
var player = null
var enemy_move : Vector2
var flip = 1
var anim : int
var health = 3
const ENEMY_SPEED = 200

func _ready():
	var random = randi_range(0, 1)
	if random == 0:
		position.x = randi_range(0, 1) * 1920
		position.y = randi_range(0, 1080)
	else:
		position.x = randi_range(0, 1920)
		position.y = randi_range(0, 1) * 1080
	$ProgressBar.value = 3

func _process(delta):
	if player_chase:
		enemy_move.x = 0
		enemy_move.y = 0
		if abs(player.position.x - position.x) > 15:
			anim = 1
			enemy_move.x += ((player.position.x - position.x) / abs(player.position.x - position.x)) * ENEMY_SPEED * delta
			if flip == -1 * (player.position.x - position.x) / abs(player.position.x - position.x):
				flip = (player.position.x - position.x) / abs(player.position.x - position.x)
				scale.x = -1
		if abs(player.position.y - position.y) > 15:
			anim = 1
			enemy_move.y += ((player.position.y - position.y) / abs(player.position.y - position.y)) * ENEMY_SPEED * delta
		move_and_collide(enemy_move)
		
		if anim == 1:
			$AnimatedSprite2D.play("Walk")
		else:
			$AnimatedSprite2D.play("Idle")
	if health < 1:
		if health < 0:
			queue_free()
		else:
			health -= 1

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true

func _on_area_2d_body_exited(body):
	player = null
	player_chase = false

func _on_bullet_detect_body_entered(body):
	health -= 1
	$ProgressBar.value = health
	$HitSound.play()
	move_and_collide(enemy_move * -5)
            RSRC                    PackedScene            ��������                                            &      resource_local_to_scene    resource_name    custom_solver_bias    radius    script    atlas    region    margin    filter_clip    animations    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom 	   bg_color    draw_center    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    shadow_color    shadow_size    shadow_offset    anti_aliasing    anti_aliasing_size 	   _bundled       Script    res://Scenes/enemy.gd ��������
   Texture2D    res://zombie.png A=H�`   AudioStream    res://hitHurt(1).wav ��tAM��S
      local://CircleShape2D_ckiqh p         local://AtlasTexture_l0j2q �         local://AtlasTexture_o2hgr �         local://AtlasTexture_8a6s1 $         local://SpriteFrames_8skn2 i         local://CircleShape2D_s64iu N         local://CircleShape2D_pomkm x         local://StyleBoxFlat_3umu5 �         local://StyleBoxFlat_0ut0l 	         local://PackedScene_wve61 <	         CircleShape2D            @B         AtlasTexture                        �B       B   B         AtlasTexture                                 B   B         AtlasTexture                         B       B   B         SpriteFrames    	                     name ,      Idle       speed      �@      loop             frames                   texture             	   duration      �?            name ,      Walk       speed      �@      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?         CircleShape2D          ��D         CircleShape2D            �B         StyleBoxFlat                        �?         A         A         A         A         StyleBoxFlat          ��H>��?��H>  �?         PackedScene    %      	         names "   %      Enemy    y_sort_enabled    collision_layer    collision_mask    script    CharacterBody2D    CollisionShape2D    shape    AnimatedSprite2D    texture_filter 	   position    scale    sprite_frames 
   animation    frame_progress    PlayerDetect    Area2D    BulletDetect 	   HitSound    stream    AudioStreamPlayer    ProgressBar    z_index    offset_left    offset_top    offset_right    offset_bottom !   theme_override_styles/background    theme_override_styles/fill 
   max_value    value    show_percentage    _on_area_2d_body_entered    body_entered    _on_area_2d_body_exited    body_exited    _on_bullet_detect_body_entered    	   variants                                                   
    �6 ��
     �@  �@         ,      Walk    d��=                                              �     ��      B     ��                       @@             node_count    	         nodes     s   ��������       ����                                              ����                           ����   	      
                     	      
                     ����                     ����                           ����                                ����                           ����                           ����
                                                                         conn_count             conns               !                         #   "                     !   $                    node_paths              editable_instances              version             RSRC          extends Node

@onready var main = $".."

var enemy_scene := preload("res://Scenes/enemy.tscn")

func _on_enemy_countdown_timeout():
	for i in 5:
		var enemy = enemy_scene.instantiate()
		main.add_child(enemy)
		$"../EnemyCountdown".wait_time = (1.5 - $"../EnemyCountdown".wait_time) / 30
RSRC                    PackedScene            ��������                                            &      resource_local_to_scene    resource_name    custom_solver_bias    radius    script    atlas    region    margin    filter_clip    animations    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom 	   bg_color    draw_center    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    shadow_color    shadow_size    shadow_offset    anti_aliasing    anti_aliasing_size 	   _bundled       Script    res://Scenes/player.gd ��������
   Texture2D    res://witch.png ��0�[n="   Script    res://Scenes/EnemySpawn.gd ��������
   Texture2D    res://pixil-frame-0(3).png ��a3F8�S   AudioStream    res://laserShoot(1).wav M]�k��@   AudioStream    res://hitHurt(1).wav ��tAM��S
      local://CircleShape2D_cjwyf          local://AtlasTexture_g55ij 5         local://AtlasTexture_6tqdp z         local://AtlasTexture_18egs �         local://SpriteFrames_o8wqd          local://CircleShape2D_b4cu7 &	         local://CircleShape2D_5bh66 P	         local://StyleBoxFlat_5udnm z	         local://StyleBoxFlat_jm046 �	         local://PackedScene_5ubj1 
         CircleShape2D          e�@B         AtlasTexture                                 B   B         AtlasTexture                        �B       B   B         AtlasTexture                         B       B   B         SpriteFrames    	                     name ,      Idle       speed      �?      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            name ,      Walk       speed       A      loop             frames                   texture             	   duration      �?            texture             	   duration      �?            texture             	   duration      �?         CircleShape2D          �?�B         CircleShape2D          �?�B         StyleBoxFlat                        �?         A         A         A         A         StyleBoxFlat          ��H>��?��H>  �?         PackedScene    %      	         names "   /      Main    Node2D    Player    z_index    y_sort_enabled 	   position    script    CharacterBody2D    CollisionShape2D    shape    AnimatedSprite2D    texture_filter    scale    sprite_frames 
   animation    frame_progress    Area2D    collision_layer    collision_mask    powerupdetect    EnemySpawn    Node    EnemyCountdown 
   wait_time 
   autostart    Timer 	   Sprite2D    texture    ProgressBar    offset_left    offset_top    offset_right    offset_bottom !   theme_override_styles/background    theme_override_styles/fill 
   max_value    value    show_percentage    ShootSound    stream    AudioStreamPlayer 	   HitSound    _on_area_2d_body_entered    body_entered    _on_powerupdetect_body_entered    _on_enemy_countdown_timeout    timeout    	   variants                   
     pD  D                          
    ����@
     �@  �@         ,      Idle    ��>                                             @@   ����                    �A     $D     C                       �@     �@                               node_count             nodes     �   ��������       ����                      ����                                             ����   	                 
   
   ����                              	      
                    ����                                 ����   	                       ����                                ����   	                        ����                           ����                                 ����                                                   ����
                                  !      "      #      $      %                  (   &   ����   '                  (   )   ����   '                conn_count             conns              +   *                    +   ,              	      .   -                    node_paths              editable_instances              version             RSRCextends CharacterBody2D

@onready var main = $".."

const PLAYER_SPEED = 500
var player_move : Vector2
var flip = 1
var bullet_scene := preload("res://Scenes/bullet.tscn")
var shoot = 0
var health = 5
var powerup = 0

func _ready():
	$"../ProgressBar".value = 5

func _process(delta):
	player_move.x = 0
	player_move.y = 0
	
	if Input.is_action_pressed("ui_right"):
		player_move.x += PLAYER_SPEED * delta
		if flip == -1 and not Input.is_action_pressed("ui_left"):
			flip = 1
			scale.x = -1
	if Input.is_action_pressed("ui_left"):
		player_move.x -= PLAYER_SPEED * delta
		if flip == 1 and not Input.is_action_pressed("ui_right"):
			flip = -1
			scale.x = -1
	if Input.is_action_pressed("ui_down"):
		player_move.y += PLAYER_SPEED * delta
	if Input.is_action_pressed("ui_up"):
		player_move.y -= PLAYER_SPEED * delta
	
	move_and_collide(player_move)
	
	if abs(player_move.x) > 0 or abs(player_move.y) > 0:
		$AnimatedSprite2D.play("Walk")
	else:
		$AnimatedSprite2D.play("Idle")
	
	position.x = clamp(position.x, 0, 1920)
	position.y = clamp(position.y, 0, 1080)
	
	if Input.is_action_pressed("shoot"):
		if shoot > 0.2:
			shoot = 0
			$"../ShootSound".play()
			var bullet = bullet_scene.instantiate()
			bullet.position = position
			main.add_child(bullet)
	shoot += delta
	
	if health < 1:
		get_tree().reload_current_scene()

func _on_area_2d_body_entered(body):
	health -= 1
	$"../ProgressBar".value = health
	$"../HitSound".play()

func _on_powerupdetect_body_entered(body):
	powerup = 30
    RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       Script    res://Scenes/powerup.gd ��������
   Texture2D    res://pixil-frame-0(4).png �M�� �]6      local://CircleShape2D_qrief �         local://PackedScene_hthnm �         CircleShape2D            �B         PackedScene          	         names "         Powerup    collision_layer    collision_mask    script    Area2D 	   Sprite2D    texture_filter    scale    texture    CollisionShape2D    shape    _on_body_entered    body_entered    	   variants                                    
     �@  �@                         node_count             nodes     #   ��������       ����                                        ����                                 	   	   ����   
                conn_count             conns                                       node_paths              editable_instances              version             RSRC extends StaticBody2D

var disappear = 0

func _ready():
	position.x = randi_range(0, 1920)
	position.y = randi_range(0, 1080)

func _process(delta):
	if disappear > 0:
		disappear += 1
	if disappear > 2:
		queue_free()

func _on_body_entered(body):
	disappear = 1
        extends CharacterBody2D

@onready var mouse_pos = get_global_mouse_position()
const BULLET_SPEED = 1500
@onready var bullet_velocity = (mouse_pos - position).normalized() * BULLET_SPEED
var death = 0
var angle : int

func _ready():
	look_at(get_global_mouse_position())
	rotation += angle
	bullet_velocity = bullet_velocity.rotated(deg_to_rad(angle))

func _process(delta):
	move_and_collide(bullet_velocity * delta)
	if death > 0:
		if death > 1:
			queue_free()
		else:
			death += 1

func _on_area_2d_body_entered(body):
	death = 1
         RSRC                    AudioStreamWAV            ��������                                            
      resource_local_to_scene    resource_name    data    format 
   loop_mode    loop_begin 	   loop_end 	   mix_rate    stereo    script           local://AudioStreamWAV_2un51 /         AudioStreamWAV          �  �����������������������������������:::::::::'''''''''#?EEEEEEEEE�����������-;;;;;;;;;0�����������4??????????"������������666666666666 �������������������������
555555555555544�����������������$:::::::::::::::::::::���������������������������������������������������������������������������������������������������������������������������'3333333333333333333333333333333333333222222222(��������������������������������������������������������(((((((((((((((((((((����������������������***********************$                         ������������������������������������������������������������������������������������������������� *33333333333333333333333333333333333333333333222222�������������������������������������������������������������������������������������������������������������������������������������������������������������������#,,,,,,,,,,,,,,,,,++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++**********************************************************************************)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((('''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''&&&&&&&&&&&&&&&&&&&&&&&&&&����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������))))))))))))))))))))))))))))))))))))))))((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((('''''''''�����������������������������������������������������������������������������������������������������������������������������																																																																																																																																	����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������	������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������� ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������              �������������������������������������������������������������������������������������������   	      RSRC              [remap]

importer="wav"
type="AudioStreamWAV"
uid="uid://cshlvyp3nn0fd"
path="res://.godot/imported/hitHurt(1).wav-6e5667bb59306c6f633cb842eb5aa9ff.sample"
    GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�m�m۬�}�p,��5xi�d�M���)3��$�V������3���$G�$2#�Z��v{Z�lێ=W�~� �����d�vF���h���ڋ��F����1��ڶ�i�엵���bVff3/���Vff���Ҿ%���qd���m�J�}����t�"<�,���`B �m���]ILb�����Cp�F�D�=���c*��XA6���$
2#�E.@$���A.T�p )��#L��;Ev9	Б )��D)�f(qA�r�3A�,#ѐA6��npy:<ƨ�Ӱ����dK���|��m�v�N�>��n�e�(�	>����ٍ!x��y�:��9��4�C���#�Ka���9�i]9m��h�{Bb�k@�t��:s����¼@>&�r� ��w�GA����ը>�l�;��:�
�wT���]�i]zݥ~@o��>l�|�2�Ż}�:�S�;5�-�¸ߥW�vi�OA�x��Wwk�f��{�+�h�i�
4�˰^91��z�8�(��yޔ7֛�;0����^en2�2i�s�)3�E�f��Lt�YZ���f-�[u2}��^q����P��r��v��
�Dd��ݷ@��&���F2�%�XZ!�5�.s�:�!�Њ�Ǝ��(��e!m��E$IQ�=VX'�E1oܪì�v��47�Fы�K챂D�Z�#[1-�7�Js��!�W.3׹p���R�R�Ctb������y��lT ��Z�4�729f�Ј)w��T0Ĕ�ix�\�b�9�<%�#Ɩs�Z�O�mjX �qZ0W����E�Y�ڨD!�$G�v����BJ�f|pq8��5�g�o��9�l�?���Q˝+U�	>�7�K��z�t����n�H�+��FbQ9���3g-UCv���-�n�*���E��A�҂
�Dʶ� ��WA�d�j��+�5�Ȓ���"���n�U��^�����$G��WX+\^�"�h.���M�3�e.
����MX�K,�Jfѕ*N�^�o2��:ՙ�#o�e.
��p�"<W22ENd�4B�V4x0=حZ�y����\^�J��dg��_4�oW�d�ĭ:Q��7c�ڡ��
A>��E�q�e-��2�=Ϲkh���*���jh�?4�QK��y@'�����zu;<-��|�����Y٠m|�+ۡII+^���L5j+�QK]����I �y��[�����(}�*>+���$��A3�EPg�K{��_;�v�K@���U��� gO��g��F� ���gW� �#J$��U~��-��u���������N�@���2@1��Vs���Ŷ`����Dd$R�":$ x��@�t���+D�}� \F�|��h��>�B�����B#�*6��  ��:���< ���=�P!���G@0��a��N�D�'hX�׀ "5#�l"j߸��n������w@ K�@A3�c s`\���J2�@#�_ 8�����I1�&��EN � 3T�����MEp9N�@�B���?ϓb�C��� � ��+�����N-s�M�  ��k���yA 7 �%@��&��c��� �4�{� � �����"(�ԗ�� �t�!"��TJN�2�O~� fB�R3?�������`��@�f!zD��%|��Z��ʈX��Ǐ�^�b��#5� }ى`�u�S6�F�"'U�JB/!5�>ԫ�������/��;	��O�!z����@�/�'�F�D"#��h�a �׆\-������ Xf  @ �q�`��鎊��M��T�� ���0���}�x^�����.�s�l�>�.�O��J�d/F�ě|+^�3�BS����>2S����L�2ޣm�=�Έ���[��6>���TъÞ.<m�3^iжC���D5�抺�����wO"F�Qv�ږ�Po͕ʾ��"��B��כS�p�
��E1e�������*c�������v���%'ž��&=�Y�ް>1�/E������}�_��#��|������ФT7׉����u������>����0����緗?47�j�b^�7�ě�5�7�����|t�H�Ե�1#�~��>�̮�|/y�,ol�|o.��QJ rmϘO���:��n�ϯ�1�Z��ը�u9�A������Yg��a�\���x���l���(����L��a��q��%`�O6~1�9���d�O{�Vd��	��r\�՜Yd$�,�P'�~�|Z!�v{�N�`���T����3?DwD��X3l �����*����7l�h����	;�ߚ�;h���i�0�6	>��-�/�&}% %��8���=+��N�1�Ye��宠p�kb_����$P�i�5�]��:��Wb�����������ě|��[3l����`��# -���KQ�W�O��eǛ�"�7�Ƭ�љ�WZ�:|���є9�Y5�m7�����o������F^ߋ������������������Р��Ze�>�������������?H^����&=����~�?ڭ�>���Np�3��~���J�5jk�5!ˀ�"�aM��Z%�-,�QU⃳����m����:�#��������<�o�����ۇ���ˇ/�u�S9��������ٲG}��?~<�]��?>��u��9��_7=}�����~����jN���2�%>�K�C�T���"������Ģ~$�Cc�J�I�s�? wڻU���ə��KJ7����+U%��$x�6
�$0�T����E45������G���U7�3��Z��󴘶�L�������^	dW{q����d�lQ-��u.�:{�������Q��_'�X*�e�:�7��.1�#���(� �k����E�Q��=�	�:e[����u��	�*�PF%*"+B��QKc˪�:Y��ـĘ��ʴ�b�1�������\w����n���l镲��l��i#����!WĶ��L}rեm|�{�\�<mۇ�B�HQ���m�����x�a�j9.�cRD�@��fi9O�.e�@�+�4�<�������v4�[���#bD�j��W����֢4�[>.�c�1-�R�����N�v��[�O�>��v�e�66$����P
�HQ��9���r�	5FO� �<���1f����kH���e�;����ˆB�1C���j@��qdK|
����4ŧ�f�Q��+�     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bwao7yop6ujgr"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                RSRC                    AudioStreamWAV            ��������                                            
      resource_local_to_scene    resource_name    data    format 
   loop_mode    loop_begin 	   loop_end 	   mix_rate    stereo    script           local://AudioStreamWAV_o467b /         AudioStreamWAV          m
  ##"""!�����������������������!))((''�����������������������.--,,+"�����������������������1100/..�����������������������3322100�����������������������5443221�����������������������6544332 �����������������������%6654432������������������������%7655443�����������������������7765544%������������������������7765544������������������������8766544!������������������������8776554/������������������������8766544!�������������������������8766554&�������������������������*7765544�������������������������3776554/�������������������������/7765543�������������������������!7766544!
�������������������������&7765544�������������������������7765544%��������������������������*7665543
��������������������������&7765543��������������������������7766544.��������������������������7765543*��������������������������.7665443���������������������������77655433���������������������������37655443 ��������������������������7665443.���������������������������76654433 ���������������������������%7655443)����������������������������!7655443.���������������������������.6655433 ����������������������������*7655433)	����������������������������65544322 ����������������������������,4332110'�����������������������������322100//�����������������������������%100/..--������������������������������(/..--,+'������������������������������.-,,++**
������������������������������,++**))( 


������������������������������*))((''&

	������������������������������%(''&&%%$				������������������������������� &&%%$$##		�������������������������������%$$##""!!�������������������������������"""!!  ��������������������������������!  
��������������������������������
�������������������������������� 



���������������������������������					���������������������������������		��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������� ������������������������������������



						������������������������������������� ���������������������������������������������������������������������������       ���������������������������������������                   �����������������    	      RSRC  [remap]

importer="wav"
type="AudioStreamWAV"
uid="uid://b7srcyvcytuv2"
path="res://.godot/imported/laserShoot(1).wav-8380dfe10a9fb346f78362164eb53ebf.sample"
 GST2            ����                        �   RIFF�   WEBPVP8L�   /�_`�m���i�ߓ��k�i��gy�*�q�A��zX�x���"�G���W�;�P{p6�jk�ǕK*�d	� ����&�@�A#h��BD���TBp�KHE\�鋽)�`.��+g�W�fԕ���֓��     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c02710sbtmt7n"
path="res://.godot/imported/pixil-frame-0(2).png-5822c6eb8494c6407bfe1c5b62c42373.ctex"
metadata={
"vram_texture": false
}
    GST2   �       ����               �       �  RIFF�  WEBPVP8L�  /�AC ��m�U�W�lJFLCƪ�Lb2V�g
���z�c	HRdEDhI���mCX�*^��h����|-��=������
A �"�� G�޸��լ��|�GI�ǧ�r�i�W���6�� E�$)Kֿc��GD�'���eD	Cp<��  t+�Ő����	���6Y�r��y�z�T#Y�����S������+Қ�c2�М��U*�"3��$�.��84ܰH�[Z5����o��8ׯǤ���[7�zp�h��e��(+�H
�L�B�N<���(+��-�zMḺ3�d�$BQ�<�+��
�b�
���	���[�b�TXͥ?�^�� T��e�:r9���y����)���1
x[☽��i�p3e����UoZw̔�-��THef'����K�yE���]�J40��XC�ٍ�D#nA��-nF5,R�����'�z�	"-�
iqK�F@YI�=;)1P3Z>���l��2>؜v���Ve݅^�̗��N�.�);�~��JL��5�g�Q�)�Ӌ���t���紾����9�$�9Tk�ּ����K�64��3��X����ꈎ�|�Ũ�vX���$TX�Ja�0�AϬ7��E��l��l��xJڌ���a3������'��'��bTK{���������IF�z�2��0�0B�qL-ICHI�JC�l¨Ų�PwXCa�s�t�%�!����#�nM�n�'n�12��*΄�N���=���UU����W����xϯo>�CI���"D��A�:y��Ms�����)�F��`6I�p#T���Ca�"�`8���Y��L�1�6����`)*�EM`�s�ş��<#�V^�5�+�U<Y&Qnr�G9?�͊�,ӍS.�оJ6�7�Lء-�-:S�A�Lx#���`P���d�[�݊�ؒ�M�iY��`�JP��3             [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cr2hcjs2jlss5"
path="res://.godot/imported/pixil-frame-0(3).png-68bd815c95e3878ae3083d23dd2c52ef.ctex"
metadata={
"vram_texture": false
}
    GST2              ����                          �   RIFF�   WEBPVP8L�   /�/@�m3�a�F�!����]>�l����?Z �݁���u#Iu� ��������`��?8�"�?� Z�%��*'�7�!��Q0'K���c�a��!�d�7<$�$��\�$�����̵���9�vxw�ю߹N���\[�+���:@bO�<��	?I$�I��D�,a\w�E�	��F9d;Y�$}�h�          [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bv2wbv77xx4sq"
path="res://.godot/imported/pixil-frame-0(4).png-4aa065ee58ec3b42fb204cf8f0376d7a.ctex"
metadata={
"vram_texture": false
}
    GST2   `          ����               `            RIFF  WEBPVP8L�  /_������_� ��AMh"I�j��.BGD@&�"I�����j�����C@P��h�H��PPU����wݘy���p�J嘈����߭g��එ#I�l����eͰ��j�3��jR���:87���kБ�6��r�D4���k�f���	/28ߋ�u]s�U���|�v�������{齵��e^��>8�孛{���W:8�]pN��O;s��%��߳/X��D/�����ǟ�gz�0F��c]zX�uM�饮1�?)��t/���M�M5���^(����������bl�+���:��Gz�~~�|h*��'zI1܇R������
6�p/�^���t����8�|� �A���GDȜ�Nc�D$�^�q4�i��umd�!-�]A��z���ګ]m���x��M�^�Z����`���zQ�Z���İ��Aŧ�(x�5h��� ڻ �P̓��=��qb^���
           [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bbffiejglmjnw"
path="res://.godot/imported/witch.png-575be3cff0e2173a9820c570825795de.ctex"
metadata={
"vram_texture": false
}
               GST2   `          ����               `          \  RIFFT  WEBPVP8LG  /_���(��Hi�'Nx� �>-\�VE�)��r0�N�h��F��$)j]� ����
E����(Ԁ�w��6���?��e]���0 ƶZ7r��G�F��b�� ���6r$�6\>V�K������,q^s-���#�YD�+�O��?�|ɻ2�C���b!	�]�űʱ���ʻr�c��>��'�Ϥ��G�\�,dD�����_<Q!R�A/��OkM͈F�]��h�羉�Lcy׻�wl�v��.�j��ገ���#:�Γs�⋃����X���/��T���ew�{GWI��'�*wf�+�|BT������0���O��L�}�����?}�\4d��so�����d��<+Y��&�Rz��.�\X�R�½�Z�n<m�m��k�>3pA��eDh�mM�R�g�un�������,Ӻmֱ'q���6W!]э$*���!"��kam�n����͟n��P�'ߕ�+��|?^WQ�ȳF�g0f�؏å�rx��<as�����PvxDw�y^�¡�ZFlXu��A`]8����q,�t"�����C�p�>�=�A�D��              [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c5wo15rxr7l0t"
path="res://.godot/imported/zombie.png-c3b3bc9d5f5ee77c87d3298dd185606a.ctex"
metadata={
"vram_texture": false
}
              [remap]

path="res://.godot/exported/133200997/export-ebb3521b4f0ab2fc80eef1183e18e924-bullet.scn"
             [remap]

path="res://.godot/exported/133200997/export-7111e2a4ba75c4a329f0f9553f2950f2-enemy.scn"
              [remap]

path="res://.godot/exported/133200997/export-2ddd04d543d5858e7f20c9299a8b5096-main.scn"
               [remap]

path="res://.godot/exported/133200997/export-478521028d04bf07f9c7de24d64609e3-powerup.scn"
            list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z" fill="#478cbf"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
              h6�030Ix   res://Scenes/bullet.tscn�Ƙ�Ӌb   res://Scenes/enemy.tscn�U��HC   res://Scenes/main.tscn��tAM��S   res://hitHurt(1).wavqy���o�6   res://icon.svgM]�k��@   res://laserShoot(1).wav�*-
��c[   res://pixil-frame-0(2).png��a3F8�S   res://pixil-frame-0(3).png��0�[n="   res://witch.pngA=H�`   res://zombie.png�M�� �]6!   res://Scenes/pixil-frame-0(4).png�M�� �]6   res://pixil-frame-0(4).png�j���:�   res://Scenes/powerup.tscn           ECFG      application/config/name         Tricks Versus Treats   application/run/main_scene          res://Scenes/main.tscn     application/config/features(   "         4.2    GL Compatibility       application/config/icon         res://icon.svg  "   display/window/size/viewport_width      �  #   display/window/size/viewport_height      8     display/window/size/mode            display/window/stretch/mode         viewport   input/ui_left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode     @    physical_keycode       	   key_label             unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device            axis       
   axis_value       ��   script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script         input/ui_right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode     @    physical_keycode       	   key_label             unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device            axis       
   axis_value       �?   script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script         input/ui_up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode     @    physical_keycode       	   key_label             unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device            axis      
   axis_value       ��   script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script         input/ui_down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode     @    physical_keycode       	   key_label             unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device            axis      
   axis_value       �?   script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/shoott              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position     �B  �A   global_position      �B  hB   factor       �?   button_index         canceled          pressed          double_click          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label             unicode           echo          script      #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility  