# IUP-Nim Runtime Library
# Based on Andreas Rumpf's original hand translation, modernized and upgraded to v3.25

# *****************************************************************************
#  Copyright (C) 1994-2018 Tecgraf/PUC-Rio.
#
#  Permission is hereby granted, free of charge, to any person obtaining
#  a copy of this software and associated documentation files (the
#  "Software"), to deal in the Software without restriction, including
#  without limitation the rights to use, copy, modify, merge, publish,
#  distribute, sublicense, and/or sell copies of the Software, and to
#  permit persons to whom the Software is furnished to do so, subject to
#  the following conditions:
#
#  The above copyright notice and this permission notice shall be
#  included in all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# ****************************************************************************

{.deadCodeElim: on.}

import iupkey

when defined(windows):
  const libiup* = "iup.dll"
elif defined(macosx):
  const iuplib* = "libiup.dylib"
else:
  const iuplib* = "libiup.so"

const
  IUP_NAME* = "IUP - Portable User Interface"
  IUP_DESCRIPTION* = "Multi-platform Toolkit for Building Graphical User Interfaces"
  IUP_COPYRIGHT* = "Copyright (C) 1994-2018 Tecgraf/PUC-Rio"
  IUP_VERSION* = "3.25"
  IUP_VERSION_NUMBER* = 325000
  IUP_VERSION_DATE* = "2018/05/28"

type
  Ihandle = object
  PIhandle* = ptr Ihandle
  Icallback* = proc (arg: PIhandle): cint {.cdecl.}

# **********************************************************************
#                         Main API
# **********************************************************************

