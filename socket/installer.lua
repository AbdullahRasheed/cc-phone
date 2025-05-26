local releasePath = ""
local devPath = "https://raw.githubusercontent.com/AbdullahRasheed/cc-phone/refs/heads/main/socket/"
local includePath = "https://raw.githubusercontent.com/AbdullahRasheed/cc-phone/refs/heads/main/socket/include"
local args = {...}

local function getIncludes()
    local includes = {}
    local request = http.get(includePath, {"Cache-Control: private, no-store, max-age=0"})
    if request then
        local line = request.readLine()
        while line do
            table.insert(includes, line)
            print("Added " .. line .. " to includes.")
            line = request.readLine()
        end
        request.close()
    else
        error("Failed to fetch include list")
    end
    return includes
end

print("Installing dev version...")
local includes = getIncludes()
if not includes then
    error("Failed to fetch include list")
end

local function downloadFile(url, path, name, size, currentFile, totalFiles)
    print("Attempting to download at " .. path)
    print("Downloading " .. name..(size > 0 and " (" .. size/1000 .. " kb)" or "") .. " (" .. currentFile .. "/" .. totalFiles .. ")")
    local request = http.get(url)
    if request then
        local file = fs.open(path, "w")
        file.write(request.readAll())
        file.close()
        request.close()
    else
        error("Failed to download " .. name)
    end
end

local currentFile = 0
for _, fileName in ipairs(includes) do
    downloadFile(devPath .. fileName, fs.combine(fs.getDir(shell.getRunningProgram()), fileName), fileName, 0, currentFile + 1, #includes)
    currentFile = currentFile + 1
end

print("Dev installation complete!")
return
