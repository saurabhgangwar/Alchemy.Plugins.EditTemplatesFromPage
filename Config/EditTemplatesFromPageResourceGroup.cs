using Alchemy4Tridion.Plugins.GUI.Configuration;
using Alchemy4Tridion.Plugins.GUI.Configuration.Elements;

namespace Alchemy.Plugins.EditTemplatesFromPage.Config
{
    /// <summary>
    /// Represents the ResourceGroup element within the editor configuration that contains this plugin's files
    /// and references.
    /// </summary>
    public class EditTemplatesFromPageResourceGroup : ResourceGroup
    {
        /// <summary>
        /// Constructor
        /// </summary>
        public EditTemplatesFromPageResourceGroup()
        {
            // When adding files you only need to specify the filename and not full path
            AddFile("PageTemplateEditLink.js");
            AddFile("ComponentTemplateEditLink.js");
            AddFile("EditTemplatesFromPage.css");
            // Adding Web API Proxy
            AddWebApiProxy();
            // Adding the JQuery dependancy
            Dependencies.AddLibraryJQuery();
            

        }
    }
}