proc open*(argc: ptr cint; argv: ptr cstringArray): cint {.cdecl, importc: "IupOpen", dynlib: libiup.}
proc close*() {.cdecl, importc: "IupClose", dynlib: libiup.}
proc imageLibOpen*() {.cdecl, importc: "IupImageLibOpen", dynlib: libiup.}
proc mainLoop*(): cint {.cdecl, importc: "IupMainLoop", dynlib: libiup.}
proc loopStep*(): cint {.cdecl, importc: "IupLoopStep", dynlib: libiup.}
proc loopStepWait*(): cint {.cdecl, importc: "IupLoopStepWait", dynlib: libiup.}
proc mainLoopLevel*(): cint {.cdecl, importc: "IupMainLoopLevel", dynlib: libiup.}
proc flush*() {.cdecl, importc: "IupFlush", dynlib: libiup.}
proc exitLoop*() {.cdecl, importc: "IupExitLoop", dynlib: libiup.}
proc recordInput*(filename: cstring; mode: cint): cint {.cdecl, importc: "IupRecordInput", dynlib: libiup.}
proc playInput*(filename: cstring): cint {.cdecl, importc: "IupPlayInput", dynlib: libiup.}
proc update*(ih: PIhandle) {.cdecl, importc: "IupUpdate", dynlib: libiup.}
proc updateChildren*(ih: PIhandle) {.cdecl, importc: "IupUpdateChildren", dynlib: libiup.}
proc redraw*(ih: PIhandle; children: cint) {.cdecl, importc: "IupRedraw", dynlib: libiup.}
proc refresh*(ih: PIhandle) {.cdecl, importc: "IupRefresh", dynlib: libiup.}
proc refreshChildren*(ih: PIhandle) {.cdecl, importc: "IupRefreshChildren", dynlib: libiup.}
proc execute*(filename: cstring; parameters: cstring): cint {.cdecl, importc: "IupExecute", dynlib: libiup.}
proc executeWait*(filename: cstring; parameters: cstring): cint {.cdecl, importc: "IupExecuteWait", dynlib: libiup.}
proc help*(url: cstring): cint {.cdecl, importc: "IupHelp", dynlib: libiup.}
proc log*(ttype: cstring; format: cstring) {.varargs, cdecl, importc: "IupLog", dynlib: libiup.}
proc load*(filename: cstring): cstring {.cdecl, importc: "IupLoad", dynlib: libiup.}
proc loadBuffer*(buffer: cstring): cstring {.cdecl, importc: "IupLoadBuffer", dynlib: libiup.}
proc version*(): cstring {.cdecl, importc: "IupVersion", dynlib: libiup.}
proc versionDate*(): cstring {.cdecl, importc: "IupVersionDate", dynlib: libiup.}
proc versionNumber*(): cint {.cdecl, importc: "IupVersionNumber", dynlib: libiup.}
proc setLanguage*(lng: cstring) {.cdecl, importc: "IupSetLanguage", dynlib: libiup.}
proc getLanguage*(): cstring {.cdecl, importc: "IupGetLanguage", dynlib: libiup.}
proc setLanguageString*(name: cstring; str: cstring) {.cdecl, importc: "IupSetLanguageString", dynlib: libiup.}
proc storeLanguageString*(name: cstring; str: cstring) {.cdecl, importc: "IupStoreLanguageString", dynlib: libiup.}
proc getLanguageString*(name: cstring): cstring {.cdecl, importc: "IupGetLanguageString", dynlib: libiup.}
proc setLanguagePack*(ih: PIhandle) {.cdecl, importc: "IupSetLanguagePack", dynlib: libiup.}
proc destroy*(ih: PIhandle) {.cdecl, importc: "IupDestroy", dynlib: libiup.}
proc detach*(child: PIhandle) {.cdecl, importc: "IupDetach", dynlib: libiup.}
proc append*(ih: PIhandle; child: PIhandle): PIhandle {.cdecl, importc: "IupAppend", dynlib: libiup.}
proc insert*(ih: PIhandle; refChild: PIhandle; child: PIhandle): PIhandle {.cdecl, importc: "IupInsert", dynlib: libiup.}
proc getChild*(ih: PIhandle; pos: cint): PIhandle {.cdecl, importc: "IupGetChild", dynlib: libiup.}
proc getChildPos*(ih: PIhandle; child: PIhandle): cint {.cdecl, importc: "IupGetChildPos", dynlib: libiup.}
proc getChildCount*(ih: PIhandle): cint {.cdecl, importc: "IupGetChildCount", dynlib: libiup.}
proc getNextChild*(ih: PIhandle; child: PIhandle): PIhandle {.cdecl, importc: "IupGetNextChild", dynlib: libiup.}
proc getBrother*(ih: PIhandle): PIhandle {.cdecl, importc: "IupGetBrother", dynlib: libiup.}
proc getParent*(ih: PIhandle): PIhandle {.cdecl, importc: "IupGetParent", dynlib: libiup.}
proc getDialog*(ih: PIhandle): PIhandle {.cdecl, importc: "IupGetDialog", dynlib: libiup.}
proc getDialogChild*(ih: PIhandle; name: cstring): PIhandle {.cdecl, importc: "IupGetDialogChild", dynlib: libiup.}
proc reparent*(ih: PIhandle; newParent: PIhandle; refChild: PIhandle): cint {.cdecl, importc: "IupReparent", dynlib: libiup.}
proc popup*(ih: PIhandle; x: cint; y: cint): cint {.cdecl, importc: "IupPopup", dynlib: libiup.}
proc show*(ih: PIhandle): cint {.cdecl, importc: "IupShow", dynlib: libiup.}
proc showXY*(ih: PIhandle; x: cint; y: cint): cint {.cdecl, importc: "IupShowXY", dynlib: libiup.}
proc hide*(ih: PIhandle): cint {.cdecl, importc: "IupHide", dynlib: libiup.}
proc map*(ih: PIhandle): cint {.cdecl, importc: "IupMap", dynlib: libiup.}
proc unmap*(ih: PIhandle) {.cdecl, importc: "IupUnmap", dynlib: libiup.}
proc resetAttribute*(ih: PIhandle; name: cstring) {.cdecl, importc: "IupResetAttribute", dynlib: libiup.}
proc getAllAttributes*(ih: PIhandle; names: cstringArray; n: cint): cint {.cdecl, importc: "IupGetAllAttributes", dynlib: libiup.}
proc setAtt*(handleName: cstring; ih: PIhandle; name: cstring): PIhandle {.varargs, cdecl, importc: "IupSetAtt", dynlib: libiup.}
proc setAttributes*(ih: PIhandle; str: cstring): PIhandle {.cdecl, importc: "IupSetAttributes", dynlib: libiup.}
proc getAttributes*(ih: PIhandle): cstring {.cdecl, importc: "IupGetAttributes", dynlib: libiup.}
proc setAttribute*(ih: PIhandle; name: cstring; value: cstring) {.cdecl, importc: "IupSetAttribute", dynlib: libiup.}
proc setStrAttribute*(ih: PIhandle; name: cstring; value: cstring) {.cdecl, importc: "IupSetStrAttribute", dynlib: libiup.}
proc setStrf*(ih: PIhandle; name: cstring; format: cstring) {.varargs, cdecl, importc: "IupSetStrf", dynlib: libiup.}
proc setInt*(ih: PIhandle; name: cstring; value: cint) {.cdecl, importc: "IupSetInt", dynlib: libiup.}
proc setFloat*(ih: PIhandle; name: cstring; value: cfloat) {.cdecl, importc: "IupSetFloat", dynlib: libiup.}
proc setDouble*(ih: PIhandle; name: cstring; value: cdouble) {.cdecl, importc: "IupSetDouble", dynlib: libiup.}
proc setRGB*(ih: PIhandle; name: cstring; r: cuchar; g: cuchar; b: cuchar) {.cdecl, importc: "IupSetRGB", dynlib: libiup.}
proc getAttribute*(ih: PIhandle; name: cstring): cstring {.cdecl, importc: "IupGetAttribute", dynlib: libiup.}
proc getInt*(ih: PIhandle; name: cstring): cint {.cdecl, importc: "IupGetInt", dynlib: libiup.}
proc getInt2*(ih: PIhandle; name: cstring): cint {.cdecl, importc: "IupGetInt2", dynlib: libiup.}
proc getIntInt*(ih: PIhandle; name: cstring; i1: ptr cint; i2: ptr cint): cint {.cdecl, importc: "IupGetIntInt", dynlib: libiup.}
proc getFloat*(ih: PIhandle; name: cstring): cfloat {.cdecl, importc: "IupGetFloat", dynlib: libiup.}
proc getDouble*(ih: PIhandle; name: cstring): cdouble {.cdecl, importc: "IupGetDouble", dynlib: libiup.}
proc getRGB*(ih: PIhandle; name: cstring; r: ptr cuchar; g: ptr cuchar; b: ptr cuchar) {.cdecl, importc: "IupGetRGB", dynlib: libiup.}
proc setAttributeId*(ih: PIhandle; name: cstring; id: cint; value: cstring) {.cdecl, importc: "IupSetAttributeId", dynlib: libiup.}
proc setStrAttributeId*(ih: PIhandle; name: cstring; id: cint; value: cstring) {.cdecl, importc: "IupSetStrAttributeId", dynlib: libiup.}
proc setStrfId*(ih: PIhandle; name: cstring; id: cint; format: cstring) {.varargs, cdecl, importc: "IupSetStrfId", dynlib: libiup.}
proc setIntId*(ih: PIhandle; name: cstring; id: cint; value: cint) {.cdecl, importc: "IupSetIntId", dynlib: libiup.}
proc setFloatId*(ih: PIhandle; name: cstring; id: cint; value: cfloat) {.cdecl, importc: "IupSetFloatId", dynlib: libiup.}
proc setDoubleId*(ih: PIhandle; name: cstring; id: cint; value: cdouble) {.cdecl, importc: "IupSetDoubleId", dynlib: libiup.}
proc setRGBId*(ih: PIhandle; name: cstring; id: cint; r: cuchar; g: cuchar; b: cuchar) {.cdecl, importc: "IupSetRGBId", dynlib: libiup.}
proc getAttributeId*(ih: PIhandle; name: cstring; id: cint): cstring {.cdecl, importc: "IupGetAttributeId", dynlib: libiup.}
proc getIntId*(ih: PIhandle; name: cstring; id: cint): cint {.cdecl, importc: "IupGetIntId", dynlib: libiup.}
proc getFloatId*(ih: PIhandle; name: cstring; id: cint): cfloat {.cdecl, importc: "IupGetFloatId", dynlib: libiup.}
proc getDoubleId*(ih: PIhandle; name: cstring; id: cint): cdouble {.cdecl, importc: "IupGetDoubleId", dynlib: libiup.}
proc getRGBId*(ih: PIhandle; name: cstring; id: cint; r: ptr cuchar; g: ptr cuchar; b: ptr cuchar) {.cdecl, importc: "IupGetRGBId", dynlib: libiup.}
proc setAttributeId2*(ih: PIhandle; name: cstring; lin: cint; col: cint; value: cstring) {.cdecl, importc: "IupSetAttributeId2", dynlib: libiup.}
proc setStrAttributeId2*(ih: PIhandle; name: cstring; lin: cint; col: cint; value: cstring) {.cdecl, importc: "IupSetStrAttributeId2", dynlib: libiup.}
proc setStrfId2*(ih: PIhandle; name: cstring; lin: cint; col: cint; format: cstring) {.varargs, cdecl, importc: "IupSetStrfId2", dynlib: libiup.}
proc setIntId2*(ih: PIhandle; name: cstring; lin: cint; col: cint; value: cint) {.cdecl, importc: "IupSetIntId2", dynlib: libiup.}
proc setFloatId2*(ih: PIhandle; name: cstring; lin: cint; col: cint; value: cfloat) {.cdecl, importc: "IupSetFloatId2", dynlib: libiup.}
proc setDoubleId2*(ih: PIhandle; name: cstring; lin: cint; col: cint; value: cdouble) {.cdecl, importc: "IupSetDoubleId2", dynlib: libiup.}
proc setRGBId2*(ih: PIhandle; name: cstring; lin: cint; col: cint; r: cuchar; g: cuchar; b: cuchar) {.cdecl, importc: "IupSetRGBId2", dynlib: libiup.}
proc getAttributeId2*(ih: PIhandle; name: cstring; lin: cint; col: cint): cstring {.cdecl, importc: "IupGetAttributeId2", dynlib: libiup.}
proc getIntId2*(ih: PIhandle; name: cstring; lin: cint; col: cint): cint {.cdecl, importc: "IupGetIntId2", dynlib: libiup.}
proc getFloatId2*(ih: PIhandle; name: cstring; lin: cint; col: cint): cfloat {.cdecl, importc: "IupGetFloatId2", dynlib: libiup.}
proc getDoubleId2*(ih: PIhandle; name: cstring; lin: cint; col: cint): cdouble {.cdecl, importc: "IupGetDoubleId2", dynlib: libiup.}
proc getRGBId2*(ih: PIhandle; name: cstring; lin: cint; col: cint; r: ptr cuchar; g: ptr cuchar; b: ptr cuchar) {.cdecl, importc: "IupGetRGBId2", dynlib: libiup.}
proc setGlobal*(name: cstring; value: cstring) {.cdecl, importc: "IupSetGlobal", dynlib: libiup.}
proc setStrGlobal*(name: cstring; value: cstring) {.cdecl, importc: "IupSetStrGlobal", dynlib: libiup.}
proc getGlobal*(name: cstring): cstring {.cdecl, importc: "IupGetGlobal", dynlib: libiup.}
proc setFocus*(ih: PIhandle): PIhandle {.cdecl, importc: "IupSetFocus", dynlib: libiup.}
proc getFocus*(): PIhandle {.cdecl, importc: "IupGetFocus", dynlib: libiup.}
proc previousField*(ih: PIhandle): PIhandle {.cdecl, importc: "IupPreviousField", dynlib: libiup.}
proc nextField*(ih: PIhandle): PIhandle {.cdecl, importc: "IupNextField", dynlib: libiup.}
proc getCallback*(ih: PIhandle; name: cstring): Icallback {.cdecl, importc: "IupGetCallback", dynlib: libiup.}
proc setCallback*(ih: PIhandle; name: cstring; `func`: Icallback): Icallback {.cdecl, importc: "IupSetCallback", dynlib: libiup.}
proc setCallbacks*(ih: PIhandle; name: cstring; `func`: Icallback): PIhandle {.varargs, cdecl, importc: "IupSetCallbacks", dynlib: libiup.}
proc getFunction*(name: cstring): Icallback {.cdecl, importc: "IupGetFunction", dynlib: libiup.}
proc setFunction*(name: cstring; `func`: Icallback): Icallback {.cdecl, importc: "IupSetFunction", dynlib: libiup.}
proc getHandle*(name: cstring): PIhandle {.cdecl, importc: "IupGetHandle", dynlib: libiup.}
proc setHandle*(name: cstring; ih: PIhandle): PIhandle {.cdecl, importc: "IupSetHandle", dynlib: libiup.}
proc getAllNames*(names: cstringArray; n: cint): cint {.cdecl, importc: "IupGetAllNames", dynlib: libiup.}
proc getAllDialogs*(names: cstringArray; n: cint): cint {.cdecl, importc: "IupGetAllDialogs", dynlib: libiup.}
proc getName*(ih: PIhandle): cstring {.cdecl, importc: "IupGetName", dynlib: libiup.}
proc setAttributeHandle*(ih: PIhandle; name: cstring; ihNamed: PIhandle) {.cdecl, importc: "IupSetAttributeHandle", dynlib: libiup.}
proc getAttributeHandle*(ih: PIhandle; name: cstring): PIhandle {.cdecl, importc: "IupGetAttributeHandle", dynlib: libiup.}
proc setAttributeHandleId*(ih: PIhandle; name: cstring; id: cint; ihNamed: PIhandle) {.cdecl, importc: "IupSetAttributeHandleId", dynlib: libiup.}
proc getAttributeHandleId*(ih: PIhandle; name: cstring; id: cint): PIhandle {.cdecl, importc: "IupGetAttributeHandleId", dynlib: libiup.}
proc SetAttributeHandleId2*(ih: PIhandle; name: cstring; lin: cint; col: cint; ihNamed: PIhandle) {.cdecl, importc: "IupSetAttributeHandleId2", dynlib: libiup.}
proc getAttributeHandleId2*(ih: PIhandle; name: cstring; lin: cint; col: cint): PIhandle {.cdecl, importc: "IupGetAttributeHandleId2", dynlib: libiup.}
proc getClassName*(ih: PIhandle): cstring {.cdecl, importc: "IupGetClassName", dynlib: libiup.}
proc getClassType*(ih: PIhandle): cstring {.cdecl, importc: "IupGetClassType", dynlib: libiup.}
proc getAllClasses*(names: cstringArray; n: cint): cint {.cdecl, importc: "IupGetAllClasses", dynlib: libiup.}
proc getClassAttributes*(classname: cstring; names: cstringArray; n: cint): cint {.cdecl, importc: "IupGetClassAttributes", dynlib: libiup.}
proc getClassCallbacks*(classname: cstring; names: cstringArray; n: cint): cint {.cdecl, importc: "IupGetClassCallbacks", dynlib: libiup.}
proc saveClassAttributes*(ih: PIhandle) {.cdecl, importc: "IupSaveClassAttributes", dynlib: libiup.}
proc copyClassAttributes*(srcIh: PIhandle; dstIh: PIhandle) {.cdecl, importc: "IupCopyClassAttributes", dynlib: libiup.}
proc setClassDefaultAttribute*(classname: cstring; name: cstring; value: cstring) {.cdecl, importc: "IupSetClassDefaultAttribute", dynlib: libiup.}
proc classMatch*(ih: PIhandle; classname: cstring): cint {.cdecl, importc: "IupClassMatch", dynlib: libiup.}
proc create*(classname: cstring): PIhandle {.cdecl, importc: "IupCreate", dynlib: libiup.}
proc createv*(classname: cstring; params: ptr pointer): PIhandle {.cdecl, importc: "IupCreatev", dynlib: libiup.}
proc createp*(classname: cstring; first: pointer): PIhandle {.varargs, cdecl, importc: "IupCreatep", dynlib: libiup.}

