var mui_old_back = mui.back;
var mui_is_switch = 1;
mui.back = function(){
	var arr = location.href.split('#');
	if(arr[1] == '/Home'){
		if(mui_is_switch == 1){
			mui.toast("再按一次退出应用");
			mui_is_switch = 2;
			setTimeout(function(){
				mui_is_switch = 1;
			},3);
		}else{
			plus.runtime.quit();
		}
	}else if(arr[1] == '/Cash'){
		location.href = arr[0]+'#/Home';
	}else if(arr[1].substr(0,arr[1].indexOf("?")) == '/Scan'){
		if(getQueryVariable("name") == 'Cash'){
			var urlname = '#/Cash';
		}
		location.href = arr[0]+'#/'+getQueryVariable("name");
	}else{
		mui_old_back();
	}
}
function getQueryVariable(variable)
{
	var query = location.href.substr(location.href.indexOf("?")+1);
    var vars = query.split("&");
   	for (var i=0;i<vars.length;i++) {
   		var pair = vars[i].split("=");
   		if(pair[0] == variable){return pair[1];}
   	}
    return(false);
}