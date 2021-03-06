/// app_startup_interface_tabs()

tab_move = null
tab_move_name = ""
tab_move_x = 0
tab_move_width = 0
tab_move_direction = e_scroll.VERTICAL
tab_move_box_x = 0
tab_move_box_y = 0
tab_move_box_width = 0
tab_move_box_height = 0
tab_move_mouseon_panel = null
tab_move_mouseon_position = 0

// Project properties
properties = new_tab(panel_right_top, true)
with (properties)
{
	// Project
	project = tab_add_category("project", tab_properties_project, false)
	with (project)
	{
		tbx_name = new_textbox(true, 0, "")
		tbx_author = new_textbox(true, 0, "")
		tbx_description = new_textbox(false, 0, "")
		tbx_video_size_custom_width = new_textbox_integer()
		tbx_video_size_custom_height = new_textbox_integer()
		tbx_tempo = new_textbox_integer()
		tbx_name.next_tbx = tbx_author
		tbx_author.next_tbx = tbx_description
		tbx_description.next_tbx = tbx_name
	}
	
	// Library
	library = tab_add_category("library", tab_properties_library, false)
	with (library)
	{
		preview = new(obj_preview)
		preview.spawn_active = false
		list = new(obj_sortlist)
		list.can_deselect = true
		list.script = action_lib_list
		sortlist_column_add(list, "libname", 0)
		sortlist_column_add(list, "libtype", 0.45)
		sortlist_column_add(list, "libcount", 0.75)
		tbx_name = new_textbox(1, 0, "")
		tbx_repeat_x = new_textbox_integer()
		tbx_repeat_y = new_textbox_integer()
		tbx_repeat_z = new_textbox_integer()
		tbx_shape_detail = new_textbox_integer()
		tbx_shape_tex_hoffset = new_textbox_ndecimals()
		tbx_shape_tex_voffset = new_textbox_ndecimals()
		tbx_shape_tex_hrepeat = new_textbox_decimals()
		tbx_shape_tex_vrepeat = new_textbox_decimals()
	}
	
	// Background
	background = tab_add_category("background", tab_properties_background, false)
	with (background)
	{
		tbx_sky_clouds_fade_distance = new_textbox_integer()
		tbx_sky_clouds_z = new_textbox_ndecimals()
		tbx_sky_clouds_size = new_textbox_decimals()
		tbx_sky_clouds_height = new_textbox_decimals()
		tbx_sky_clouds_speed = new_textbox_ndecimals()
		tbx_fog_distance = new_textbox_integer()
		tbx_fog_size = new_textbox_integer()
		tbx_fog_height = new_textbox_integer()
		tbx_wind_speed = new_textbox_decimals()
		tbx_wind_speed.suffix = "%"
		tbx_wind_strength = new_textbox_decimals()
		tbx_sunlight_range = new_textbox_integer()
		tbx_texture_animation_speed = new_textbox_ndecimals()
	}
	
	// Resources
	resources = tab_add_category("resources", tab_properties_resources, false)
	with (resources)
	{
		preview = new(obj_preview)
		list = new(obj_sortlist)
		list.can_deselect = true
		list.script = action_res_list
		sortlist_column_add(list, "resname", 0)
		sortlist_column_add(list, "restype", 0.45)
		sortlist_column_add(list, "rescount", 0.75)
		sortlist_add(list, res_def)
	}
}

lib_preview = properties.library.preview
lib_list = properties.library.list
res_preview = properties.resources.preview
res_list = properties.resources.list

// Ground editor
ground_editor = new_tab(panel_right_bottom, false)
ground_editor.script = tab_ground_editor
with (ground_editor)
	ground_scroll = new(obj_scrollbar)

// Template editor
template_editor = new_tab(panel_right_bottom, false)
template_editor.script = tab_template_editor

