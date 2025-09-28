import QtQuick 2.9

import "." as noxcoinComponents
import "effects/" as noxcoinEffects

Rectangle {
    color: noxcoinComponents.Style.appWindowBorderColor
    height: 1

    noxcoinEffects.ColorTransition {
        targetObj: parent
        blackColor: noxcoinComponents.Style._b_appWindowBorderColor
        whiteColor: noxcoinComponents.Style._w_appWindowBorderColor
    }
}
