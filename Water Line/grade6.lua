component = require("component")
os = require("os")

gt = component.gt_machine
inventoryController = component.inventory_controller
database = component.database
redstone = component.redstone
exportBus = component.me_exportbus
importBus = component.me_importbus
exportBusSide = sides.south
importBusSide = sides.north

for i = 1, 9 do
    inventoryController.store(sides.west, i, database.address, i)
end

lens = 8

while true do
    print("Starting cycle...")
    if gt.getWorkMaxProgress() == 0 then
        print("Machine disabled, sleep 10...")
        os.sleep(10)
    else
        info = gt.getSensorInformation()
        amount_str = info[4]
        length = string.len(amount_str)
        amount = tonumber(string.sub(amount_str, 35))

        if amount >= 10 then
            print("10 swaps completed.")
            lens = 8
            sleep = ((2400 - gt.getWorkProgress()) // 20) + 1
            print("Sleeping for " .. tonumber(sleep) .. " seconds...")
            os.sleep(sleep)
        else
            if redstone.getInput(sides.bottom) > 0 then
                print("Swapping...")
                exportBus.setExportConfiguration(exportBusSide, database.address, lens + 1)
                exportBus.exportIntoSlot(exportBusSide, lens + 1)
                lens = (lens + 1) % 9
                importBus.setImportConfiguration(importBusSide, database.address, lens + 1)
                redstone.setOutput(sides.west, 15)
                os.sleep(1)
                redstone.setOutput(sides.west, 0)
            else
                os.sleep(1)
            end
        end
    end
end