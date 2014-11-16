(function() {
  $(document).on("page:update", function() {
    return new UE.ui.Editor({
      initialFrameHeight: 220
    }).render("project_description");
  });

}).call(this);
