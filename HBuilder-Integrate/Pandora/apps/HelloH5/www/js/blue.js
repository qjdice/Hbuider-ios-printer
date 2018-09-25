document.addEventListener( "plusready",  function()
{
    var _BARCODE = 'BluePrinter',
        B = window.plus.bridge;
    var BluePrinter = 
    {
        Scanning : function (successCallback, errorCallback ) 
        {
            callbackID = B.callbackId(successCallback, errorCallback);
            return B.exec(_BARCODE, "Scanning", [callbackID]);
        },
        ConnectByIndex : function(index,successCallback,errorCallback){
          callbackID = B.callbackId(successCallback, errorCallback);
          return B.exec(_BARCODE, "ConnectByIndex", [callbackID,index]);
        },
        ConnectByUUID : function(uuid,successCallback,errorCallback){
          callbackID = B.callbackId(successCallback,errorCallback);
          return B.exec(_BARCODE, "ConnectByUuid", [callbackID,uuid]);
        },
        SendData : function(data,successCallback,errorCallback){
          callbackID = B.callbackId(successCallback,errorCallback);
          return B.exec(_BARCODE,"SendData",[callbackID,data]);
        }
    };
    window.plus.BluePrinter = BluePrinter;
}, true );
