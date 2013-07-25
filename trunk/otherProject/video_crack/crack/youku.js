
parserLoaded = true;

//get sid.
function getSid()
{
	var currentTimeInMs = new Date().getTime();
	var num1kto2k = 1000 + Math.floor(Math.random()*999);
	var num1kto10k = 1000 + Math.floor(Math.random()*9000);
	var sid = currentTimeInMs.toString() + num1kto2k.toString() + num1kto10k.toString();

	return sid;  
}
//get mixed.
function getMixed(seed)
{
	var mixed="";
	
	var source = new Array();
	var sourceStr = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/\\:._-1234567890";
	for(i=0;i<sourceStr.length;++i)
		source.push(sourceStr.charAt(i));

	var len = source.length;
	for(i=0;i<len;++i)
	{
		seed = ( seed * 211 + 30031 ) & 0xFFFF;
		var index = Math.floor( seed * source.length >> 16 );
		mixed+=source[index];
		source.splice(index, 1);
	}
	return mixed;
}

//get key.
function getKey(key1, key2)
{
	var key1Int = parseInt(key1, 16);
	key1Int ^= 0xA55AA5A5;
	
	var key = key2 + key1Int;
	
	return key;
}

//get file real id.
function getRealId(streamFileIds, mixed)
{
	var realId = "";
	
	var idx = streamFileIds.split("*");
	for(i=0;i<idx.length-1;++i)
	{
		var index = parseInt(idx[i]);
		realId+=mixed.charAt(index);
	}
	
	return realId;
}

function parseResponse(response)
{
	var obj = jQuery.parseJSON(response);
	var sid = getSid();
	
	var seed = obj.data[0].seed;
	var mixed = getMixed(seed);

	//var key1 = obj.data[0].key1;
	//var key2 = obj.data[0].key2;	
	//var key = getKey(key1, key2);

	var fileTypeMap = {
		"hd2":"flv",
		"mp4":"mp4",
		"flv":"flv"
	};

	var outJson = "{\"video\":{";
	var segs = obj.data[0].segs;
	
	var needDou = false;
	for(seg in segs)
	{		
		var streamFileIds = obj.data[0].streamfileids[seg];
		var realId = getRealId(streamFileIds, mixed);		
		
		var fileType;
		var streamType = seg;
		for(t in fileTypeMap)
		{
			if(t == streamType)
			{
				fileType = fileTypeMap[t];
				break;
			}
		}
		
		if(needDou)
			outJson += ",";
		needDou = true;

		outJson += ( "\"" + fileType + "\"" + ":[");
		var segemnet = segs[seg];
		var urlBase = "http://f.youku.com/player/getFlvPath/sid/";
	
		var needDou2 = false;
		for(i=0;i<segemnet.length;++i)
		{
			var iNo = parseInt(segemnet[i].no);
			var noSrc = iNo.toString(16);
			var no = (noSrc.length>1)?(noSrc):('0'+noSrc);
			var k = segemnet[i].k;
			var seconds = segemnet[i].seconds;
			
			var url = urlBase + sid + '_' + no + "/st/" + fileType + "/fileid/"
				+ realId.substr(0,8) + no.toUpperCase() + realId.substr(10) + "?K="
				+ k + "&ts=" + seconds;
				
			addVideoSegUrl(fileType, iNo, seconds, url);
			
			if(needDou2)
				outJson += ",";
			needDou2 = true;

			
			outJson += ( "{" + "\"no\":" + "\"" + segemnet[i].no + "\"" + ","
				+ "\"duration\":" + "\"" + seconds + "\"" + ","
				+ "\"url\":" + "\"" + url + "\"" + "}");
		}
		outJson += "]";
	}
	outJson += "}}";
	addVideoUrlsJson(outJson);
}

var gCrossDomainRequest;
var gCrossDomainReqResponseCheckTimer;

function crossDomainReqResponseDataCheck()
{
	if((gCrossDomainRequest.readyState==4)&&(gCrossDomainRequest.status==200))
	{
		clearInterval(gCrossDomainReqResponseCheckTimer);
		parseResponse(gCrossDomainRequest.responseText);

	}
}
function getVideoUrl(url)
{
	url.match(/id_(\w*)\.html/);
	var sign = RegExp.$1;
	var reqUrl = "http://v.youku.com/player/getPlayList/VideoIDS/"+sign;
	var xhr;
	
	var ua = navigator.userAgent.toLowerCase();
	if(ua.indexOf("qtembedded")!=-1)
	{
		gCrossDomainRequest = new CrossDomainRequest();
		gCrossDomainRequest.open("GET", reqUrl, true);
		gCrossDomainRequest.send();	
		gCrossDomainReqResponseCheckTimer = setInterval( crossDomainReqResponseDataCheck , 50);
	}
	else
	{
		if(window.XMLHttpRequest) // code for IE7+, Firefox, Chrome, Opera, Safari
			xhr = new XMLHttpRequest();
		else // code for IE6, IE5
			xhr=new ActiveXObject("Microsoft.XMLHTTP");
		xhr.open("GET", reqUrl, true);
		xhr.onreadystatechange=function(){
			if((xhr.readyState==4)&&(xhr.status==200)){
				parseResponse(xhr.responseText);
			}
		};
		xhr.send();
	}
}