with (template_editor)
{
	// Character vbuffer
	char_list = new(obj_sortlist)
	char_list.script = action_lib_char_model
	sortlist_column_add(char_list, "charname", 0)
	for (var c = 0; c < ds_list_size(mc_version.char_list); c++)
		sortlist_add(char_list, mc_version.char_model_map[?mc_version.char_list[|c]])
		
	// Item
	item_scroll = new(obj_scrollbar)
	
	// Block
	block_list = new(obj_sortlist)
	block_list.script = action_lib_block_id
	sortlist_column_add(block_list, "blockid", 0)
	sortlist_column_add(block_list, "blockname", 0.25)
	for (var b = 0; b < 256; b++)
		if (!is_undefined(mc_version.block_map[?b]))
			sortlist_add(block_list, b)
	tbx_block_data = new_textbox_integer()
	
	// Special block vbuffer
	spblock_list = new(obj_sortlist)
	spblock_list.script = action_lib_char_model
	sortlist_column_add(spblock_list, "spblockname", 0)
	//for (var p = characters; p < characters + characters_blocks; p++)
	//	sortlist_add(spblock_list, iget(obj_model, p))
	
	// Bodypart vbuffer
	bodypart_char_list = new(obj_sortlist)
	bodypart_char_list.script = action_lib_char_bodypart_model
	sortlist_column_add(bodypart_char_list, "bodypartcharname", 0)
	//for (var m = 0; m < characters + characters_blocks; m++)
	//   sortlist_add(bodypart_char_list, iget(obj_model, m))
		
	// Particle editor
	tbx_spawn_amount = new_textbox_integer()

	tbx_spawn_region_sphere_radius = new_textbox_decimals()
	tbx_spawn_region_cube_size = new_textbox_decimals()
	tbx_spawn_region_box_xsize = new_textbox_decimals()
	tbx_spawn_region_box_ysize = new_textbox_decimals()
	tbx_spawn_region_box_zsize = new_textbox_decimals()
	
	tbx_bounding_box_ground_z = new_textbox_ndecimals()
	tbx_bounding_box_custom_xstart = new_textbox_ndecimals()
	tbx_bounding_box_custom_ystart = new_textbox_ndecimals()
	tbx_bounding_box_custom_zstart = new_textbox_ndecimals()
	tbx_bounding_box_custom_xend = new_textbox_ndecimals()
	tbx_bounding_box_custom_yend = new_textbox_ndecimals()
	tbx_bounding_box_custom_zend = new_textbox_ndecimals()
	
	tbx_destroy_at_amount_val = new_textbox_integer()
	tbx_destroy_at_time_seconds = new_textbox_ndecimals()
	tbx_destroy_at_time_random = new_textbox_ndecimals()
	
	type_list = new(obj_sortlist)
	type_list.script = action_lib_pc_type_list
	type_list.can_deselect = true
	sortlist_column_add(type_list, "particleeditortypename", 0)
	sortlist_column_add(type_list, "particleeditortypekind", 0.4)
	sortlist_column_add(type_list, "particleeditortyperate", 0.75)
	preview_start = current_time
	preview_speed = 1
	
	tbx_type_name = new_textbox(true, 0, "")
	tbx_type_spawn_rate = new_textbox_integer()
	tbx_type_spawn_rate.suffix = "%"
	tbx_type_text = new_textbox(false, 0, "")
	tbx_type_sprite_frame_width = new_textbox_integer()
	tbx_type_sprite_frame_height = new_textbox_integer()
	tbx_type_sprite_frame_start = new_textbox_integer()
	tbx_type_sprite_frame_end = new_textbox_integer()
	
	tbx_type_sprite_animation_speed = new_textbox_decimals()
	tbx_type_sprite_animation_speed_random = new_textbox_decimals()
	
	tbx_type_xspd = new_textbox_ndecimals()
	tbx_type_xspd_random = new_textbox_ndecimals()
	tbx_type_yspd = new_textbox_ndecimals()
	tbx_type_yspd_random = new_textbox_ndecimals()
	tbx_type_zspd = new_textbox_ndecimals()
	tbx_type_zspd_random = new_textbox_ndecimals()
	tbx_type_xspd_add = new_textbox_ndecimals()
	tbx_type_xspd_add_random = new_textbox_ndecimals()
	tbx_type_yspd_add = new_textbox_ndecimals()
	tbx_type_yspd_add_random = new_textbox_ndecimals()
	tbx_type_zspd_add = new_textbox_ndecimals()
	tbx_type_zspd_add_random = new_textbox_ndecimals()
	tbx_type_xspd_mul = new_textbox_ndecimals()
	tbx_type_xspd_mul_random = new_textbox_ndecimals()
	tbx_type_yspd_mul = new_textbox_ndecimals()
	tbx_type_yspd_mul_random = new_textbox_ndecimals()
	tbx_type_zspd_mul = new_textbox_ndecimals()
	tbx_type_zspd_mul_random = new_textbox_ndecimals()
	
	tbx_type_xrot = new_textbox_ndecimals()
	tbx_type_xrot.suffix = "°"
	tbx_type_xrot_random = new_textbox_ndecimals()
	tbx_type_xrot_random.suffix = "°"
	tbx_type_yrot = new_textbox_ndecimals()
	tbx_type_yrot.suffix = "°"
	tbx_type_yrot_random = new_textbox_ndecimals()
	tbx_type_yrot_random.suffix = "°"
	tbx_type_zrot = new_textbox_ndecimals()
	tbx_type_zrot.suffix = "°"
	tbx_type_zrot_random = new_textbox_ndecimals()
	tbx_type_zrot_random.suffix = "°"
	
	tbx_type_xrot_spd = new_textbox_ndecimals()
	tbx_type_xrot_spd_random = new_textbox_ndecimals()
	tbx_type_yrot_spd = new_textbox_ndecimals()
	tbx_type_yrot_spd_random = new_textbox_ndecimals()
	tbx_type_zrot_spd = new_textbox_ndecimals()
	tbx_type_zrot_spd_random = new_textbox_ndecimals()
	tbx_type_xrot_spd_add = new_textbox_ndecimals()
	tbx_type_xrot_spd_add_random = new_textbox_ndecimals()
	tbx_type_yrot_spd_add = new_textbox_ndecimals()
	tbx_type_yrot_spd_add_random = new_textbox_ndecimals()
	tbx_type_zrot_spd_add = new_textbox_ndecimals()
	tbx_type_zrot_spd_add_random = new_textbox_ndecimals()
	tbx_type_xrot_spd_mul = new_textbox_ndecimals()
	tbx_type_xrot_spd_mul_random = new_textbox_ndecimals()
	tbx_type_yrot_spd_mul = new_textbox_ndecimals()
	tbx_type_yrot_spd_mul_random = new_textbox_ndecimals()
	tbx_type_zrot_spd_mul = new_textbox_ndecimals()
	tbx_type_zrot_spd_mul_random = new_textbox_ndecimals()
	
	tbx_type_scale = new_textbox_ndecimals()
	tbx_type_scale_random = new_textbox_ndecimals()
	tbx_type_scale_add = new_textbox_ndecimals()
	tbx_type_scale_add_random = new_textbox_ndecimals()
	
	tbx_type_alpha = new_textbox_integer()
	tbx_type_alpha.suffix = "%"
	tbx_type_alpha_random = new_textbox_integer()
	tbx_type_alpha_random.suffix = "%"
	tbx_type_alpha_add = new_textbox_integer()
	tbx_type_alpha_add.suffix = "%"
	tbx_type_alpha_add_random = new_textbox_integer()
	tbx_type_alpha_add_random.suffix = "%"
	
	tbx_type_color_mix_time = new_textbox_decimals()
	tbx_type_color_mix_time_random = new_textbox_decimals()
	
	tbx_type_bounce_factor = new_textbox_decimals()
}

