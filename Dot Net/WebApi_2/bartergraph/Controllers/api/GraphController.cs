using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;

namespace bartergraph.Controllers.api
{
    public class GraphController : ApiController
    {
        private string _lastMatchedTraderId = "";

        private List<Models.GraphDataModels> _matchedTrading = new List<Models.GraphDataModels>();

        [ResponseType(typeof(List<Models.GraphDataModels>))]
        [ActionName("data")]
        public IHttpActionResult GetGraphData(string id)
        {
            List<Models.GraphDataModels> result = new List<Models.GraphDataModels>();

            var data = GetTradeData(id);

            if (data != null)
            {
                result.Add(data);

                var requestData = GetRequestData(id);

                if (requestData != null)
                {
                    var tempData = GetRelatedDatas(requestData.Tag, data.Tag, id);

                    if (tempData != null && tempData.Count > 0)
                    {
                        result.AddRange(tempData);
                    }
                }

                if (!string.IsNullOrEmpty(_lastMatchedTraderId))
                {
                    result[0].TargetId = _lastMatchedTraderId;
                }
            }

            return Ok(result);
        }

        private Models.GraphDataModels GetTradeData(string id)
        {
            Models.GraphDataModels result = null;

            //MS_TableConnectionString

            try
            {
                var conString = System.Configuration.ConfigurationManager.ConnectionStrings["MS_TableConnectionString"].ConnectionString;

                System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(conString);
                con.Open();

                var command = con.CreateCommand();
                command.CommandText = "SELECT A.TAG, A.NAME, A.USERNAME, A.ID, A.USERPROFILEIMG, B.IMGURL FROM ANGEL2015KL.TRADEITEMS A, ANGEL2015KL.TRADEITEMIMAGES B WHERE B.TRADEITEM = A.ID AND A.ID = @ID ";
                command.Parameters.AddWithValue("@ID", id);

                var reader = command.ExecuteReader();

                result = new Models.GraphDataModels();

                if (reader.Read())
                {
                    result.Tag = reader.GetString(0);
                    result.Name = reader.GetString(1);
                    result.UserName = reader.GetString(2);
                    result.TradeId = reader.GetString(3);
                    result.UserProfileImg = reader.GetString(4);
                    result.ItemImgUrl = reader.GetString(5);
                }
                con.Close();
            }
            catch (Exception ex)
            {

            }

            return result;
        }

        private List<Models.GraphDataModels> GetTradeDataByTag(string tag)
        {
            List<Models.GraphDataModels> result = null;

            try
            {
                var conString = System.Configuration.ConfigurationManager.ConnectionStrings["MS_TableConnectionString"].ConnectionString;

                System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(conString);
                con.Open();

                var command = con.CreateCommand();
                command.CommandText = "SELECT A.TAG, A.NAME, A.USERNAME, A.ID, A.USERPROFILEIMG, B.IMGURL FROM ANGEL2015KL.TRADEITEMS A, ANGEL2015KL.TRADEITEMIMAGES B WHERE B.TRADEITEM = A.ID AND A.TAG = @TAG ";
                command.Parameters.AddWithValue("@TAG", tag);

                var reader = command.ExecuteReader();

                result = new List<Models.GraphDataModels>();

                while (reader.Read())
                {
                    Models.GraphDataModels tempResult = new Models.GraphDataModels();
                    tempResult.Tag = reader.GetString(0);
                    tempResult.Name = reader.GetString(1);
                    tempResult.UserName = reader.GetString(2);
                    tempResult.TradeId = reader.GetString(3);
                    tempResult.UserProfileImg = reader.GetString(4);
                    tempResult.ItemImgUrl = reader.GetString(5);

                    result.Add(tempResult);
                }

                con.Close();
            }
            catch (Exception ex)
            {

            }

            return result;
        }

        private Models.GraphDataModels GetRequestData(string id)
        {
            Models.GraphDataModels result = null;

            //MS_TableConnectionString

            try
            {
                var conString = System.Configuration.ConfigurationManager.ConnectionStrings["MS_TableConnectionString"].ConnectionString;

                System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(conString);
                con.Open();

                var command = con.CreateCommand();
                command.CommandText = "SELECT A.TAG, A.NAME, A.ID, A.TRADEITEM FROM ANGEL2015KL.TRADEITEMREQUESTS A WHERE A.TRADEITEM = @ID ";
                command.Parameters.AddWithValue("@ID", id);

                var reader = command.ExecuteReader();

                result = new Models.GraphDataModels();

                if (reader.Read())
                {
                    result.Tag = reader.GetString(0);
                    result.Name = reader.GetString(1);
                    result.UserName = reader.GetString(2);
                    result.TradeId = reader.GetString(3);
                }
                con.Close();
            }
            catch (Exception ex)
            {

            }

            return result;
        }

        private List<Models.GraphDataModels> GetRelatedDatas(string tag, string stoppingTag, string targetId)
        {
            List<Models.GraphDataModels> result = new List<Models.GraphDataModels>();

            var data = GetTradeDataByTag(tag);

            if (data != null && data.Count > 0)
            {
                foreach (var itm in data)
                {
                    if (itm.Tag != stoppingTag)
                    {
                        var inListMatchedItem = (from a in _matchedTrading where a.Tag == itm.Tag select a).FirstOrDefault();

                        if (inListMatchedItem != null)
                        {
                            if (inListMatchedItem.TradeId == itm.TradeId)
                                continue;

                            itm.TargetId = inListMatchedItem.TargetId;
                            result.Add(itm);
                            continue;
                        }

                        itm.TargetId = targetId;
                        result.Add(itm);

                        Models.GraphDataModels matchedItem = new Models.GraphDataModels();
                        matchedItem.TargetId = itm.TargetId;
                        matchedItem.Tag = itm.Tag;
                        matchedItem.TradeId = itm.TradeId;
                        _matchedTrading.Add(matchedItem);

                        var requestData = GetRequestData(itm.TradeId);

                        if (requestData != null)
                        {
                            var innerData = GetRelatedDatas(requestData.Tag, stoppingTag, itm.TradeId);

                            if (innerData != null && innerData.Count > 0)
                            {
                                result.AddRange(innerData);
                            }
                        }
                    }
                    else
                    {
                        //Bingo! Circle matched.
                        _lastMatchedTraderId = targetId;
                    }
                }
            }

            return result;
        }
    }
}
