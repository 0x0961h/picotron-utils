--[[pod_format="raw",created="2025-02-22 18:44:33",modified="2025-02-23 18:39:52",revision=93]]
-- Author: 0x0961h
-- Part of Picotron Utils (https://github.com/0x0961h/picotron-utils)

function dump(t, indent)
    indent = indent or 0
    for k, v in pairs(t) do
        local key = tostring(k)
        if type(v) == "table" then
            print(string.rep(" ", indent * 2) .. "[" .. key .. "] {")
            dump(v, indent + 1)
            print(string.rep(" ", indent * 2) .. "}")
        else
            if type(v) == "string" then v = '"'..v..'"' end
            print(string.rep(" ", indent * 2) .. "[" .. key .. "] = "..tostring(v))
        end
    end
end

pwd = env().path
args = env().argv

if #args == 0 then
	print("usage: cat [filename of path to file]..\n")
	return
end

if args[1] == "--help" then
	print("usage: cat [filename of path to file]..")
	print("Prints contents of files to terminal console\n")
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
	
	if not (ftype) then
		print("cat: Can't find " .. fpath .. "\n")
		return
	end
	
	if ftype == "folder" then
		print("cat: " .. fpath .. " is a folder\n")
		return
	end
	
	data = fetch(fpath)
	if not data then
		print("cat: Can't read " .. fpath .. "\n")
		return
	end
	
	dtype = type(data)
	if dtype == "table" then
		print("Table Contents:\n")
		dump(data, 2)
		print("")
	elseif dtype == "string" then
		print(data)
	else
		print("cat: Unknown data type: " .. dtype)
		return
	end
end