ptype_list = template_editor.type_list

// Timeline
timeline = new_tab(panel_bottom, true)
timeline.script = tab_timeline
with (timeline)
{
	list_width = 320
	hor_scroll = new(obj_scrollbar)
	ver_scroll = new(obj_scrollbar)
}

// Timeline editor
timeline_editor = new_tab(panel_right_top, false)
with (timeline_editor)
{
	// Information
	info = tab_add_category("timelineeditorinfo", tab_timeline_editor_info, true)
	with (info)
	{
		rot_point_mouseon = false
		rot_point_snap = false
		rot_point_snap_size = 1
		rot_point_copy = point3D(0, 0, 0)
		tbx_name = new_textbox(true, 0, "")
		tbx_text = new_textbox(false, 0, "")
		tbx_rot_point_x = new_textbox_ndecimals()
		tbx_rot_point_y = new_textbox_ndecimals()
		tbx_rot_point_z = new_textbox_ndecimals()
		tbx_rot_point_snap = new_textbox_decimals()
		tbx_rot_point_snap.text = string(rot_point_snap_size)
	}
	
	// Hierarchy
	hierarchy = tab_add_category("timelineeditorhierarchy", tab_timeline_editor_hierarchy, true)
	
	// Graphics
	graphics = tab_add_category("timelineeditorgraphics", tab_timeline_editor_graphics, false)
	with (graphics)
		tbx_depth = new_textbox_ninteger()
		
	// Audio
	audio = tab_add_category("timelineeditoraudio", tab_timeline_editor_audio, true)
}

