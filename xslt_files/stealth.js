
	if (4 <= parseInt(navigator.appVersion))
	{

		// TURN DIVIDER LINE WHITE

		var aMenus = new Array("mag","lib","devctr","resources","dl");
		for (var i=0;i<aMenus.length;i++)
		{
			if (eMenu = document.all["ICP_" + aMenus[i] + "Menu"])
			{
				if (eHR = eMenu.children(0))
				{
					if ("HR" == eHR.tagName.toUpperCase())
					{
						eHR.style.color = "white";
					}
				}
			}
		}

	//	SET WIDTH FOR MENUS (SEE LOCAL.JS)

	if ("object" == typeof(ICP_devctrMenu)) ICP_devctrMenu.style.width = "180px";
	if ("object" == typeof(ICP_resourcesMenu)) ICP_resourcesMenu.style.width = "170px";
	if ("object" == typeof(ICP_dlMenu)) ICP_dlMenu.style.width = "170px";


	}

	// REMOVE LAST PIPE (AFTER SEARCH) ON ICP TB

	function RemoveLastPipe()
	{
		if ((eLink = document.all["AM_ICP_searchMenu"]) && (eSpan = document.all[eLink.sourceIndex + 2]))
		{
			if (eSpan.innerHTML && eSpan.innerHTML=="|") eSpan.innerHTML = "";
		}
	}