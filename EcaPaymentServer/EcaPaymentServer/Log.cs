using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EcaPaymentServer
{
    public class Log
    {
        /// <summary>
        /// 存放错误日志的路径
        /// </summary>
        private static string errorDir = System.AppDomain.CurrentDomain.BaseDirectory.ToString() + "App_Data\\JW";
        /// <summary>
        /// 捕获错误信息
        /// </summary>
        /// <param name="sql">错误语句</param>
        /// <param name="errorDetails">错误详细信息</param>
        public static void CaptureError(string sql, string errorDetails)
        {
            if (!System.IO.Directory.Exists(errorDir))
            {
                System.IO.Directory.CreateDirectory(errorDir);//构建存放错误日志的路径
            }
            string filePath = errorDir + @"\errorLog.txt";
            if (!System.IO.File.Exists(filePath))
            {
                System.IO.File.Create(filePath).Close();//创建完文件后必须关闭掉流
            }
            System.IO.File.SetAttributes(filePath, System.IO.FileAttributes.Normal);
            System.IO.StreamWriter sr = new System.IO.StreamWriter(filePath, true);
            sr.WriteLine("===============" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "=============");
            sr.WriteLine("执行出错的语句：");
            sr.WriteLine(sql);
            sr.WriteLine("错误的详细信息：");
            sr.WriteLine(errorDetails);
            sr.Close();//关闭写入的流
        }
    }
}
