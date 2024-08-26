
var artSource='<IMG SRC=\"/library/images/msdn/art/';
var tmploc=location.href;
tmploc=tmploc.toLowerCase();
tmploc=tmploc.substring(tmploc.indexOf("/library", 1));

if( self != top )
{
    var uiLoc = top.location.href;
    var showLink='<A href=\"/isapi/msdnlib.idc?theURL=' + tmploc + '\" TARGET=\"_top\">';
    var hideLink='<A href=\"/isapi/msdnlib2.idc?theURL=' + tmploc + '\" TARGET=\"_top\">';
    var functsource='<A href=\"#\" onClick=\"top.PRODINFO.LEFTNAV.document.Outline.move';

    if( "object" == typeof( document.all ) ) top.document.title = self.document.title;
    
    // If you're looking at the java applet only, otherwise, buttons are taken care of by the TOC.
    if( parent.parent && parent.parent.PRODINFO && location.href == parent.parent.PRODINFO.location.href)
    {
        document.write(showLink + artSource + 'mlibfram.gif\" WIDTH=75 HEIGHT=17 BORDER=0 ALT=\"Click to show the Table of Contents\"></A>');
    }
    else if ( parent.parent && parent.parent.PRODINFO )
    {
        document.write(functsource + 'Prev()\">' + artSource + 'mlibprev.gif\" WIDTH=18 HEIGHT=17 BORDER=0 ALT=\"Previous Document\"></A>' + functsource + 'Next()\">' + artSource + 'mlibnext.gif\" WIDTH=18 HEIGHT=17 BORDER=0 ALT=\"Next Document\"></A>' + hideLink + artSource + 'mlibhfram.gif\" WIDTH=88 HEIGHT=17 BORDER=0 ALT=\"Hide the TOC\">' + showLink + artSource + 'mlibsync.gif\" WIDTH=113 HEIGHT=17 BORDER=0 ALT=\"Synchronize TOC\"></A>');
    }
}
else
{
    var showLink = '<A HREF="/library/default.asp?URL=' + tmploc + '" TARGET="_top">';
    document.write(showLink + artSource + 'mlibfram.gif\" WIDTH=75 HEIGHT=17 BORDER=0 ALT=\"Click to show the Table of Contents\"></A>');
}

