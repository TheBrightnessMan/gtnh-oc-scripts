component = require("component")
os = require("os")

me = component.me_interface
gt = component.gt_machine

while true do
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
    diff = gt.getWorkMaxProgress() - gt.getWorkProgress()
    os.sleep(diff + 3)