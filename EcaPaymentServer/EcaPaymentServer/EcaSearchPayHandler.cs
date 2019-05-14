using Eca.Contract;
using EcaServerCore;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using System.Collections;
using System.Runtime.Serialization.Formatters.Binary;
using System.Net;


namespace EcaPaymentServer
{
    public class EcaSearchPayHandler : HandlerBase
    {
        //获取接口权限
        public override bool IsNeedAuthorize { get { return false; } }

        #region 2019-04-01 执收单位查询统一公共支付平台缴款结果信息
        public void GetPay_Info(HttpContext context)
        {
            JsonData webResult = new JsonData();
            string NOTICENO = context.Request["noticeNo"] ?? "";
            string CHANNELNO = context.Request["channelNo"] ?? "";
            string ORIGINALNOTICENO = context.Request["originalnoticeNo"] ?? "";
            string YWCODE = context.Request["ywCode"] ?? "";
            string msg = "";
            Dictionary<string, string> dics = new Dictionary<string, string>();
            dics.Add("NOTICENO", NOTICENO);
            dics.Add("CHANNELNO", CHANNELNO);
            dics.Add("ORIGINALNOTICENO", ORIGINALNOTICENO);
            dics.Add("YWCODE", YWCODE);
            try
            {
                string url = "http://114.215.294.12:8080/nontax/services/remottingService";
                string[] param = new string[1];
                param[0] = getXml(dics);
                Log.CaptureError("", param[0]);
                msg = ServerHelper.InvokeWebServicea(url, "GetSearchPay_Info", param).ToString();
                webResult.Set("Success", false);
                webResult.Set("Data", msg);
                context.Response.Write(webResult);


            }
            catch (Exception e)
            {
                Log.CaptureError("msg", e.Message);
                throw new Exception(e.Message);
            }
        }
        //对请求的字段转换成xml的格式发送
        public string getXml(Dictionary<string, string> dics)
        {
            XmlDocument xml = new XmlDocument();
            XmlDeclaration xmldec = xml.CreateXmlDeclaration("1.0", "utf-8", null);
            xml.AppendChild(xmldec);
            XmlElement ele1 = xml.CreateElement("", "ROOT", "");
            xml.AppendChild(ele1);
            XmlElement ele2 = xml.CreateElement("REQUEST");
            XmlElement ele3 = null;
            foreach (var item in dics)
            {
                ele3 = xml.CreateElement("PARAM");
                ele3.SetAttribute("NAME", item.Key);
                ele3.InnerText = item.Value;
                ele2.AppendChild(ele3);
            }
            ele1.AppendChild(ele2);
            XmlElement ele4 = xml.CreateElement("REAPONSE");
            ele1.AppendChild(ele4);
            return xmlToString(xml);
        }
        #endregion
        #region 公共方法类
        /// <summary>  
        /// 将字符串（符合xml格式）转换为XmlDocument  
        /// </summary>  
        /// <param name="xmlString">XML格式字符串</param>  
        /// <returns></returns>  
        public XmlDocument ConvertStringToXmlDocument(string xmlString)
        {
            XmlDocument document = new XmlDocument();
            document.LoadXml(xmlString);
            return document;
        }
        public static string xmlToString(XmlDocument xmlDoc)
        {
            MemoryStream stream = new MemoryStream();
            XmlTextWriter writer = new XmlTextWriter(stream, null);
            writer.Formatting = Formatting.Indented; xmlDoc.Save(writer);
            StreamReader sr = new StreamReader(stream, System.Text.Encoding.UTF8);
            stream.Position = 0;
            string xmlString = sr.ReadToEnd();
            sr.Close();
            stream.Close();
            return xmlString;
        }
        #endregion
        
    }
}
