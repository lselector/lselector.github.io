var ToolBar_Supported = ToolBar_Supported ;
if (ToolBar_Supported != null && ToolBar_Supported == true)
{
	//To Turn on/off Frame support, set Frame_Supported = true/false.
	Frame_Supported = false;

	// Customize default ICP menu color - bgColor, fontColor, mouseoverColor
	setDefaultICPMenuColor("99CCFF", "#000000", "#FF3300");

	// Customize toolbar background color
	setToolbarBGColor("#FFFFFF");
	// setToolbarBGColor("#000000");

	// display ICP Banner
	setICPBanner("/msdn-online/shared/graphics/banners/home-banner.gif","/msdn-online/default.asp","MSDN Online") ;

	//***** Add ICP menus *****

	// HOME
	addICPMenu("homeMenu", " Home", "", "/default.asp");

	// Magazines
	addICPMenu("magMenu", " Magazines", "", "/resources/magazines.asp");
	addICPSubMenu("magMenu", " Voices", "/voices/");
	addICPSubMenu("magMenu", " MSDN Magazine", "/msdnmag/");
	addICPSubMenu("magMenu", " MSJ", "/isapi/gomscom.asp?TARGET=/msj/");
	addICPSubMenu("magMenu", " MIND", "/isapi/gomscom.asp?TARGET=/mind/");
	addICPSubMenu("magMenu", " MSDN Newspaper", "/voices/news/");
	addICPSubMenu("magMenu", " MSDN Show", "/theshow/");

	// LIBRARIES
	addICPMenu("libMenu", " Libraries", "", "/resources/libraries.asp");
	addICPSubMenu("libMenu", " MSDN Library Home", "/library/default.asp");
	addICPSubMenu("libMenu", " Web Workshop Home", "/workshop/");
	addICPSubMenu("libMenu", " Code Center", "/code/");
	addICPSubMenu("libMenu", " Downloads", "/downloads/");

	// DEVELOPER CENTERS
	addICPMenu("devctrMenu", " Developer Centers", "", "/resources/devcenters.asp");
	addICPSubMenu("devctrMenu", " DirectX", "/directx/");
	addICPSubMenu("devctrMenu", " Exchange", "/exchange/");
	addICPSubMenu("devctrMenu", " Internet Explorer", "/ie/");
	addICPSubMenu("devctrMenu", " Office", "/office/");
	addICPSubMenu("devctrMenu", " SQL Server", "/sqlserver/");
	addICPSubMenu("devctrMenu", " Visio", "/visio/");
	addICPSubMenu("devctrMenu", " Windows 2000", "/windows2000/");
	addICPSubMenu("devctrMenu", " Windows Media", "/windowsmedia/");
	addICPSubMenu("devctrMenu", " XML", "/xml/default.asp");

	// RESOURCES
	addICPMenu("resourcesMenu", " Resources", "", "/resources/");
	addICPSubMenu("resourcesMenu", " Code Center", "/code/");
	addICPSubMenu("resourcesMenu", " Bug Center", "/bugs/");
	addICPSubMenu("resourcesMenu", " DLL Help Database", "/isapi/gosupport.asp?TARGET=/servicedesks/fileversion/default.asp?vartarget=msdn");
	addICPSubMenu("resourcesMenu", " Support Home", "/isapi/gosupport.asp?TARGET=/servicedesks/msdn/");
	addICPSubMenu("resourcesMenu", " Newsgroups", "/newsgroups/");
	addICPSubMenu("resourcesMenu", " Peer Journal", "/peerjournal/");
	addICPSubMenu("resourcesMenu", " Members Helping Members", "/community/mhm/");
	addICPSubMenu("resourcesMenu", " User Groups", "/resources/usergroup/");
	addICPSubMenu("resourcesMenu", " Chats", "/chats/");
	addICPSubMenu("resourcesMenu", " Training", "/training/");
	addICPSubMenu("resourcesMenu", " Events", "/events/");
	addICPSubMenu("resourcesMenu", " Developer Books", "/resources/books.asp");
	addICPSubMenu("resourcesMenu", " MSDN for Students", "/students/");
	addICPSubMenu("resourcesMenu", " Component Resources", "/componentresources/");

	// DOWNLOADS
	addICPMenu("dlMenu", " Downloads", "", "/downloads/default.asp");
	
	// SEARCH MSDN
	addICPMenu("searchMenu", " Search MSDN", "", "/isapi/gosearch.asp?TARGET=/us/dev/default.asp");
}