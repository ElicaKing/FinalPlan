using Microsoft.CSharp;
using System;
using System.CodeDom;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web.Services.Description;

namespace EcaPaymentServer
{
    public class ServerHelper
    {
        /* 调用方式   

        *   string url = "http://www.webservicex.net/globalweather.asmx" ;   

        *   string[] args = new string[2] ;   

        *   args[0] = "Hangzhou";   

        *   args[1] = "China" ;   

        *   object result = WebServiceHelper.InvokeWebService(url ,"GetWeather" ,args) ;   

        *   Response.Write(result.ToString());   

        */



        #region InvokeWebService

        /// < summary>   

        /// 动态调用web服务   

        /// < /summary>   

        /// < param name="url">WSDL服务地址< /param>   

        /// < param name="methodname">方法名< /param>   

        /// < param name="args">参数< /param>   

        /// < returns>< /returns>   

        public static object InvokeWebService(string url, string methodname, object[] args)
        {

            return InvokeWebService(url, null, methodname, args);

        }



        /// < summary>   

        /// 动态调用web服务   

        /// < /summary>   

        /// < param name="url">WSDL服务地址< /param>   

        /// < param name="classname">类名< /param>   

        /// < param name="methodname">方法名< /param>   

        /// < param name="args">参数< /param>   

        /// < returns>< /returns>   

        public static object InvokeWebService(string url, string classname, string methodname, object[] args)
        {

            string @namespace = "EnterpriseServerBase.WebService.DynamicWebCalling";

            if ((classname == null) || (classname == ""))
            {

                classname = GetWsClassName(url);

            }



            try
            {

                //获取WSDL   

                WebClient wc = new WebClient();

                Stream stream = wc.OpenRead(url + "?WSDL");

                ServiceDescription sd = ServiceDescription.Read(stream);

                ServiceDescriptionImporter sdi = new ServiceDescriptionImporter();

                sdi.AddServiceDescription(sd, "", "");

                CodeNamespace cn = new CodeNamespace(@namespace);



                //生成客户端代理类代码   

                CodeCompileUnit ccu = new CodeCompileUnit();

                ccu.Namespaces.Add(cn);

                sdi.Import(cn, ccu);

                CSharpCodeProvider icc = new CSharpCodeProvider();



                //设定编译参数   

                CompilerParameters cplist = new CompilerParameters();

                cplist.GenerateExecutable = false;

                cplist.GenerateInMemory = true;

                cplist.ReferencedAssemblies.Add("System.dll");

                cplist.ReferencedAssemblies.Add("System.XML.dll");

                cplist.ReferencedAssemblies.Add("System.Web.Services.dll");

                cplist.ReferencedAssemblies.Add("System.Data.dll");



                //编译代理类   

                CompilerResults cr = icc.CompileAssemblyFromDom(cplist, ccu);

                if (true == cr.Errors.HasErrors)
                {

                    System.Text.StringBuilder sb = new System.Text.StringBuilder();

                    foreach (System.CodeDom.Compiler.CompilerError ce in cr.Errors)
                    {

                        sb.Append(ce.ToString());

                        sb.Append(System.Environment.NewLine);

                    }

                    throw new Exception(sb.ToString());

                }



                //生成代理实例，并调用方法   

                System.Reflection.Assembly assembly = cr.CompiledAssembly;

                Type t = assembly.GetType(@namespace + "." + classname, true, true);

                object obj = Activator.CreateInstance(t);

                System.Reflection.MethodInfo mi = t.GetMethod(methodname);



                return mi.Invoke(obj, args);



                /*   

                PropertyInfo propertyInfo = type.GetProperty(propertyname);   

                return propertyInfo.GetValue(obj, null);   

                */

            }

            catch (Exception ex)
            {
                Log.CaptureError("", "123456");
                throw new Exception(ex.InnerException.Message, new Exception(ex.InnerException.StackTrace));

            }

        }

        public static object InvokeWebServicea(string url, string methodname, object[] args)
        {
            //这里的namespace是需引用的webservices的命名空间，我没有改过，也可以使用。也可以加一个参数从外面传进来。
            string @namespace = "client";

            try
            {
                //获取WSDL
                WebClient wc = new WebClient();
                Stream stream = wc.OpenRead(url + "?WSDL");
                ServiceDescription sd = ServiceDescription.Read(stream);
                string classname = sd.Services[0].Name;
                ServiceDescriptionImporter sdi = new ServiceDescriptionImporter();
                sdi.AddServiceDescription(sd, "", "");
                CodeNamespace cn = new CodeNamespace(@namespace);

                //生成客户端代理类代码
                CodeCompileUnit ccu = new CodeCompileUnit();
                ccu.Namespaces.Add(cn);
                sdi.Import(cn, ccu);
                CSharpCodeProvider csc = new CSharpCodeProvider();
                //ICodeCompiler icc = csc.CreateCompiler();

                //设定编译参数
                CompilerParameters cplist = new CompilerParameters();
                cplist.GenerateExecutable = false;//动态编译后的程序集不生成可执行文件
                cplist.GenerateInMemory = true;//动态编译后的程序集只存在于内存中，不在硬盘的文件上
                cplist.ReferencedAssemblies.Add("System.dll");
                cplist.ReferencedAssemblies.Add("System.XML.dll");
                cplist.ReferencedAssemblies.Add("System.Web.Services.dll");
                cplist.ReferencedAssemblies.Add("System.Data.dll");

                //编译代理类
                CompilerResults cr = csc.CompileAssemblyFromDom(cplist, ccu);
                if (true == cr.Errors.HasErrors)
                {
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    foreach (System.CodeDom.Compiler.CompilerError ce in cr.Errors)
                    {
                        sb.Append(ce.ToString());
                        sb.Append(System.Environment.NewLine);
                    }

                    throw new Exception(sb.ToString());
                }

                //生成代理实例，并调用方法
                System.Reflection.Assembly assembly = cr.CompiledAssembly;
                Type t = assembly.GetType(@namespace + "." + classname, true, true);
                object obj = Activator.CreateInstance(t);
                System.Reflection.MethodInfo mi = t.GetMethod(methodname);

                //注：method.Invoke(o, null)返回的是一个Object,如果你服务端返回的是DataSet,这里也是用(DataSet)method.Invoke(o, null)转一下就行了,method.Invoke(0,null)这里的null可以传调用方法需要的参数,string[]形式的
                return mi.Invoke(obj, args);
            }
            catch (Exception e)
            {
                Log.CaptureError("", e.Message);
                return null;
            }
        }

        private static string GetWsClassName(string wsUrl)
        {

            string[] parts = wsUrl.Split('/');

            string[] pps = parts[parts.Length - 1].Split('.');



            return pps[0];

        }

        #endregion
    }
}
