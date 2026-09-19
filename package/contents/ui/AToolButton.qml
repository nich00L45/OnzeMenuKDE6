import QtQuick 2.0
import QtQuick.Controls
import QtQuick.Layouts 1.1
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami

Rectangle{

    id:item

    implicitHeight: Math.floor( Kirigami.Units.gridUnit * 1.8)
    width: Math.floor(lb.implicitWidth + Kirigami.Units.smallSpacing * 5 + icon.width)


    border.width: 1
    border.color: mouseItem.containsMouse ? theme.highlightColor  : colorWithAlpha(theme.textColor,0.2)
    radius: 2
    color: theme.backgroundColor
    smooth: plasmoid.configuration.iconSmooth


    property alias text: lb.text
    property bool flat: false
    property alias iconName: icon.source
    property bool mirror: false

    signal clicked

    RowLayout{
        id: row
        anchors.fill: parent
        anchors.leftMargin: Kirigami.Units.smallSpacing * 2
        anchors.rightMargin: Kirigami.Units.smallSpacing * 2
        spacing: Kirigami.Units.smallSpacing
        LayoutMirroring.enabled: mirror

        Label{
            id: lb
            color: theme.textColor
        }
        Kirigami.Icon {
            id: icon
            implicitHeight: Kirigami.Units.gridUnit
            implicitWidth: implicitHeight
            smooth: plasmoid.configuration.iconSmooth
        }
    }

    MouseArea {
        id: mouseItem
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: item.clicked()
    }

}
