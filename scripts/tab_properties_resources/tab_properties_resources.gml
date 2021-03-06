/// tab_properties_resources()

var listh, capwid;

// Preview selected resource
tab_control(160)
preview_draw(res_preview, dx + floor(dw / 2) - 80, dy, 160)
tab_next()

// List
listh = 256
if (content_direction = e_scroll.HORIZONTAL)
	listh = max(130, dh - (dy - dy_start) - 30)
if (tab_control(listh))
{
	listh = dh - (dy - dy_start - 18) - 30
	tab_control_h = listh
}
sortlist_draw(tab.resources.list, dx, dy, dw, listh, res_edit)
tab_next()

// Tools
tab_control(24)

if (draw_button_normal("resourcesnew", dx, dy, 24, 24, e_button.NO_TEXT, false, false, true, icons.import))
	action_toolbar_import_asset()
	
if (draw_button_normal("resourcesremove", dx + 25 * 1, dy, 24, 24, e_button.NO_TEXT, false, false, (res_edit && res_edit != res_def), icons.remove))
	action_res_remove()
	
if (draw_button_normal("resourcesreload", dx + 25 * 2, dy, 24, 24, e_button.NO_TEXT, false, false, (res_edit && res_edit != res_def), icons.reload))
	action_res_reload()
	
if (draw_button_normal("resourcesreplace", dx + 25 * 3, dy, 24, 24, e_button.NO_TEXT, false, false, (res_edit && res_edit != res_def), icons.browse))
	action_res_replace()
	
tab_next()

if (!res_edit)
	return 0

if (res_edit.type = "pack")
{
	capwid = text_caption_width("resourcespackimage", "resourcespackimagecharacter", "resourcespackimagecolormap", "resourcespackimageparticles")
	
	tab_control(24)
	draw_button_menu("resourcespackimage", e_menu.LIST, dx, dy, dw, 24, res_preview.pack_image, text_get("resourcespack" + res_preview.pack_image), action_res_preview_pack_image, null, 0, capwid)
	tab_next()
	
	switch (res_preview.pack_image)
	{
		case "mobtextures":
		{
			tab_control(24)
			draw_button_menu("resourcespackimagecharacter", e_menu.LIST, dx, dy, dw, 24, res_preview.pack_char, text_get(res_preview.pack_char.name), action_res_preview_pack_char, null, 0, capwid)
			tab_next()
			break
		}
		case "colormap":
		{
			tab_control_checkbox()
			draw_label(text_get("resourcespackimagecolormap") + ":", dx, dy)
			draw_radiobutton("resourcespackimagecolormapgrass", dx + capwid, dy, 0, res_preview.pack_colormap = 0, action_res_preview_pack_colormap)
			draw_radiobutton("resourcespackimagecolormapfoliage", dx + capwid + floor((dw - capwid) * 0.5), dy, 1, res_preview.pack_colormap = 1, action_res_preview_pack_colormap)
			tab_next()
			break
		}
		case "particlesheet":
		{
			tab_control_checkbox()
			draw_label(text_get("resourcespackimageparticles") + ":", dx, dy)
			draw_radiobutton("resourcespackimageparticlesimage1", dx + capwid, dy, 0, res_preview.pack_particles = 0, action_res_preview_pack_particles)
			draw_radiobutton("resourcespackimageparticlesimage2", dx + capwid + floor((dw - capwid) * 0.5), dy, 1, res_preview.pack_particles = 1, action_res_preview_pack_particles)
			tab_next()
			break
		}
	}
}
else if (res_edit.type = "itemsheet")
{
	// Sheet
	tab_control_checkbox()
	draw_checkbox("resourcesisitemsheet", dx, dy, res_edit.is_item_sheet, action_res_is_item_sheet)
	tab_next()
}

if (res_edit.filename != "") // Filename
{
	var wid = text_max_width("resourcesfilenameopen") + 20;
	capwid = text_caption_width("resourcesfilename")
	
	tab_control(24)
	tip_wrap = false
	tip_set(string_remove_newline(project_folder + "\\" + res_edit.filename), dx, dy, dw - wid, 24)
	
	draw_label(text_get("resourcesfilename") + ":", dx, dy + 12, fa_left, fa_middle)
	draw_label(string_limit(string_remove_newline(res_edit.filename), dw - capwid - wid), dx + capwid, dy + 12, fa_left, fa_middle)
	
	if (res_edit.type != "schematic")
		if (draw_button_normal("resourcesfilenameopen", dx + dw - wid, dy, wid, 24))
			open_url(project_folder + "\\" + res_edit.filename)
			
	tab_next()
}
