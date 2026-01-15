if (typeof applet !== 'undefined') {
    setupWidget(applet);
} 
else {
  var targetType = "org.kde.plasma.windowbuttons"; 
  
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
  applet.writeConfig("buttonSizePercentage", 67);
  applet.writeConfig("buttons", "3|4|5|10|2|9");
  applet.writeConfig("selectedTheme", "__aurorae__svg__Utterly-Round-Dark");
  applet.writeConfig("spacing", 9);
  
  var homePath = "/home/" + userDataPath().split('/')[2]; 
  var fullSchemePath = homePath + "/.local/share/color-schemes/TitaniumDark.colors";
  
  applet.writeConfig("selectedScheme", fullSchemePath);
}