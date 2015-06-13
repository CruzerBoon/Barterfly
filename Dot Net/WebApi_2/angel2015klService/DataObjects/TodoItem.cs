using Microsoft.WindowsAzure.Mobile.Service;

namespace angel2015klService.DataObjects
{
    public class TodoItem : EntityData
    {
        public string Text { get; set; }

        public bool Complete { get; set; }
    }
}