# **********************************************************************
#                         Elements
# **********************************************************************

proc fill*(): PIhandle {.cdecl, importc: "IupFill", dynlib: libiup.}
proc space*(): PIhandle {.cdecl, importc: "IupSpace", dynlib: libiup.}
proc radio*(child: PIhandle): PIhandle {.cdecl, importc: "IupRadio", dynlib: libiup.}
proc vbox*(child: PIhandle): PIhandle {.varargs, cdecl, importc: "IupVbox", dynlib: libiup.}
proc vboxv*(children: ptr PIhandle): PIhandle {.cdecl, importc: "IupVboxv", dynlib: libiup.}
proc zbox*(child: PIhandle): PIhandle {.varargs, cdecl, importc: "IupZbox", dynlib: libiup.}
proc zboxv*(children: ptr PIhandle): PIhandle {.cdecl, importc: "IupZboxv", dynlib: libiup.}
proc hbox*(child: PIhandle): PIhandle {.varargs, cdecl, importc: "IupHbox", dynlib: libiup.}
proc hboxv*(children: ptr PIhandle): PIhandle {.cdecl, importc: "IupHboxv", dynlib: libiup.}
proc normalizer*(ihFirst: PIhandle): PIhandle {.varargs, cdecl, importc: "IupNormalizer", dynlib: libiup.}
proc normalizerv*(ihList: ptr PIhandle): PIhandle {.cdecl, importc: "IupNormalizerv", dynlib: libiup.}
proc cbox*(child: PIhandle): PIhandle {.varargs, cdecl, importc: "IupCbox", dynlib: libiup.}
proc cboxv*(children: ptr PIhandle): PIhandle {.cdecl, importc: "IupCboxv", dynlib: libiup.}
proc sbox*(child: PIhandle): PIhandle {.cdecl, importc: "IupSbox", dynlib: libiup.}
proc split*(child1: PIhandle; child2: PIhandle): PIhandle {.cdecl, importc: "IupSplit", dynlib: libiup.}
proc scrollBox*(child: PIhandle): PIhandle {.cdecl, importc: "IupScrollBox", dynlib: libiup.}
proc flatScrollBox*(child: PIhandle): PIhandle {.cdecl, importc: "IupFlatScrollBox", dynlib: libiup.}
proc gridBox*(child: PIhandle): PIhandle {.varargs, cdecl, importc: "IupGridBox", dynlib: libiup.}
proc gridBoxv*(children: ptr PIhandle): PIhandle {.cdecl, importc: "IupGridBoxv", dynlib: libiup.}
proc expander*(child: PIhandle): PIhandle {.cdecl, importc: "IupExpander", dynlib: libiup.}
proc detachBox*(child: PIhandle): PIhandle {.cdecl, importc: "IupDetachBox", dynlib: libiup.}
proc backgroundBox*(child: PIhandle): PIhandle {.cdecl, importc: "IupBackgroundBox", dynlib: libiup.}
proc frame*(child: PIhandle): PIhandle {.cdecl, importc: "IupFrame", dynlib: libiup.}
proc flatFrame*(child: PIhandle): PIhandle {.cdecl, importc: "IupFlatFrame", dynlib: libiup.}
proc image*(width: cint; height: cint; pixmap: ptr cuchar): PIhandle {.cdecl, importc: "IupImage", dynlib: libiup.}
proc imageRGB*(width: cint; height: cint; pixmap: ptr cuchar): PIhandle {.cdecl, importc: "IupImageRGB", dynlib: libiup.}
proc imageRGBA*(width: cint; height: cint; pixmap: ptr cuchar): PIhandle {.cdecl, importc: "IupImageRGBA", dynlib: libiup.}
proc item*(title: cstring; action: cstring): PIhandle {.cdecl, importc: "IupItem", dynlib: libiup.}
proc submenu*(title: cstring; child: PIhandle): PIhandle {.cdecl, importc: "IupSubmenu", dynlib: libiup.}
proc separator*(): PIhandle {.cdecl, importc: "IupSeparator", dynlib: libiup.}
proc menu*(child: PIhandle): PIhandle {.varargs, cdecl, importc: "IupMenu", dynlib: libiup.}
proc menuv*(children: ptr PIhandle): PIhandle {.cdecl, importc: "IupMenuv", dynlib: libiup.}
proc button*(title: cstring; action: cstring): PIhandle {.cdecl, importc: "IupButton", dynlib: libiup.}
proc flatButton*(title: cstring): PIhandle {.cdecl, importc: "IupFlatButton", dynlib: libiup.}
proc flatToggle*(title: cstring): PIhandle {.cdecl, importc: "IupFlatToggle", dynlib: libiup.}
proc dropButton*(dropchild: PIhandle): PIhandle {.cdecl, importc: "IupDropButton", dynlib: libiup.}
proc flatLabel*(title: cstring): PIhandle {.cdecl, importc: "IupFlatLabel", dynlib: libiup.}
proc flatSeparator*(): PIhandle {.cdecl, importc: "IupFlatSeparator", dynlib: libiup.}
proc canvas*(action: cstring): PIhandle {.cdecl, importc: "IupCanvas", dynlib: libiup.}
proc dialog*(child: PIhandle): PIhandle {.cdecl, importc: "IupDialog", dynlib: libiup.}
proc user*(): PIhandle {.cdecl, importc: "IupUser", dynlib: libiup.}
proc label*(title: cstring): PIhandle {.cdecl, importc: "IupLabel", dynlib: libiup.}
proc list*(action: cstring): PIhandle {.cdecl, importc: "IupList", dynlib: libiup.}
proc text*(action: cstring): PIhandle {.cdecl, importc: "IupText", dynlib: libiup.}
proc multiLine*(action: cstring): PIhandle {.cdecl, importc: "IupMultiLine", dynlib: libiup.}
proc toggle*(title: cstring; action: cstring): PIhandle {.cdecl, importc: "IupToggle", dynlib: libiup.}
proc timer*(): PIhandle {.cdecl, importc: "IupTimer", dynlib: libiup.}
proc clipboard*(): PIhandle {.cdecl, importc: "IupClipboard", dynlib: libiup.}
proc progressBar*(): PIhandle {.cdecl, importc: "IupProgressBar", dynlib: libiup.}
proc val*(ttype: cstring): PIhandle {.cdecl, importc: "IupVal", dynlib: libiup.}
proc tabs*(child: PIhandle): PIhandle {.varargs, cdecl, importc: "IupTabs", dynlib: libiup.}
proc tabsv*(children: ptr PIhandle): PIhandle {.cdecl, importc: "IupTabsv", dynlib: libiup.}
proc flatTabs*(first: PIhandle): PIhandle {.varargs, cdecl, importc: "IupFlatTabs", dynlib: libiup.}
proc flatTabsv*(children: ptr PIhandle): PIhandle {.cdecl, importc: "IupFlatTabsv", dynlib: libiup.}
proc tree*(): PIhandle {.cdecl, importc: "IupTree", dynlib: libiup.}
proc link*(url: cstring; title: cstring): PIhandle {.cdecl, importc: "IupLink", dynlib: libiup.}
proc animatedLabel*(animation: PIhandle): PIhandle {.cdecl, importc: "IupAnimatedLabel", dynlib: libiup.}
proc datePick*(): PIhandle {.cdecl, importc: "IupDatePick", dynlib: libiup.}
proc calendar*(): PIhandle {.cdecl, importc: "IupCalendar", dynlib: libiup.}
proc colorbar*(): PIhandle {.cdecl, importc: "IupColorbar", dynlib: libiup.}
proc gauge*(): PIhandle {.cdecl, importc: "IupGauge", dynlib: libiup.}
proc dial*(ttype: cstring): PIhandle {.cdecl, importc: "IupDial", dynlib: libiup.}
proc colorBrowser*(): PIhandle {.cdecl, importc: "IupColorBrowser", dynlib: libiup.}

