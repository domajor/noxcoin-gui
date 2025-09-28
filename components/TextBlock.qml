import QtQuick 2.9

import "../components" as noxcoinComponents

TextEdit {
    color: noxcoinComponents.Style.defaultFontColor
    font.family: noxcoinComponents.Style.fontRegular.name
    selectionColor: noxcoinComponents.Style.textSelectionColor
    wrapMode: Text.Wrap
    readOnly: true
    selectByMouse: true
    // Workaround for https://bugreports.qt.io/browse/QTBUG-50587
    onFocusChanged: {
        if(focus === false)
            deselect()
    }
}
