import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.common.widgets

DashboardCard {
    id: root

    property string controlKey: ""
    property string title: ""
    property string icon: "toggle_on"
    property var tileShape: MaterialShape.Shape.Cookie6Sided

    property var override: null
    readonly property var control: override ?? SettingsQuickControls.controls[controlKey] ?? null
    readonly property bool checked: control ? !!control.get() : false

    tint: checked ? Appearance.colors.colPrimaryContainer : Appearance.colors.colLayer1

    Behavior on tint {
        ColorAnimation { duration: 200 }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 0

        RowLayout {
            Layout.fillWidth: true

            MaterialShapeWrappedMaterialSymbol {
                shape: root.tileShape
                text: root.icon
                iconSize: 24
                fill: 1
                padding: 10
                color: root.checked ? Appearance.colors.colPrimary : Appearance.colors.colSecondaryContainer
                colSymbol: root.checked ? Appearance.colors.colOnPrimary : Appearance.colors.colOnSecondaryContainer
            }

            Item { Layout.fillWidth: true }

            StyledSwitch {
                checked: root.checked
                enabled: false
                scale: 0.9
            }
        }

        Item { Layout.fillHeight: true }

        StyledText {
            Layout.fillWidth: true
            text: root.title
            font.pixelSize: Appearance.font.pixelSize.larger
            font.weight: Font.DemiBold
            color: root.checked ? Appearance.colors.colOnPrimaryContainer : Appearance.colors.colOnLayer1
            elide: Text.ElideRight
        }
        StyledText {
            text: root.checked ? Translation.tr("On") : Translation.tr("Off")
            font.pixelSize: Appearance.font.pixelSize.smaller
            color: root.checked ? Appearance.colors.colOnPrimaryContainer : Appearance.colors.colSubtext
            opacity: 0.8
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (!root.control) return;
            const next = !root.checked;
            Qt.callLater(() => root.control.set(next));
        }
    }
}
