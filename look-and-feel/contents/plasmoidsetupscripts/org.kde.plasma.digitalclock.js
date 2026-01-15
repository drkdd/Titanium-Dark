if (typeof applet !== 'undefined') {
    setupWidget(applet);
} 
else {
  var targetType = "org.kde.plasma.digitalclock"; 
  
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
  applet.currentConfigGroup = ["Appearance"];
  applet.writeConfig("customDateFormat", "ddd d MMM |");
  applet.writeConfig("dateDisplayFormat", "BesideTime");
  applet.writeConfig("dateFormat", "custom");
  applet.writeConfig("showWeekNumbers", true);
  applet.writeConfig("use24hFormat", 2);
  applet.writeConfig("firstDayOfWeek", 0);
}