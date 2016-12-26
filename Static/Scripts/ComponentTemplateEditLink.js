!(function () {
    try {
        // Get the JQuery object.
        $JQ = Alchemy.library("jQuery");

        function onViewLoaded() {
            try {
                //// Remove the event handler once the function is excuted.
                $evt.removeEventHandler($display, "start", onViewLoaded);
                // Get the component presentations tab element
                var componentsTab = document.getElementById("cpComponentTab");
                // Get the tr element where we need to add the Edit button
                // Get the last td element of the tr and set the colspan 2 to 1, coz we are going to add additional td having the edit button.
                var trElement = componentsTab.querySelector("fieldset > div.hl > table > tBody > tr:nth-child(2)");
                trElement.querySelector("td:nth-child(2)").setAttribute("colspan", "1");

                // Prepare the td element (having edit button inside it) and append it to tr element.
                var editButtonTdElement = document.createElement('td');
                editButtonTdElement.setAttribute("align", "right");
                editButtonTdElement.innerHTML = "<div id=\"AlchemyPluginsEditTemplatesFromPageComponentEditButton\" class=\"editTemplateFromPagePluginButton editButton\" title=\"Edit\" ><span class=\"text\">&nbsp;</span></div>";
                trElement.appendChild(editButtonTdElement);

                // Get the component templates dropdown control object
                var ddl = $controls.getControl($('#listComponentTemplates'), 'Tridion.Controls.Dropdown');
                // On click of the edit button, below code executes
                $JQ("#AlchemyPluginsEditTemplatesFromPageComponentEditButton").click(function () {
                    // Get the tcmid of the selected component template in dropdown
                    var ctId = ddl.getValue();
                    // Execute the open command
                    var s = new Tridion.Cme.Selection();
                    s.addItem(ctId);
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