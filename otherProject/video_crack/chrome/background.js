function loadMatchParser(parser)
{
	var t = document.createElement('script');
	t.setAttribute("type", "text/javascript");
	t.setAttribute("src", parser);
	document.getElementsByTagName("head")[0].appendChild(t);
}

function callBack(tabId, changeInfo, tab)
{
	if(changeInfo.status == "loading")
	{
		var url = changeInfo.url;
		
		var obj = jQuery.parseJSON(crackList);
		for(i=0;i<obj.websiteList.length;++i)
		{
			var Reg = new RegExp(obj.websiteList[i].match);
			if(Reg.test(url))
			{
				chrome.pageAction.show(tabId);
				loadMatchParser(obj.websiteList[i].parser);
				getVideoUrl(tab.url);

				break;
			}
		}		
	}
}
chrome.tabs.onUpdated.addListener(callBack);

var count = 0;

function addVideoSegUrl(fileType, no, seconds, url)
{
	//alert("fileType: " + fileType + "no : " + no + "seconds: " + seconds + "url: "+ url);
}

function addVideoUrlsJson(outJson)
{
	if(window.localStorage)
		localStorage.videoUrlJson = outJson;
	else
		alert("You browser not support localStorage!");
}