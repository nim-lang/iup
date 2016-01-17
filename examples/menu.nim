import iup

discard iup.open(nil, nil)

var fileItemLoad = iup.item("Load", "")
var fileItemSave = iup.item("Save", "")
var fileItemClose = iup.item("Close", "")

var fileMenu = iup.menu(fileItemLoad, fileItemSave, fileItemClose, nil)
var mainMenu = iup.menu(iup.subMenu("File", fileMenu), nil)

discard iup.setHandle("mainMenu", mainMenu)

var dlg = iup.dialog(nil)
iup.setAttribute(dlg, "TITLE", "iupTabs")
iup.setAttribute(dlg, "SIZE", "200x100")
iup.setAttribute(dlg, "MENU", "mainMenu")

discard iup.showXY(dlg, IUP_CENTER, IUP_CENTER)
discard iup.mainLoop()

iup.close()