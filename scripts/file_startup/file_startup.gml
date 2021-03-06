/// file_startup()

var surf, tmpfile1, tmpfile2, tex1, tex2;

// Define directories
log("working_directory", working_directory)
if (!directory_exists_lib(working_directory))
{
	log("directory broken")
	access_error()
	return 0
}

// Write access
surf = surface_create(32, 32)
tmpfile1 = file_directory + "tmp.png" // Can I write to file bundle?
tmpfile2 = data_directory + "tmp.png" // Can I copy to installation folder?

log("Trying to save files")
file_delete_lib(tmpfile1)
file_delete_lib(tmpfile2)
surface_save(surf, tmpfile1)
file_copy_lib(tmpfile1, tmpfile2)

surface_free(surf)

if (!file_exists_lib(tmpfile1))
{
	log("Couldn't save to file_directory")
	access_error()
	return 0
}

if (!file_exists_lib(tmpfile2))
{
	log("Couldn't save to data_directory")
	access_error()
	return 0
}

log("surface_save OK")

tex1 = texture_create(tmpfile1) // Can I load textures from file bundle?
tex2 = texture_create(tmpfile2) // Can I load textures from installation folder?

if (!tex1 || texture_width(tex1) != 32 || texture_height(tex1) != 32)
{
	log("Couldn't load texture from file_directory")
	access_error()
	return 0
}

if (!tex2 || texture_width(tex2) != 32 || texture_height(tex2) != 32)
{
	log("Couldn't load texture from data_directory")
	access_error()
	return 0
}

log("texture_create OK")

file_delete_lib(tmpfile1) // Can I delete from file bundle?
file_delete_lib(tmpfile2) // Can I delete from installation folder?

if (file_exists_lib(tmpfile1))
{
	log("Couldn't delete from file_directory")
	access_error()
	return 0
}

if (file_exists_lib(tmpfile1))
{
	log("Couldn't delete from data_directory")
	access_error()
	return 0
}

log("file_delete_lib OK")

return 1
