using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Seven_Bits_Practical.Models;
using static Seven_Bits_Practical.Models.common;

namespace Seven_Bits_Practical.Controllers
{
    public class EmployeeController : Controller
    {
        // GET: Employee
        public ActionResult Index()
        {
            using (DbModel dbModel = new DbModel())
            {
                return View(dbModel.Employees.ToList());
            }

        }

        // GET: Employee/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Employee/Create
        public ActionResult Create()
        {
            //ViewBag.Department = new SelectList(Enum.GetValues(typeof(Department)));
            ViewBag.Department = Enum.GetValues(typeof(Department))
               .Cast<Department>()
               .ToDictionary(t => (int)t, t => common.GetDescription(t.ToString()));
            return View();
        }

        // POST: Employee/Create
        [HttpPost]
        public ActionResult Create(Employee employee)
        {
            try
            {
                // TODO: Add insert logic here
                using (DbModel dbModel = new DbModel())
                {
                    dbModel.Employees.Add(employee);
                    dbModel.SaveChanges();
                }
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Employee/Edit/5
        public ActionResult Edit(int id)
        {
            using (DbModel dbModel = new DbModel())
            {
                return View(dbModel.Employees.Where(x => x.Id == id).FirstOrDefault());
            }
        }

        // POST: Employee/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, Employee employee)
        {
            try
            {
                // TODO: Add update logic here
                using (DbModel dbModel = new DbModel())
                {
                    dbModel.Entry(employee).State = EntityState.Modified;
                    dbModel.SaveChanges();
                }
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Employee/Delete/5
        public ActionResult Delete(int id)
        {
            using (DbModel dbModel = new DbModel())
            {
                return View(dbModel.Employees.Where(x => x.Id == id).FirstOrDefault());
            }
        }

        // POST: Employee/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
                using (DbModel dbModel = new DbModel())
                {
                    List<EmployeeSalary> lstemployeeSalary = dbModel.EmployeeSalaries.Where(x => x.EmpId == id).ToList();
                    if (lstemployeeSalary?.Count > 0)
                    {
                        foreach (var item in lstemployeeSalary)
                        {
                            EmployeeSalary employeeSalary = dbModel.EmployeeSalaries.Where(x => x.Id == item.Id).FirstOrDefault();
                            dbModel.EmployeeSalaries.Remove(employeeSalary);
                            dbModel.SaveChanges();
                        }
                    }
                    Employee employee = dbModel.Employees.Where(x => x.Id == id).FirstOrDefault();
                    dbModel.Employees.Remove(employee);
                    dbModel.SaveChanges();
                }
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult AddSalary(int id)
        {
            ViewBag.EmpId = id;
            return View();
        }

        [HttpPost]
        public ActionResult AddSalary(EmployeeSalary employeeSalary)
        {
            try
            {
                // TODO: Add delete logic here
                using (DbModel dbModel = new DbModel())
                {
                    dbModel.EmployeeSalaries.Add(employeeSalary);
                    dbModel.SaveChanges();
                }
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Search()
        {
            using (DbModel dbModel = new DbModel())
            {
                ViewBag.EmpLlist = dbModel.Employees.ToList();
            }
            return View();

        }
        public ActionResult EmployeeListData(DateTime? Startdate, DateTime? Enddate, int Empid = 0)
        {
            List<EmployeeListByFilter_Result> listByFilters = new List<EmployeeListByFilter_Result>();
            try
            {
                using (DbModel dbModel = new DbModel())
                {
                    ViewBag.EmpLlist = dbModel.Employees.ToList();
                    listByFilters = dbModel.EmployeeListByFilter(Startdate, Enddate, Empid).ToList();
                }
            }
            catch (Exception ex)
            {

            }
            return PartialView("EmployeeListData", listByFilters);
        }
    }
}