#  Old controls, use SPIN attribute of IupText

proc spin*(): PIhandle {.cdecl, importc: "IupSpin", dynlib: libiup.}
proc spinbox*(child: PIhandle): PIhandle {.cdecl, importc: "IupSpinbox", dynlib: libiup.}

# **********************************************************************
#                       Utilities
# **********************************************************************
#  String compare utility

proc stringCompare*(str1: cstring; str2: cstring; casesensitive: cint; lexicographic: cint): cint {.cdecl, importc: "IupStringCompare", dynlib: libiup.}

#  IupImage utility

proc saveImageAsText*(ih: PIhandle; fileName: cstring; format: cstring; name: cstring): cint {.cdecl, importc: "IupSaveImageAsText", dynlib: libiup.}

#  IupText and IupScintilla utilities

proc textConvertLinColToPos*(ih: PIhandle; lin: cint; col: cint; pos: ptr cint) {.cdecl, importc: "IupTextConvertLinColToPos", dynlib: libiup.}
proc textConvertPosToLinCol*(ih: PIhandle; pos: cint; lin: ptr cint; col: ptr cint) {.cdecl, importc: "IupTextConvertPosToLinCol", dynlib: libiup.}

#  IupText, IupList, IupTree, IupMatrix and IupScintilla utility

