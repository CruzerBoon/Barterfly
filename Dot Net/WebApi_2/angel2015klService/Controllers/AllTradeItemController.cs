using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Microsoft.WindowsAzure.Mobile.Service;
using angel2015klService.DataObjects;
using angel2015klService.Models;
using Microsoft.WindowsAzure.Mobile.Service.Security;

namespace angel2015klService.Controllers
{
    //[AuthorizeLevel(AuthorizationLevel.Anonymous)]
    public class AllTradeItemController : ApiController
    {
        public ApiServices Services { get; set; }

        // GET api/AllTradeItem
        [HttpGet]
        public List<TradeItemModel> AllTradeItem()
        {
            List<TradeItemModel> result = null;
            TradeItemModel tradeItemModel = null;

            List<TradeItemImgModel> tradeItemImgModelList = null;
            TradeItemImgModel tradeItemImgModel = null;

            angel2015klService.Models.angel2015klContext context = new Models.angel2015klContext();
            var queryResults = from item in context.TradeItems
                               select item;
            if (queryResults != null)
            {
                result = new List<TradeItemModel>();

                foreach (TradeItem itm in queryResults)
                {
                    tradeItemModel = new TradeItemModel();

                    tradeItemModel.Id = itm.Id;
                    tradeItemModel.UserId = itm.UserId;
                    tradeItemModel.UserName = itm.UserName;
                    tradeItemModel.UserProfileImg = itm.UserProfileImg;
                    tradeItemModel.Name = itm.Name;
                    tradeItemModel.Remark = itm.Remark;
                    tradeItemModel.Category = itm.Category;
                    tradeItemModel.Tag = itm.Tag;
                    tradeItemModel.CreditpointFloor = itm.CreditpointFloor;
                    tradeItemModel.CreditpointCap = itm.CreditpointCap;
                    tradeItemModel.PurchasePrice = itm.PurchasePrice;
                    tradeItemModel.PostExpireDate = itm.PostExpireDate;
                    tradeItemModel.ExchangeMethod = itm.ExchangeMethod;
                    tradeItemModel.Condition = itm.Condition;
                    tradeItemModel.Reason = itm.Reason;
                    tradeItemModel.ManufacturedDate = itm.ManufacturedDate;
                    tradeItemModel.ExpireDate = itm.ExpireDate;
                    tradeItemModel.Latitude = itm.Latitude;
                    tradeItemModel.Longitude = itm.Longitude;
                    tradeItemModel.Altitude = itm.Altitude;
                    tradeItemModel.IsActive = itm.IsActive;

                    result.Add(tradeItemModel);
                }

                foreach (TradeItemModel itmResult in result)
                {
                    var queryTradeItemImg = from item in context.TradeItemImages
                                            where item.TradeItem == itmResult.Id
                                            select item;
                    if (queryTradeItemImg != null)
                    {
                        tradeItemImgModelList = new List<TradeItemImgModel>();

                        foreach (TradeItemImage img in queryTradeItemImg)
                        {
                            tradeItemImgModel = new TradeItemImgModel();
                            tradeItemImgModel.ImgUrl = img.ImgUrl;
                            tradeItemImgModel.Caption = img.Caption;

                            tradeItemImgModelList.Add(tradeItemImgModel);
                        }
                    }
                    itmResult.TradeItemImg = tradeItemImgModelList;
                }
            }

            tradeItemModel.TradeItemImg = tradeItemImgModelList;

            return result;
        }
    }
}
