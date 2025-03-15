component = require("component")
me = component.me_interface
redstone = component.redstone
transposer = component.transposer
gt = component.gt_machine

math = require("math")
sides = require("sides")
os = require("os")

while true do
    redstone.setOutput(sides.east, 15)
    redstone.setOutput(sides.east, 0)

    if gt.getWorkMaxProgress() == 0 then
        print("Machine off, sleeping 3s...")
        os.sleep(3)
    else
        antimatter = me.getFluidsInNetwork({label = "Semi-Stable Antimatter"})[1]
        if antimatter then
            amount = math.min(antimatter.amount // 16, 4624873) * 16
            print("Transfering " .. tostring(amount) .. "mL of Antimatter")
            transposer.transferFluid(sides.up, sides.east, amount)
            os.sleep((20 - gt.getWorkProgress()) / 20)
        end
    end
end