proc convertXYToPos*(ih: PIhandle; x: cint; y: cint): cint {.cdecl, importc: "IupConvertXYToPos", dynlib: libiup.}

#  OLD names, kept for backward compatibility, will never be removed.

proc storeGlobal*(name: cstring; value: cstring) {.cdecl, importc: "IupStoreGlobal", dynlib: libiup.}
proc storeAttribute*(ih: PIhandle; name: cstring; value: cstring) {.cdecl, importc: "IupStoreAttribute", dynlib: libiup.}
proc setfAttribute*(ih: PIhandle; name: cstring; format: cstring) {.varargs, cdecl, importc: "IupSetfAttribute", dynlib: libiup.}
proc storeAttributeId*(ih: PIhandle; name: cstring; id: cint; value: cstring) {.cdecl, importc: "IupStoreAttributeId", dynlib: libiup.}
proc setfAttributeId*(ih: PIhandle; name: cstring; id: cint; f: cstring) {.varargs, cdecl, importc: "IupSetfAttributeId", dynlib: libiup.}
proc storeAttributeId2*(ih: PIhandle; name: cstring; lin: cint; col: cint; value: cstring) {.cdecl, importc: "IupStoreAttributeId2", dynlib: libiup.}
proc setfAttributeId2*(ih: PIhandle; name: cstring; lin: cint; col: cint; format: cstring) {.varargs, cdecl, importc: "IupSetfAttributeId2", dynlib: libiup.}

