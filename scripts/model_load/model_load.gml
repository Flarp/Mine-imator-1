/// model_load()
/// @desc Loads the parts and shapes from the selected filename into the model.

if (loaded)
	return 0
	
debug("Loading model", filename)

if (!file_exists_lib(filename))
{
	log("Could not find model file")
	return null
}

var json = file_text_contents(filename);
if (json = "")
{
	log("Model file was empty")
	return null
}

var map = json_decode(json);
if (map < 0)
{
	log("Could not parse JSON")
	return null
}

if (!is_string(map[?"name"]))
{
	log("Missing parameter \"name\"")
	return null
}

if (!is_string(map[?"texture"]))
{
	log("Missing parameter \"texture\"")
	return null
}

if (!is_real(map[?"texture_size"]) || !ds_exists(map[?"texture_size"], ds_type_list))
{
	log("Missing array \"texture_size\"")
	return null
}

if (!is_real(map[?"parts"]) || !ds_exists(map[?"parts"], ds_type_list))
{
	log("Missing array \"parts\"")
	return null
}

// Name
model_load_name(map[?"name"])
	
// Description (optional)
if (is_string(map[?"description"]))
	description = map[?"description"]
else
	description = ""
		
// Texture
model_load_texture(map[?"texture"])
	
// Texture size
var texturesizelist = map[?"texture_size"];
texture_size = vec2(texturesizelist[|X], texturesizelist[|Y])

// Use skin
use_skin = false
if (is_real(map[?"use_skin"]))
	use_skin = map[?"use_skin"]
	
// Bounds in default position
bounds_start = point3D(0, 0, 0)
bounds_end = point3D(0, 0, 0)
	
// Read all the parts of the root
var partlist = map[?"parts"]
part_amount = ds_list_size(partlist)
for (var p = 0; p < part_amount; p++)
{
	part[p] = model_read_part(partlist[|p])
	if (part[p] = null)
		return null
}
	
ds_map_destroy(map)

loaded = true

return 0