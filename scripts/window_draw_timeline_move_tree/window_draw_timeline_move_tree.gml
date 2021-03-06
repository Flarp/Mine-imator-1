/// window_draw_timeline_move_tree(parent)
/// @arg parent

var par, itemh, indent;
par = argument0
itemh = test(setting_timeline_compact, 18, 24)
indent = 16

for (var t = 0; t < par.tree_amount; t++)
{
	var tl, px, xoff;
	tl = par.tree[t]
	px = dx
	xoff = 0
	
	if (tl.tree_amount > 0)
	{
		draw_image(spr_icons, test(tl.tree_extend, icons.arrowdowntiny, icons.arrowrighttiny), dx + 2, dy + itemh / 2, 1, 1, setting_color_text, 1)
		xoff = 10
	}
	
	draw_label(string_remove_newline(tl.display_name), dx + xoff, dy + itemh / 2, fa_left, fa_middle, null, 1, test(tl.select, setting_font_bold, setting_font))
	
	dx += indent
	dy += itemh
	
	if (tl.tree_extend)
		window_draw_timeline_move_tree(tl)
		
	dx = px
}
