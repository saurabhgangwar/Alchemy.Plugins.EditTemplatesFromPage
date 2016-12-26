using Alchemy4Tridion.Plugins.GUI.Configuration;

namespace Alchemy.Plugins.EditTemplatesFromPage.Config
{
    /// <summary>
    /// Represents a Extension Group.
    /// </summary>
    public class EditTemplatesFromPageExtensionGroup : ExtensionGroup
    {
        /// <summary>
        /// Constructor
        /// </summary>
        public EditTemplatesFromPageExtensionGroup()
        {
            // Add the "EditTemplatesFromPageResourceGroup" resource group as Extension to extend the resource "Tridion.Web.UI.Editors.CME.Views.Page"
            AddExtension<EditTemplatesFromPageResourceGroup>("Tridion.Web.UI.Editors.CME.Views.Page");
            
        }
    }
}
