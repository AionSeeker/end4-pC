import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Layouts
import qs.modules.common.functions

RippleButton {
    id: root
    property real innerInset: 0
    property real outerInset: 0
    property bool magnifiable: false
    property int magnifyId: -1
    readonly property var magnifyValue: root.magnifyId >= 0 ? (DockMagnify.values[root.magnifyId] ?? null) : null
    readonly property bool magnifyActive: DockStyle.magnifying && root.magnifiable
    readonly property real naturalWidth: DockStyle.vertical
        ? implicitBackgroundWidth + leftInset + rightInset
        : implicitHeight - topInset - bottomInset

    Layout.fillHeight: !DockStyle.vertical
    Layout.fillWidth: DockStyle.vertical
    Layout.topMargin: DockStyle.mTop(DockStyle.buttonInnerMargin, 0)
    Layout.leftMargin: DockStyle.mLeft(DockStyle.buttonInnerMargin, 0)
    topInset: DockStyle.mTop(innerInset, outerInset)
    bottomInset: DockStyle.mBottom(innerInset, outerInset)
    leftInset: DockStyle.mLeft(innerInset, outerInset)
    rightInset: DockStyle.mRight(innerInset, outerInset)
    implicitWidth: naturalWidth
    buttonRadius: Appearance.rounding.normal

    transformOrigin: Item.Bottom
    scale: root.magnifyActive && root.magnifyValue ? root.magnifyValue.scale : 1
    z: root.magnifyActive && root.magnifyValue ? root.magnifyValue.scale : 0
    transform: Translate { x: root.magnifyActive && root.magnifyValue ? root.magnifyValue.shift : 0 }

    colBackground: DockStyle.macos ? "transparent" : ColorUtils.transparentize(Appearance?.colors.colLayer1Hover, 1) || "transparent"
    colBackgroundHover: DockStyle.macos ? "transparent" : Appearance?.colors.colLayer1Hover
    colRipple: DockStyle.macos ? "transparent" : Appearance?.colors.colLayer1Active

    Component.onCompleted: if (root.magnifiable) root.magnifyId = DockMagnify.register(root)
    Component.onDestruction: DockMagnify.unregister(root.magnifyId)

    background.implicitHeight: DockStyle.buttonBase
    background.implicitWidth: DockStyle.buttonBase
}
