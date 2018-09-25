document.addEventListener( "plusready",  function()
{
    var _BARCODE = 'NetWorkPrinter',
        B = window.plus.bridge;
    var NetWorkPrinter = 
    {
        StartConnect : function (host,port,successCallback, errorCallback ) 
        {
            callbackID = B.callbackId(successCallback, errorCallback);
            return B.exec(_BARCODE, "StartConnect", [callbackID,host,port]);
        },
        SendData : function(data,successCallback, errorCallback){
            callbackID = B.callbackId(successCallback, errorCallback);
            return B.exec(_BARCODE, "SendData", [callbackID,data]);
        },
        GetConnectStatus : function(successCallback, errorCallback){
            callbackID = B.callbackId(successCallback, errorCallback);
            return B.exec(_BARCODE, "GetConnectStatus", [callbackID]);
        }
    };
    window.plus.NetWorkPrinter = NetWorkPrinter;
}, true );
