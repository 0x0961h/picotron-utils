--[[pod_format="raw",created="2025-02-22 18:44:33",modified="2025-02-23 18:38:22",revision=93]]
pwd = env().path
args = env().argv

if #args == 0 then
	print("usage: touch [filename of path to file]..\n")
	return
end

if args[1] == "--help" then
	print("usage: touch [filename of path to file]..")
	print("Creates empty files\n")
	return
end

for _, fpath in ipairs(args) do
	if args[1][1] != "/" then
		if pwd != "/" then 
			fpath = pwd .. "/" .. fpath
		else
			fpath = "/" .. fpath
		end
	end
	
	ftype = fstat(fpath)
	
	if ftype then
		print("touch: " .. fpath .. " already exists\n")
		return
	end
	
	store(fpath, "")
end