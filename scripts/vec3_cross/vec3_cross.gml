/// vec3_cross(vector1, vector2)
/// @arg vector1
/// @arg vector2

gml_pragma("forceinline")

var v1, v2;
v1 = argument0
v2 = argument1

return vec3(
	v1[@ Y] * v2[@ Z] - v1[@ Z] * v2[@ Y],
	v1[@ Z] * v2[@ X] - v1[@ X] * v2[@ Z],
	v1[@ X] * v2[@ Y] - v1[@ Y] * v2[@ X]
)