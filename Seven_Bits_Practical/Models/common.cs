using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Seven_Bits_Practical.Models
{
    public class common
    {
        public static string AgeCalculation(DateTime? DOB)
        {
            TimeSpan ts = DateTime.Now.Subtract(Convert.ToDateTime(DOB));
            DateTime age = DateTime.MinValue + ts;
            return string.Format("{0} Years {1} months", age.Year - 1, age.Month - 1); ;
        }

        public enum Department
        {
            [Description("Support Desk")]
            Support_Desk = 1,
            [Description("Network Administrator")]
            Network_Administrator = 2,
            [Description("Software Developer")]
            Software_Developer = 3,
            [Description("Software Tester")]
            Software_Tester = 4,
            [Description("Security Analyst")]
            Security_Analyst = 5,
            [Description("Database Engineer")]
            Database_Engineer = 6
        }

        public static string GetDescription(string value)
        {
            Type type = typeof(Department);
            var name = Enum.GetNames(type).Where(f => f.Equals(value, StringComparison.CurrentCultureIgnoreCase)).Select(d => d).FirstOrDefault();
            if (name == null)
            {
                return string.Empty;
            }
            var field = type.GetField(name);
            var customAttribute = field.GetCustomAttributes(typeof(DescriptionAttribute), false);
            return customAttribute.Length > 0 ? ((DescriptionAttribute)customAttribute[0]).Description : name;
        }
    }
}