help([[
stitcher
]])

local base        = "/n/groups/lsp/o2/apps/stitcher/"
local pkgName     = myModuleName()
local fullVersion = myModuleVersion()

load("java")
append_path("PATH", pathJoin(base, fullVersion, "/bin/"))

whatis("Name: ".. pkgName)
whatis("Version: " .. fullVersion)
whatis("Category: tools")
whatis("Description: Glencoe Software's stitching and pyramid generation tool")
