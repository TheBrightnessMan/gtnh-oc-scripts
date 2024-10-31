components = require("component")
os = require("os")
ae2_lib = require("ae2_lib")

compressor = nil
crib1 = nil
crib2 = nil

compressor_name = "multimachine.blackholecompressor"
crib_name = "hatch.crafting_input.me"

for addr, type in components.list("gt_machine", true) do
  component = components.proxy(addr)
  component_name = component.getName()
  if component_name == compressor_name then
    compressor = component
    print("Black Hole Compressor:", compressor.address, compressor.getName())
  elseif component_name == crib_name then
    if crib1 == nil then
      crib1 = component
      print("Crib1:", crib1.address, crib1.getName())
    else
      crib2 = component
      print("crib2:", crib2.address, crib2.getName())
    end
  end
end

if compressor == nil then error("Black Hole Compressor not found!") end
if crib1 == nil then error("Crib 1 not found!") end
if crib2 == nil then error("Crib 2 not found!") end

open = ae2_lib.getRecipe("Open")
close = ae2_lib.getRecipe("Close")
if open == nil then error("Open recipe not found!") end
if close == nil then error("Close recipe not found!") end

cpu = ae2_lib.getCpuByName("Black Hole")
if cpu == nil then error("CPU Black Hole not found!") end

while true do
  print("Begin cycle!")
  print("Checking for inputs...")
  crib1_info = crib1.getSensorInformation()
  crib2_info = crib2.getSensorInformation()
  hasRecipes = false

  if #crib1_info >= 4 then
    for i = 3, #crib1_info do
      crib1_info_line = crib1_info[i]
      if string.sub(crib1_info_line, 1, string.len("Slot ")) ~= "Slot " then
        print("Crib1 has recipes")
        hasRecipes = true
        break
      end
    end
  end

  if #crib2_info >= 4 then
    for i = 3, #crib2_info do
      crib2_info_line = crib2_info[i]
      if string.sub(crib2_info_line, 1, string.len("Slot ")) ~= "Slot " then
        print("Crib2 has recipes")
        hasRecipes = true
        break
      end
    end
  end

  if not hasRecipes then
    print("No recipes, sleeping 10...")
    os.sleep(10)
  else
    print("Has recipe, opening black hole...")
    ae2_lib.requestRecipeCancel(open, 1, cpu, 3)
    stability = 100.0
  
    while stability >= 1.0 do
      print("Stability:", stability)
      decay = 1.0
      if compressor.isMachineActive() then
        decay = 0.75
      end
      stability = stability - decay
      os.sleep(1)
    end    
    ae2_lib.requestRecipeCancel(close, 1, cpu, 3)
    print("Unstable black hole, closing it...")
  end
end
