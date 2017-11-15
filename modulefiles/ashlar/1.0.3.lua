help([[
ASHLAR
]])

local base        = "/n/groups/lsp/o2/apps/ashlar/"
local pkgName     = myModuleName()
local fullVersion = myModuleVersion()

load("gcc")
load(atleast("python", "2.7"))
load("java")
load("fftw/3.3.6-pl1")
append_path("PATH", pathJoin(base, fullVersion, "/venv/bin/"))

whatis("Name: ".. pkgName)
whatis("Version: " .. fullVersion)
whatis("Category: tools")
whatis("URL: http://github.com/sorgerlab/ashlar")
whatis("Description: Alignment by Simultaneous Harmonization of Layer/Adjacency Registration")
