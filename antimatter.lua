ae2_lib = require("ae2_lib")
os = require("os")
component = require("component")
me = component.me_interface
redstone = component.redstone

single = ae2_lib.getRecipe("Antimatter 1")
kilo = ae2_lib.getRecipe("Antimatter 1k")
mega = ae2_lib.getRecipe("Antimatter 1M")
if single == nil then error("Antimatter 1 not found!") end
if kilo == nil then error("Antimatter 1k not found!") end
if mega == nil then error("Antimatter 1M not found!") end

cpu = ae2_lib.getCpuByName("Antimatter")
if cpu == nil then error("CPU Antimatter not found!") end

while true do
    print("Starting cycle...")
    -- Empty hatches
    redstone.setOutput(3, 15)
    os.sleep(0.05)
    redstone.setOutput(3, 0)

    antimatter = me.getItemsInNetwork({label = "drops of Semi-Stable Antimatter"})[1]
    if antimatter == nil then
        print("Antimatter not found, sleeping 10...")
        os.sleep(10)
    else
        request_me = single
        request_count = antimatter.size // 16
        
        if request_count < 1 then
            print("Not enough Antimatter, sleeping 10...")
            os.sleep(10)
        else
            if antimatter.size // 16777216 >= 1 then
                request_me = mega
                -- Sampsa said most efficient is ~100M antimatter, ie ~6M in each hatch
                -- https://discord.com/channels/181078474394566657/181078474394566657/1270460099621552241
                request_count = math.min(antimatter.size // 16777216, 6)
                print("More than 16M, put " .. tonumber(request_count) .. "M in each hatch")
            elseif antimatter.size // 16384 >= 1 then
                request_me = kilo
                request_count = antimatter.size // 16384
                print("More than 16k, put " .. tonumber(request_count) .. "k in each hatch")
            else
                print("Less than 16k, put " .. tonumber(request_count) .. " in each hatch")
            end

            ae2_lib.requestRecipeCancel(request_me, request_count, cpu, 0.05)
            print("Done with insersion, sleeping 1 tick...")
            os.sleep(0.05)
        end
    end
end