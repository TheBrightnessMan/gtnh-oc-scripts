component = require("component")
os = require("os")
ae2_lib = require("ae2_lib")
gt = component.gt_machine
redstone = component.redstone

quarks = {}
quarks[0] = ae2_lib.getRecipe("Up")
quarks[1] = ae2_lib.getRecipe("Down")
quarks[2] = ae2_lib.getRecipe("Top")
quarks[3] = ae2_lib.getRecipe("Bottom")
quarks[4] = ae2_lib.getRecipe("Strange")
quarks[5] = ae2_lib.getRecipe("Charm")

for i = 0, 5 do
    if quarks[i] == nil then error(tostring(i) .. " recipe not found!") end

while true do
    print("Starting cycle...")
    if gt.getWorkMaxProgress() == 0 then
        print("Machine disabled, sleep 10...")
        os.sleep(10)
    else
        info = gt.getSensorInformation()
        success_String = info[#info]
        success = string.sub(success_String, 44)
        if success == "No" then
            for i = 0, 4 do
                for j = (i+1), 5 do
                    print("Inserting " .. tostring(i) .. ", " .. tostring(j))
                    ae2_lib.requestRecipeCancel(quarks[i], 1, 5, 1)
                    ae2_lib.requestRecipeCancel(quarks[j], 1, 5, 1)
                end
            end
        end
        print("Checked all combos OR Pair found.")
        sleep = ((2400 - gt.getWorkProgress()) // 20) + 3
        print("Sleeping for " .. tonumber(sleep) .. " seconds...")
        os.sleep(sleep)
    end
end
