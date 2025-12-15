import QtQuick 2.9

import "." as NoxCoinComponents
import "effects/" as NoxCoinEffects

Rectangle {
    color: NoxCoinComponents.Style.appWindowBorderColor
    height: 1

    NoxCoinEffects.ColorTransition {
        targetObj: parent
        blackColor: NoxCoinComponents.Style._b_appWindowBorderColor
        whiteColor: NoxCoinComponents.Style._w_appWindowBorderColor
    }
}