#  IupTree utilities

proc treeSetUserId*(ih: PIhandle; id: cint; userid: pointer): cint {.cdecl, importc: "IupTreeSetUserId", dynlib: libiup.}
proc treeGetUserId*(ih: PIhandle; id: cint): pointer {.cdecl, importc: "IupTreeGetUserId", dynlib: libiup.}
proc treeGetId*(ih: PIhandle; userid: pointer): cint {.cdecl, importc: "IupTreeGetId", dynlib: libiup.}

#  deprecated, use IupSetAttributeHandleId

proc treeSetAttributeHandle*(ih: PIhandle; name: cstring; id: cint; ihNamed: PIhandle) {.cdecl, importc: "IupTreeSetAttributeHandle", dynlib: libiup.}


# **********************************************************************
#                       Pre-defined dialogs
# **********************************************************************

proc fileDlg*(): PIhandle {.cdecl, importc: "IupFileDlg", dynlib: libiup.}
proc messageDlg*(): PIhandle {.cdecl, importc: "IupMessageDlg", dynlib: libiup.}
proc colorDlg*(): PIhandle {.cdecl, importc: "IupColorDlg", dynlib: libiup.}
proc fontDlg*(): PIhandle {.cdecl, importc: "IupFontDlg", dynlib: libiup.}
proc progressDlg*(): PIhandle {.cdecl, importc: "IupProgressDlg", dynlib: libiup.}
proc getFile*(arq: cstring): cint {.cdecl, importc: "IupGetFile", dynlib: libiup.}
proc message*(title: cstring; msg: cstring) {.cdecl, importc: "IupMessage", dynlib: libiup.}
proc messagef*(title: cstring; format: cstring) {.varargs, cdecl, importc: "IupMessagef", dynlib: libiup.}
proc messageError*(parent: PIhandle; message: cstring) {.cdecl, importc: "IupMessageError", dynlib: libiup.}
proc messageAlarm*(parent: PIhandle; title: cstring; message: cstring; buttons: cstring): cint {.cdecl, importc: "IupMessageAlarm", dynlib: libiup.}
proc alarm*(title: cstring; msg: cstring; b1: cstring; b2: cstring; b3: cstring): cint {.cdecl, importc: "IupAlarm", dynlib: libiup.}
proc scanf*(format: cstring): cint {.varargs, cdecl, importc: "IupScanf", dynlib: libiup.}
proc listDialog*(ttype: cint; title: cstring; size: cint; list: cstringArray; op: cint; maxCol: cint; maxLin: cint; marks: ptr cint): cint {.cdecl, importc: "IupListDialog", dynlib: libiup.}
proc getText*(title: cstring; text: cstring; maxsize: cint): cint {.cdecl, importc: "IupGetText", dynlib: libiup.}
proc getColor*(x: cint; y: cint; r: ptr cuchar; g: ptr cuchar; b: ptr cuchar): cint {.cdecl, importc: "IupGetColor", dynlib: libiup.}

