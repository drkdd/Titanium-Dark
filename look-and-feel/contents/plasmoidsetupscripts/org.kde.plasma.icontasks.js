if (typeof applet !== 'undefined') {
    setupWidget(applet);
} 
else {
  var targetType = "org.kde.plasma.icontasks"; 
  
      // 1. Masaüstlerindeki widget'ları tara
      var allDesktops = desktops();
      for (var i in allDesktops) {
          var dsktpWidgets = allDesktops[i].widgets();
          for (var j in dsktpWidgets) {
              if (dsktpWidgets[j].type === targetType) {
                  setupWidget(dsktpWidgets[j]);
              }
          }
      }
  
      // 2. Panellerdeki widget'ları tara
      var allPanels = panels();
      for (var k in allPanels) {
          var pnlWidgets = allPanels[k].widgets();
          for (var l in pnlWidgets) {
              if (pnlWidgets[l].type === targetType) {
                  setupWidget(pnlWidgets[l]);
              }
          }
      }
}

function setupWidget(applet) {
  applet.currentConfigGroup = ["General"];
  applet.writeConfig("launchers", "preferred://filemanager,applications:systemsettings.desktop,applications:org.kde.konsole.desktop,applications:app.zen_browser.zen.desktop,applications:dev.zed.Zed.desktop,applications:spotify_spotify.desktop");
  applet.writeConfig("showOnlyCurrentScreen", true);
  applet.writeConfig("showOnlyCurrentDesktop", true);
  applet.writeConfig("showOnlyCurrentActivity", true);
  applet.writeConfig("groupedTaskVisualization", 2);
}