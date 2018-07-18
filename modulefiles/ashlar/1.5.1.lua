help([[
ASHLAR
]])

local base        = "/n/groups/lsp/o2/apps/ashlar/"
local pkgName     = myModuleName()
local fullVersion = myModuleVersion()

load("gcc")
load(atleast("python", "2.7"))
load("java")
load("fftw")
append_path("PATH", pathJoin(base, fullVersion, "/venv/bin/"))

-- Environment change - assume single threaded.
if (mode() == "load" and os.getenv("OMP_NUM_THREADS") == nil) then
  setenv("OMP_NUM_THREADS","1")
end

whatis("Name: ".. pkgName)
whatis("Version: " .. fullVersion)
whatis("Category: tools")
whatis("URL: http://github.com/sorgerlab/ashlar")
whatis("Description: Alignment by Simultaneous Harmonization of Layer/Adjacency Registration")