type
  Iparamcb* = proc (dialog: PIhandle; paramIndex: cint; userData: pointer): cint {.cdecl.}

proc getParam*(title: cstring; action: Iparamcb; userData: pointer; format: cstring): cint {.varargs, cdecl, importc: "IupGetParam", dynlib: libiup.}
proc getParamv*(title: cstring; action: Iparamcb; userData: pointer; format: cstring; paramCount: cint; paramExtra: cint; paramData: ptr pointer): cint {.cdecl, importc: "IupGetParamv", dynlib: libiup.}
proc param*(format: cstring): PIhandle {.cdecl, importc: "IupParam", dynlib: libiup.}
proc paramBox*(param: PIhandle): PIhandle {.varargs, cdecl, importc: "IupParamBox", dynlib: libiup.}
proc paramBoxv*(paramArray: ptr PIhandle): PIhandle {.cdecl, importc: "IupParamBoxv", dynlib: libiup.}
proc layoutDialog*(dialog: PIhandle): PIhandle {.cdecl, importc: "IupLayoutDialog", dynlib: libiup.}
proc elementPropertiesDialog*(elem: PIhandle): PIhandle {.cdecl, importc: "IupElementPropertiesDialog", dynlib: libiup.}

# **********************************************************************
#                    Common Flags and Return Values
# **********************************************************************

