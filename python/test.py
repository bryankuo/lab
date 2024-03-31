#!/usr/bin/python3

# another way to run python, add to path, execute from calc menu
# @see http://tinyurl.com/48xp8dun
# Where to save macros?
# ~/Library/Application Support/LibreOffice/4/user/Scripts/python/

# reference doc:
# http://christopher5106.github.io/office/2015/12/06/openoffice-libreoffice-automate-your-office-tasks-with-python-macros.html#comment-3688991538
# https://wiki.documentfoundation.org/Macros/Python_Guide/Calc/Calc_sheets

import uno, sys, time, os
from datetime import datetime
from com.sun.star.uno import RuntimeException
# from datetime import date
# test
from com.sun.star.awt import MessageBoxButtons as MSG_BUTTONS

CTX = uno.getComponentContext()
SM = CTX.getServiceManager()


def create_instance(name, with_context=False):
    if with_context:
        instance = SM.createInstanceWithContext(name, CTX)
    else:
        instance = SM.createInstance(name)
    return instance

def call_dispatch(doc, url, args=()):
    frame = doc.getCurrentController().getFrame()
    dispatch = create_instance('com.sun.star.frame.DispatchHelper')
    dispatch.executeDispatch(frame, url, '', 0, args)
    return

'''
def msgbox(message, title='LibreOffice', buttons=MSG_BUTTONS.BUTTONS_OK, type_msg='infobox'):
    """ Create message box
        type_msg: infobox, warningbox, errorbox, querybox, messbox
        https://api.libreoffice.org/docs/idl/ref/interfacecom_1_1sun_1_1star_1_1awt_1_1XMessageBoxFactory.html
    """
    toolkit = create_instance('com.sun.star.awt.Toolkit')
    parent = toolkit.getDesktopWindow()
    mb = toolkit.createMessageBox(parent, type_msg, buttons, title, str(message))
    return mb.execute()


def context():
    # set global variables for context
    global desktop
    global model
    global active_sheet
    # get the doc from the scripting context
    # which is made available to all scripts
    desktop = XSCRIPTCONTEXT.getDesktop()
    model = desktop.getCurrentComponent()
    active_sheet = model.Sheets.getByName("20231211")
'''

# context()
# sheet_name = "外投同買賣及異常."+yyyymmdd
sheet_name = "RS-TWSE"
print(sheet_name)
desktop = XSCRIPTCONTEXT.getDesktop()
print(desktop)
# msgbox
