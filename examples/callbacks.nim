import iup


proc btn_click(ih:PIhandle):cint {.cdecl.}=
    iup.message("Popup", "You clicked the button!")


discard iup.open(nil, nil)

var btn = iup.button("Click me!", nil)
discard iup.setCallback(btn, "ACTION", cast[ICallback](btn_click))

var dlg = iup.dialog(iup.vbox(btn, nil))
iup.setAttribute(dlg, "TITLE", "iupTabs")

discard iup.showXY(dlg, IUP_CENTER, IUP_CENTER)
discard iup.mainLoop()

iup.close()