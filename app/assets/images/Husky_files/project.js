(function() {
  $(document).on("page:update", function() {
    return new UE.ui.Editor({
      initialFrameHeight: 220
    }).render("project_content");
  });

}).call(this);
