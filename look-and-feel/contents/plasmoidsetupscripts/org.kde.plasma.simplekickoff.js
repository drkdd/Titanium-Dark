if (typeof applet !== 'undefined') {
    setupWidget(applet);
} 
else {
  var targetType = "org.kde.plasma.simplekickoff"; 
  
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
  var config = applet.currentConfigGroup = ["General"];
  applet.writeConfig("icon", "fedora-logo-icon");
  applet.writeConfig("alphaSort", true);
  
  applet.currentConfigGroup = ["Shortcuts"];
  applet.writeConfig("global", "Alt+F1");
}