component = require("component")
os = require("os")

me = component.me_interface
gt = component.gt_machine

function addFluid()
    cpu = me.getCpus()[1]
    craftables = me.getCraftables()

    request_me = nil
    for _, craftable in pairs(craftables) do
        item = craftable.getItemStack()
        if item["label"] == "Input Polyaluminium Chloride" then
            request_me = craftable
            break
        end
    end

    if request_me == nil then
        error("Item not found!")
    end

    request_me.request(1, False, cpu["name"])
    os.sleep(1)
    cpu.cpu.cancel()
end

while true do
    if gt.getWorkMaxProgress() == 0 then
        -- Machine is off, come back later
        os.sleep(5)
    else
        info = gt.getSensorInformation()
        amount_str = info[3]
        length = string.len(amount_str)
        amount = tonumber(string.sub(amount_str, 48, length - 1))

        if amount == 0 then
            addFluid()
        end
        
        diff = (2400 - gt.getWorkProgress()) // 20
        os.sleep(diff + 3)
    end
end