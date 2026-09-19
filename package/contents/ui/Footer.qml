import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.12

import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents

import org.kde.plasma.extras as PlasmaExtras

import org.kde.plasma.private.kicker as Kicker
import org.kde.coreaddons as KCoreAddons // kuser
import org.kde.plasma.private.shell

import org.kde.kwindowsystem
// @TODO replace import QtGraphicalEffects 1.0
import org.kde.kquickcontrolsaddons

import org.kde.plasma.components as PlasmaComponents3
// @TODO replace import org.kde.plasma.private.quicklaunch

import org.kde.kirigami as Kirigami
import org.kde.plasma.plasma5support as Plasma5Support



RowLayout{

    spacing: Kirigami.Units.gridUnit

    KCoreAddons.KUser {   id: kuser  }
    // @TODO Logic {   id: logic }

    Plasma5Support.DataSource {
        id: pmEngine
        engine: "powermanagement"
        connectedSources: ["PowerDevil", "Sleep States"]
        function performOperation(what) {
            var service = serviceForSource("PowerDevil")
            var operation = service.operationDescription(what)
            service.startOperationCall(operation)
        }
    }

    Image {
        id: iconUser
        source: kuser.faceIconUrl.toString() || "user-identity"
        cache: false
        visible: source !== ""
        sourceSize.height: parent.height * 0.9
        sourceSize.width:  parent.height * 0.9
        fillMode: Image.PreserveAspectFit
        Layout.alignment: Qt.AlignVCenter

        // Crop the avatar to fit in a circle, like the lock and login screens
        // but don't on software rendering where this won't render
        layer.enabled:true // iconUser.GraphicsInfo.api !== GraphicsInfo.Software
        // @TODO BELOW
        // layer.effect: OpacityMask {
        //     // this Rectangle is a circle due to radius size
        //     maskSource: Rectangle {
        //         width: iconUser.width
        //         height: iconUser.height
        //         radius: height / 2
        //         visible: false
        //     }
        // }
    }


    Kirigami.Heading {
        wrapMode: Text.NoWrap
        color: theme.textColor
        level: 3
        font.bold: true
        //font.weight: Font.Bold
        text: qsTr(kuser.fullName)
    }

    Item{
        Layout.fillWidth: true
    }

    PlasmaComponents3.ToolButton {
        icon.name:  "user-home"
        onClicked: logic.openUrl("file:///usr/share/applications/org.kde.dolphin.desktop")
        ToolTip.delay: 1000
        ToolTip.timeout: 1000
        ToolTip.visible: hovered
        ToolTip.text: i18n("User Home")
    }

    PlasmaComponents3.ToolButton {
        icon.name:  "configure"
        onClicked: logic.openUrl("file:///usr/share/applications/systemsettings.desktop")
        ToolTip.delay: 1000
        ToolTip.timeout: 1000
        ToolTip.visible: hovered
        ToolTip.text: i18n("System Preferences")
    }

    PlasmaComponents3.ToolButton {
        icon.name:   "system-lock-screen"
        onClicked: pmEngine.performOperation("lockScreen")
        ToolTip.delay: 1000
        ToolTip.timeout: 1000
        ToolTip.visible: hovered
        ToolTip.text: i18n("Lock Screen")
        visible: pmEngine.data["Sleep States"]["LockScreen"]
    }

    PlasmaComponents3.ToolButton {
        icon.name:  "system-shutdown"
        onClicked: pmEngine.performOperation("requestShutDown")
        //Layout.rightMargin: 10
        ToolTip.delay: 1000
        ToolTip.timeout: 1000
        ToolTip.visible: hovered
        ToolTip.text: i18n("Leave ...")
    }
}
