var panel = new Panel
var panelScreen = panel.screen

panel.location = "top"
panel.hiding = "autohide"
panel.height = 2 * Math.floor(gridUnit * 34 / 18)
panel.lengthMode = "fill"
panel.alignment = "center"
panel.opacity = "translucent"
panel.floating = false
panel.offset = 0

var launcher = panel.addWidget("org.kde.plasma.simplekickoff")
launcher.currentConfigGroup = new Array("Shortcuts");
launcher.writeConfig("global","Alt+F1");

panel.addWidget("org.kde.plasma.marginsseparator")
panel.addWidget("org.kde.plasma.marginsseparator")
panel.addWidget("org.kde.windowtitle")
panel.addWidget("org.kde.plasma.marginsseparator")
panel.addWidget("org.kde.plasma.panelspacer")
panel.addWidget("org.kde.plasma.marginsseparator")
panel.addWidget("org.kde.plasma.digitalclock")
panel.addWidget("org.kde.plasma.marginsseparator")
panel.addWidget("org.kde.plasma.panelspacer")
panel.addWidget("org.kde.netspeedWidget")
panel.addWidget("org.kde.plasma.systemtray")
panel.addWidget("org.kde.windowbuttons")

var dock = new Panel

dock.location = "bottom"
dock.hiding = "autohide"
dock.height = 2 * Math.floor(gridUnit * 50 / 18)
dock.lengthMode = "fit"
dock.alignment = "center"
dock.opacity = "translucent"
dock.floating = true
dock.offset = 0

dock.addWidget("com.himdek.kde.plasma.overview")
dock.addWidget("zayron.simple.separator")
dock.addWidget("org.kde.plasma.icontasks")

var desktopsArray = desktopsForActivity(currentActivity());
for( var j = 0; j < desktopsArray.length; j++) {
    desktopsArray[j].wallpaperPlugin = 'org.kde.image';
}
