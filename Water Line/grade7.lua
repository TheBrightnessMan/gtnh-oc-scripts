component = require("component")
os = require("os")
ae2_lib = require("ae2_lib")
gt = component.gt_machine
redstone = component.redstone

bit1_input = {}
bit1_input[0] = ae2_lib.getRecipe("He")
bit1_input[1] = ae2_lib.getRecipe("Ne")
bit1_input[2] = ae2_lib.getRecipe("Kr")
bit1_input[3] = ae2_lib.getRecipe("Xe")

superconductor = ae2_lib.getRecipe("Superconductor")
neutronium = ae2_lib.getRecipe("Nt")
coolant = ae2_lib.getRecipe("grade7 Coolant")

if bit1_input[0] == nil then error("He recipe not found!") end
if bit1_input[1] == nil then error("Ne recipe not found!") end
if bit1_input[2] == nil then error("Kr recipe not found!") end
if bit1_input[3] == nil then error("Xe recipe not found!") end
if superconductor == nil then error("Superconductor recipe not found!") end
if neutronium == nil then error("Nt recipe not found!") end
if coolant == nil then error("grade7 Coolant recipe not found!") end

while true do
    print("Starting cycle...")
    if gt.getWorkMaxProgress() == 0 then
        print("Machine disabled, sleep 10...")
        os.sleep(10)
    else
        signal = redstone.getInput(sides.bottom)
        print("Signal: " .. tonumber(signal))

        if signal == 0 then
            print("Overloaded! Inserting Super Coolant...")
            ae2_lib.requestRecipeCancel(coolant, 1, 4, 2)
        else
            bit1 = signal & 1
            bit2 = (signal >> 1) & 1
            bit3 = (signal >> 2) & 1
            bit4 = (signal >> 3) & 1

            if bit4 ~= 1 then
                print("Bit 4 not set. Begin decode...")
                if bit1 == 1 then
                    print("Bit 1 set, inserting gas...")
                    gasId = (signal >> 1) & 3
                    gas = bit1_input[gasId]
                    ae2_lib.requestRecipeCancel(gas, 1, 4, 2)
                    print("Bit 1 decode successful!")
                end

                if bit2 == 1 then
                    print("Bit 2 set, inserting superconductor...")
                    ae2_lib.requestRecipeCancel(superconductor, 1, 4, 2)
                    print("Bit 2 decode successful!")
                end

                if bit3 == 1 then
                    print("Bit 3 set, inserting neutronium...")
                    ae2_lib.requestRecipeCancel(neutronium, 1, 4, 2)
                    print("Bit 3 decode successful!")
                end
            end
        end
        print("Decode completed!")
        sleep = ((2400 - gt.getWorkProgress()) // 20) + 3
        print("Sleeping for " .. tonumber(sleep) .. " seconds...")
        os.sleep(sleep)
    end
end