const
  IUP_ERROR* = cint(1)
  IUP_NOERROR* = cint(0)
  IUP_OPENED* = cint(-1)
  IUP_INVALID* = cint(-1)
  IUP_INVALID_ID* = cint(-10)

# **********************************************************************
#                    Callback Return Values
# **********************************************************************

const
  IUP_IGNORE* = cint(-1)
  IUP_DEFAULT* = cint(-2)
  IUP_CLOSE* = cint(-3)
  IUP_CONTINUE* = cint(-4)

# **********************************************************************
#            IupPopup and IupShowXY Parameter Values
# **********************************************************************

const
  IUP_CENTER* = cint(0x0000FFFF)
  IUP_LEFT* = cint(0x0000FFFE)
  IUP_RIGHT* = cint(0x0000FFFD)
  IUP_MOUSEPOS* = cint(0x0000FFFC)
  IUP_CURRENT* = cint(0x0000FFFB)
  IUP_CENTERPARENT* = cint(0x0000FFFA)
  IUP_TOP* = IUP_LEFT
  IUP_BOTTOM* = IUP_RIGHT

# **********************************************************************
#                SHOW_CB Callback Values
# **********************************************************************

const
  IUP_SHOW* = cint(0)
  IUP_RESTORE* = cint(1)
  IUP_MINIMIZE* = cint(2)
  IUP_MAXIMIZE* = cint(3)
  IUP_HIDE* = cint(4)

# **********************************************************************
#                SCROLL_CB Callback Values
# **********************************************************************

const
  IUP_SBUP* = cint(0)
  IUP_SBDN* = cint(1)
  IUP_SBPGUP* = cint(2)
  IUP_SBPGDN* = cint(3)
  IUP_SBPOSV* = cint(4)
  IUP_SBDRAGV* = cint(5)
  IUP_SBLEFT* = cint(6)
  IUP_SBRIGHT* = cint(7)
  IUP_SBPGLEFT* = cint(8)
  IUP_SBPGRIGHT* = cint(9)
  IUP_SBPOSH* = cint(10)
  IUP_SBDRAGH* = cint(11)

# **********************************************************************
#                Mouse Button Values and Macros
# **********************************************************************

const
  IUP_BUTTON1* = cint(ord('1'))
  IUP_BUTTON2* = cint(ord('2'))
  IUP_BUTTON3* = cint(ord('3'))
  IUP_BUTTON4* = cint(ord('4'))
  IUP_BUTTON5* = cint(ord('5'))

template isShift*(s: cstring): bool =
  return (s[0] == 'S')

template isControl*(s: cstring): bool =
  return (s[1] == 'C')

template isButton1*(s: cstring): bool =
  return (s[2] == '1')

template isButton2*(s: cstring): bool =
  return (s[3] == '2')

template isButton3*(s: cstring): bool =
  return (s[4] == '3')

template isDouble*(s: cstring): bool =
  return (s[5] == 'D')

template isAlt*(s: cstring): bool =
  return (s[6] == 'A')

template isSys*(s: cstring): bool =
  return (s[7] == 'Y')

template isButton4*(s: cstring): bool =
  return (s[8] == '4')

template isButton5*(s: cstring): bool =
  return (s[9] == '5')

# **********************************************************************
#                       Pre-Defined Masks
# **********************************************************************

const
  IUP_MASK_FLOAT* = "[+/-]?(/d+/.?/d*|/./d+)"
  IUP_MASK_UFLOAT* = "(/d+/.?/d*|/./d+)"
  IUP_MASK_EFLOAT* = "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"
  IUP_MASK_UEFLOAT* = "(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"
  IUP_MASK_FLOATCOMMA* = "[+/-]?(/d+/,?/d*|/,/d+)"
  IUP_MASK_UFLOATCOMMA* = "(/d+/,?/d*|/,/d+)"
  IUP_MASK_INT* = "[+/-]?/d+"
  IUP_MASK_UINT* = "/d+"


# **********************************************************************
#                    IupGetParam Callback situations
# **********************************************************************

const
  IUP_GETPARAM_BUTTON1* = cint(-1)
  IUP_GETPARAM_INIT* = cint(-2)
  IUP_GETPARAM_BUTTON2* = cint(-3)
  IUP_GETPARAM_BUTTON3* = cint(-4)
  IUP_GETPARAM_CLOSE* = cint(-5)
  IUP_GETPARAM_MAP* = cint(-6)
  IUP_GETPARAM_OK* = IUP_GETPARAM_BUTTON1
  IUP_GETPARAM_CANCEL* = IUP_GETPARAM_BUTTON2
  IUP_GETPARAM_HELP* = IUP_GETPARAM_BUTTON3

# **********************************************************************
#                    Used by IupColorbar
# **********************************************************************

const
  IUP_PRIMARY* = cint(-1)
  IUP_SECONDARY* = cint(-2)

# **********************************************************************
#                    Record Input Modes
# **********************************************************************

const
  IUP_RECBINARY* = cint(0)
  IUP_RECTEXT* = cint(1)
