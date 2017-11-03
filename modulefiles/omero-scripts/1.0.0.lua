help([[
OMERO scripts
]])

local base        = "/n/groups/lsp/o2/apps/omero-scripts/"
local pkgName     = myModuleName()
local fullVersion = myModuleVersion()

load("gcc")
load(atleast("python", "2.7"))
load("omero")
append_path("PATH", pathJoin(base, fullVersion, "/venv/bin/"))

whatis("Name: ".. pkgName)
whatis("Version: " .. fullVersion)
whatis("Category: tools")
whatis("URL: http://github.com/sorgerlab/OMERO_scripts")
whatis("Description: OMERO scripts")
