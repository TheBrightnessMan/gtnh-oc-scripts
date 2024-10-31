component = require("component")
os = require("os")
ae2_lib = require("ae2_lib")
gt = component.gt_machine

he_plasma = ae2_lib.getRecipe("Grade 5 Plasma")
coolant = ae2_lib.getRecipe("Grade 5 Coolant")
if he_plasma == nil then error("He Plasma recipe not found!") end
if coolant == nil then error("Coolant recipe not found!") end

cpu = ae2_lib.getCpuByName("5")
if cpu == nil then error("CPU 5 not found!") end

while true do
    print("Starting cycle...")
    if gt.getWorkMaxProgress() == 0 then
        print("Machine disabled, sleep 10...")
        os.sleep(10)
    else
        for i = 1, 3, 1 do
            print("Loop " .. tostring(i))
            print("Requesting 100L of He Plasma...")
            ae2_lib.requestRecipeCancel(he_plasma, 100, cpu, 2)
            print("Waiting 11 seconds for plasma to be consumed...")
            os.sleep(11)

            print("Requesting 2000L of Coolant...")
            ae2_lib.requestRecipeCancel(coolant, 2000, cpu, 2)
            print("Waiting 21 seconds for plasma to be consumed...")
            os.sleep(21)
        end
        print("Completed 3 loops.")
        sleep = ((2400 - gt.getWorkProgress()) // 20) + 3
        print("Sleeping for " .. tonumber(sleep) .. " seconds...")
        os.sleep(sleep)
    end
end
