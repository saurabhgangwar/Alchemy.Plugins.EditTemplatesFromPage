!(function () {
    try {
        // Get the JQuery object.
        $JQ = Alchemy.library("jQuery");

        // Event handler function when view is loaded.
        function onViewLoaded() {
            try {

                // Remove the event handler once the function is excuted.
                $evt.removeEventHandler($display, "start", onViewLoaded);
                // Get the page object
                var page = $display.getItem();
                // Insert the Edit button  besides the page template dropdown
                $JQ("<div id='AlchemyPluginsEditTemplatesFromPagePageEditButton' class='editTemplateFromPagePluginButton editButton pageTemplate' title='Edit'><span class='text'>&nbsp;</span></div>").insertAfter('#PageTemplate')
                // Function to be execte on the Edit Button click
                $JQ("#AlchemyPluginsEditTemplatesFromPagePageEditButton").click(function () {
                    // Execute the open command
                    var pageTemplateId = page.getPageTemplateId();
                    var s = new Tridion.Cme.Selection();
                    s.addItem(pageTemplateId);
                    $commands.executeCommand("Open", s);
                });

            }
            catch (error) {
                $messages.registerError("Alchemy Plugin Error | EditTemplatesFromPage: ", error);
            }
        }

        // Add a event handler when Dashboard display is started.
        $evt.addEventHandler($display, "start", onViewLoaded);
    }
    catch (error) {
        $messages.registerError("Alchemy Plugin Error | EditTemplatesFromPage: ", error);
    }

})();