// Frame editor
frame_editor = new_tab(panel_right_bottom, false)
with (frame_editor)
{
	// Position
	position = tab_add_category("frameeditorposition", tab_frame_editor_position, false)
	with (position)
	{
		snap_enabled = false
		snap_size = 16
		copy = point3D(0, 0, 0)
		tbx_x = new_textbox_ndecimals()
		tbx_y = new_textbox_ndecimals()
		tbx_z = new_textbox_ndecimals()
		tbx_snap = new_textbox_decimals()
		tbx_snap.text = string(snap_size)
	}
	
	// Rotation
	rotation = tab_add_category("frameeditorrotation", tab_frame_editor_rotation, false)
	with (rotation)
	{
		loops = false
		snap_enabled = false
		snap_size = 15
		copy = point3D(0, 0, 0)
		tbx_x = new_textbox_ndecimals()
		tbx_x.suffix = "°"
		tbx_y = new_textbox_ndecimals()
		tbx_y.suffix = "°"
		tbx_z = new_textbox_ndecimals()
		tbx_z.suffix = "°"
		tbx_loops_x = new_textbox_ndecimals()
		tbx_loops_y = new_textbox_ndecimals()
		tbx_loops_z = new_textbox_ndecimals()
		tbx_snap = new_textbox_decimals()
		tbx_snap.text = string(snap_size)
	}
	
	// Scale
	scale = tab_add_category("frameeditorscale", tab_frame_editor_scale, false)
	with (scale)
	{
		scale_all = true
		snap_enabled = false
		snap_size = 0.25
		copy = point3D(1, 1, 1)
		tbx_x = new_textbox_decimals()
		tbx_y = new_textbox_decimals()
		tbx_z = new_textbox_decimals()
		tbx_snap = new_textbox_decimals()
		tbx_snap.text = string(snap_size)
	}
	
	// Bend
	bend = tab_add_category("frameeditorbend", tab_frame_editor_bend, false)
	with (bend)
	{
		snap_enabled = false
		snap_size = 15
		copy = 0
		tbx_wheel = new_textbox_ndecimals()
		tbx_wheel.suffix = "°"
		tbx_snap = new_textbox_decimals()
		tbx_snap.text = string(snap_size)
	}
	
	// Color
	color = tab_add_category("frameeditorcolor", tab_frame_editor_color, false)
	with (color)
	{
		advanced = false
		copy_alpha = 1
		copy_rgbadd = c_black
		copy_rgbsub = c_black
		copy_rgbmul = c_white
		copy_hsbadd = c_black
		copy_hsbsub = c_black
		copy_hsbmul = c_white
		copy_mixcolor = c_black
		copy_mixpercent = 0
		copy_brightness = 0
		tbx_alpha = new_textbox_integer()
		tbx_alpha.suffix = "%"
		tbx_mixpercent = new_textbox_integer()
		tbx_mixpercent.suffix = "%"
		tbx_brightness = new_textbox_integer()
		tbx_brightness.suffix = "%"
	}
	
	// Particles
	particles = tab_add_category("frameeditorparticles", tab_frame_editor_particles, false)
	with (particles)
		tbx_force = new_textbox_ndecimals()
	
	// Light
	light = tab_add_category("frameeditorlight", tab_frame_editor_light, false)
	with (light)
	{
		copy_color = c_white
		copy_range = 250
		copy_fadesize = 0.5
		copy_spotradius = 50
		copy_spotsharpness = 0.5
		has_spotlight = false
		tbx_range = new_textbox_decimals()
		tbx_fade_size = new_textbox_integer()
		tbx_fade_size.suffix = "%"
		tbx_spot_radius = new_textbox_decimals()
		tbx_spot_sharpness = new_textbox_integer()
		tbx_spot_sharpness.suffix = "%"
	}
	
	// Camera
	camera = tab_add_category("frameeditorcamera", tab_frame_editor_camera, false)
	with (camera)
	{
		video_template = null
		copy_fov = 45
		copy_rotate = false
		copy_rotate_distance = 100
		copy_rotate_xy_angle = 0
		copy_rotate_z_angle = 0
		copy_dof = false
		copy_dof_depth = 0
		copy_dof_range = 200
		copy_dof_fade_size = 100
		copy_width = 0
		copy_height = 0
		look_at_rotate = true
		tbx_fov = new_textbox_integer()
		tbx_fov.suffix = "°"
		tbx_ratio = new_textbox_decimals()
		tbx_rotate_distance = new_textbox_decimals()
		tbx_rotate_angle_xy = new_textbox_ndecimals()
		tbx_rotate_angle_xy.suffix = "°"
		tbx_rotate_angle_z = new_textbox_ndecimals()
		tbx_rotate_angle_z.suffix = "°"
		tbx_dof_depth = new_textbox_decimals()
		tbx_dof_range = new_textbox_decimals()
		tbx_dof_fade_size = new_textbox_decimals()
		tbx_video_size_custom_width = new_textbox_integer()
		tbx_video_size_custom_height = new_textbox_integer()
	}
	
	// Texture
	texture = tab_add_category("frameeditortexture", tab_frame_editor_texture, false)
	
	// Sound
	sound = tab_add_category("frameeditorsound", tab_frame_editor_sound, true)
	with (sound)
	{
		tbx_volume = new_textbox_integer()
		tbx_volume.suffix = "%"
		tbx_start = new_textbox_decimals()
		tbx_end = new_textbox_ndecimals()
	}
	
	// Keyframe
	keyframe = tab_add_category("frameeditorkeyframe", tab_frame_editor_keyframe, false)
}

