function getInfo()
{
	if(window.localStorage)
	{
		var obj = jQuery.parseJSON(localStorage.videoUrlJson);	
		var str = "";	
		var video = obj.video;
		for(fileType in video)
		{
			var files = video[fileType];		
			str += "<tr><td>" + fileType + "</td></tr>";
			for(i=0;i<files.length;++i)
			{
				var no = files[i].no;
				var duration = files[i].duration;
				var url = files[i].url;
				str += ("<tr><td>" + "<a href=" + url + ">" + no + "</a>" + "</td>" + "<td>" + url + "</td>" + "</tr>");
			}
		}
		document.getElementById("videoFile").innerHTML = str;
	}
	else
		alert("You browser not support localStorage!");
}
window.onload=getInfo;