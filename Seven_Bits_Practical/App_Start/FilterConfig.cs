using System.Web;
using System.Web.Mvc;

namespace Seven_Bits_Practical
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