// Settings
settings = new_tab(panel_right_bottom, false)
with (settings)
{
	// Program
	program = tab_add_category("settingsprogram", tab_settings_program, false)
	with (program)
	{
		tbx_backup_time = new_textbox_integer()
		tbx_backup_amount = new_textbox_integer()
	}
	
	// Interface
	interface = tab_add_category("settingsinterface", tab_settings_interface, false)
	with (interface)
	{
		tbx_tip_delay = new_textbox_decimals()
		tbx_view_grid_size_hor = new_textbox_integer()
		tbx_view_grid_size_ver = new_textbox_integer()
		tbx_view_real_time_render_time = new_textbox_integer()
	}
	
	// Controls
	controls = tab_add_category("settingscontrols", tab_settings_controls, false)
	with (controls)
	{
		tbx_move_speed = new_textbox_decimals()
		tbx_look_sensitivity = new_textbox_decimals()
		tbx_fast_modifier = new_textbox_decimals()
		tbx_slow_modifier = new_textbox_decimals()
	}
	
	// Graphics
	graphics = tab_add_category("settingsgraphics", tab_settings_graphics, false)
	with (graphics)
	{
		tbx_bend_detail = new_textbox_integer()
		tbx_bend_scale = new_textbox_decimals()
		tbx_texture_filtering_level = new_textbox_integer()
		tbx_block_brightness = new_textbox_decimals()
		tbx_block_brightness.suffix = "%"
	}
	
	// Render
	render = tab_add_category("settingsrender", tab_settings_render, false)
	with (render)
	{
		tbx_ssao_range = new_textbox_decimals()
		tbx_ssao_radius = new_textbox_decimals()
		tbx_ssao_power = new_textbox_integer()
		tbx_ssao_power.suffix = "%"
		tbx_ssao_blur_passes = new_textbox_integer()
		tbx_shadows_blur_quality = new_textbox_integer()
		tbx_shadows_blur_size = new_textbox_integer()
		tbx_shadows_blur_size.suffix = "%"
		tbx_dof_blur_size = new_textbox_integer()
		tbx_dof_blur_size.suffix = "%"
		tbx_aa_power = new_textbox_integer()
		tbx_aa_power.suffix = "%"
	}
}
