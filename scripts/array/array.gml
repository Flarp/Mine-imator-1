/// array(a, b, c...)
/// @arg a
/// @arg b
/// @arg c...

gml_pragma("forceinline")

var arr;
arr[0] = 0
for (var a = 0; a < argument_count; a++)
	arr[a] = argument[a]
return arr
