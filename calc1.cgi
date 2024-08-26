#!/usr/bin/perl -w
use strict; 
$|++;       # unbuffering STDOUT

use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
my $q = new CGI; 
my $rm = $q->param("rm") || "txt";              $rm = "gr" if ($rm ne "txt");
my $selindex = $q->param("selindex") || "1";

my $price = $q->param("price");                 $price = "24.95" if not defined $price;
                                                $price = "0.01" if $price < 0.01;
my $clicks = $q->param("clicks");               $clicks = "6000" if not defined $clicks;
                                                $clicks = "1" if $clicks < 1;
my $clickprice = $q->param("clickprice");       $clickprice = "0.05" if not defined $clickprice;
                                                # $clickprice = "0.000001" if $clickprice < 0.000001;
my $convpercent = $q->param("convpercent");     $convpercent = "0.5" if not defined $convpercent;
                                                $convpercent = "0.01" if $convpercent<0.01;
my $prodcost = $q->param("prodcost");           $prodcost = "4" if not defined $prodcost;
                                                $prodcost = "0.01" if $prodcost < 0.01;
my $returnpercent = $q->param("returnpercent"); $returnpercent = "5" if not defined $returnpercent;
                                                $returnpercent = "0.01" if $returnpercent < 0.01;
                                                $returnpercent = "100" if $returnpercent > 100;
                                                

# back end
my $letterprice = $q->param("letterprice");             $letterprice = "0" if not defined $letterprice;
                                                        $letterprice = "0" if $letterprice < 0;
my $letterconvpercent = $q->param("letterconvpercent"); $letterconvpercent = "0.01" if not defined $letterconvpercent;
                                                        $letterconvpercent = "0.01" if $letterconvpercent < 0.01;
my $price2 = $q->param("price2");                       $price2 = "0" if not defined $price2;
                                                        $price2 = "0" if $price2 < 0;
my $prod2cost = $q->param("prod2cost");                 $prod2cost = "0" if not defined $prod2cost;
                                                        $prod2cost = "0" if $prod2cost < 0;
my $return2percent = $q->param("return2percent");       $return2percent = "0" if not defined $return2percent;
                                                        $return2percent = "0" if $return2percent < 0;
                                                        $return2percent = "100" if $return2percent >100;


my $script = ${[split /\//, $0]}[-1]; # name of the CGI script without the path

my $show_graph_flag = 0;
# ---------------------------
# now we are ready to dp the work
# ---------------------------

my %results = ();
&docalc(\%results);
if ($rm ne "gr"){&show_html(\%results)}else{&show_graph(\%results)}

exit();
# ------------------------------------------------
# end of the main part
# ------------------------------------------------

=pod

=cut

# ------------------------------------------------
# docalc()
# ------------------------------------------------
sub docalc {
  my $res=shift;
  $res->{clicks_cost} = $clickprice * $clicks; # My clicks cost me a total of ...
  $res->{n_orders} = $clicks * $convpercent * 0.01;
  $res->{clicks_cost_per_sale} = $clickprice / ($convpercent * 0.01);
  $res->{cost_per_sale} = $prodcost + $res->{clicks_cost_per_sale} + ($returnpercent*0.01)*$price;
  $res->{net_profit_per_sale} = $price - $res->{cost_per_sale};
  $res->{costs} = $price - $prodcost - ($returnpercent*0.01)*$price;
  $res->{costs} = 0.001 if abs($res->{costs}) < 0.001;
  $res->{zero_profit_conversion} = 100.0*$clickprice / $res->{costs};  
  $res->{gross_sales} = $price * $res->{n_orders};
  $res->{net_profit} = $res->{net_profit_per_sale} * $res->{n_orders};
  $res->{per_click_profit} = $res->{net_profit} / $clicks;
  
  # --------------
  # half conversion for front end
  # --------------
  $res->{n_orders_half} = $res->{n_orders} / 2.0;
  $res->{clicks_cost_per_sale_half} = $clickprice / ($convpercent * 0.01 * 0.5);
  $res->{cost_per_sale_half} = $prodcost + $res->{clicks_cost_per_sale_half} + ($returnpercent*0.01)*$price;
  $res->{net_profit_per_sale_half} = $price - $res->{cost_per_sale_half};
  $res->{gross_sales_half} = $price * $res->{n_orders_half};
  $res->{net_profit_half} = $res->{net_profit_per_sale_half} * $res->{n_orders_half};

  # --------------
  # back end
  # --------------
  $res->{be_mailprice} = $res->{n_orders} * $letterprice;
  $res->{be_n_orders} = $res->{n_orders} * $letterconvpercent *0.01;
  $res->{be_gross_sales} = $price2 * $res->{be_n_orders};
  
  $res->{be_mail_cost_per_sale} = $letterprice / ($letterconvpercent * 0.01);
  $res->{be_cost_per_sale} = $prod2cost + $res->{be_mail_cost_per_sale} + ($return2percent*0.01)*$price2;
  $res->{be_net_profit_per_sale} = $price2 - $res->{be_cost_per_sale};

  $res->{be_net_profit} = $res->{be_net_profit_per_sale} * $res->{be_n_orders};
  $res->{be_visitor_value} = ($res->{n_orders} > 0)? $res->{be_net_profit} / $res->{n_orders} : 0;
   
  $res->{total_profit} = $res->{net_profit} + $res->{be_net_profit};
  $res->{total_visitor_value} = $res->{total_profit} / $clicks;
  $res->{total_gross_sales} = $res->{gross_sales} + $res->{be_gross_sales};

  # --------------
  # half conversion for back end
  # --------------
  $res->{be_mailprice_half} = $res->{n_orders_half} * $letterprice;
  $res->{be_n_orders_half} = $res->{n_orders_half} * $letterconvpercent * 0.01 * 0.5;
  $res->{be_gross_sales_half} = $price2 * $res->{be_n_orders_half};
  
  $res->{be_mail_cost_per_sale_half} = $letterprice / ($letterconvpercent * 0.01 * 0.5);
  $res->{be_cost_per_sale_half} = $prod2cost + $res->{be_mail_cost_per_sale_half} 
     + ($return2percent*0.01)*$price2;
  $res->{be_net_profit_per_sale_half} = $price2 - $res->{be_cost_per_sale_half};

  $res->{be_net_profit_half} = $res->{be_net_profit_per_sale_half} * $res->{be_n_orders_half};
   
  $res->{total_profit_half} = $res->{net_profit_half} + $res->{be_net_profit_half};
  $res->{total_visitor_value_half} = $res->{total_profit_half} / $clicks;
  $res->{total_gross_sales_half} = $res->{gross_sales_half} + $res->{be_gross_sales_half};


}


# ------------------------------------------------
# mysel()
# ------------------------------------------------
sub mysel {
  my $val = shift;
  return "SELECTED" if ($selindex == $val);
  return "";
}  

# ------------------------------------------------
# show_html()
# ------------------------------------------------
sub show_html {
  my $res=shift;
  
  my $mygraphtag = "";
  if ($show_graph_flag == 1) {
    $mygraphtag = qw{<img src="$script?rm=gr" width="70" height="50" 
           hspace="10" vspace="10" border="1" align="left">};
  }
  my $color1 = '99ccff';
  my $color2 = 'ffffcc'; #'ccccff';
  
  print "Content-type: text/html\n\n";
  print <<EOT;
<html>
<head>
<style>
  BODY, TD, TH, P, DIV, blockquote, li, ol, ul 
           { FONT-FAMILY: arial, geneva, helvetica; FONT-SIZE: 9pt; }
  A:hover  { COLOR: #FF0000; background: #FFA; TEXT-DECORATION: underline } 
</style>
<script>

// -----------------------------------
// -----------------------------------
function setpreset(val) { 
  var f1 = document.form1; 
  // var msg = "OK to populate the fields?"; 
  // if (!confirm(msg)) return;  
  f1.selindex.value=val;
  if (val=="1") {
    f1.price.value=24.95;          f1.prodcost.value=4;         f1.clicks.value=6000;
    f1.clickprice.value=0.05;      f1.convpercent.value=0.5;    f1.returnpercent.value=5;
    f1.price2.value=0;             f1.prod2cost.value=0;        f1.letterprice.value=0;
    f1.letterconvpercent.value=0;  f1.return2percent.value=0;
  } else if (val=="2") {
    f1.price.value=49.95;          f1.prodcost.value=0;         f1.clicks.value=6000;
    f1.clickprice.value=0.10;      f1.convpercent.value=2;      f1.returnpercent.value=5;
    f1.price2.value=0;             f1.prod2cost.value=0;        f1.letterprice.value=0;
    f1.letterconvpercent.value=0;  f1.return2percent.value=0;
  } else if (val=="3") {
    f1.price.value=97.00;          f1.prodcost.value=0;         f1.clicks.value=6000;
    f1.clickprice.value=0.10;      f1.convpercent.value=5;      f1.returnpercent.value=5;
    f1.price2.value=0;             f1.prod2cost.value=0;        f1.letterprice.value=0;
    f1.letterconvpercent.value=0;  f1.return2percent.value=0;
  } else if (val=="4") {
    f1.price.value=49.95;          f1.prodcost.value=0;         f1.clicks.value=6000;
    f1.clickprice.value=0.1;       f1.convpercent.value=2;      f1.returnpercent.value=5;
    f1.price2.value=449.95;        f1.prod2cost.value=20;       f1.letterprice.value=0;
    f1.letterconvpercent.value=10; f1.return2percent.value=5;
  } else if (val=="5") {
    f1.price.value=49.95;          f1.prodcost.value=0;         f1.clicks.value=6000;
    f1.clickprice.value=0.05;      f1.convpercent.value=0.5;    f1.returnpercent.value=5;
    f1.price2.value=449.95;        f1.prod2cost.value=20;       f1.letterprice.value=4;
    f1.letterconvpercent.value=15; f1.return2percent.value=10;    
  } else if (val=="6") {
    f1.price.value=29.95;          f1.prodcost.value=2;         f1.clicks.value=5000;
    f1.clickprice.value=1;         f1.convpercent.value=2;      f1.returnpercent.value=5;
    f1.price2.value=449.95;        f1.prod2cost.value=20;       f1.letterprice.value=4;
    f1.letterconvpercent.value=15; f1.return2percent.value=10;
  }  
  return; 
}

</script>
</head>
<body>
<form name="form1" method="POST" action="$script">
<table align="center">
  <tr>
    <td><img src="images/lev60h45w.jpg" BORDER=0 height=60 width=45></td>
    <td valign="top"><font color="red" size="+2">Marketing Calculator</font>
    <br>by <a href="http://www.selectorweb.com">Lev Selector</a>, New York
    </td>
    <td>\&nbsp;</td>
    <td>1. Select a scenario.
    <br>2. Enter/correct the values in the text boxes.
    <br>3. Press the "calculate" button.
    </td>
  </tr>
</table>    
<table border="1" align="center"><tr><td>
<table cellpadding="0">
<tr bgcolor="#$color1">
  <td></td>
  <td align="center"><b>Front End</b></td>
  <td align="center"><b>Back End</b></td>
  <td colspan="2"></td>
</tr><tr>
  <td align="right">Number Of Prospects (Clicks)</td>
  <td><input type="text" name="clicks" value="$clicks" size="8" maxlength="8"></td>
  <td>(from 1st step)</td>
  <td colspan="2" rowspan="6" align="center" valign="bottom">
    <b>Select a scenario:</b><br>
    <select name="preset" multiple size=6
        onChange="javascript:setpreset(this.options[this.selectedIndex].value)">
      <option value="1" @{[&mysel(1)]}>1. web\$25</option>
      <option value="2" @{[&mysel(2)]}>2. web\$50</option>
      <option value="3" @{[&mysel(3)]}>3. web\$97</option>
      <option value="4" @{[&mysel(4)]}>4. web\$50+web\$450</option>
      <option value="5" @{[&mysel(5)]}>5. web\$50+mail\$450</option>
      <option value="6" @{[&mysel(6)]}>6. mail\$30+mail\$450</option>
    </select>
    <br><input type="submit" name="submit" value="calculate">
    <br><br>
  </td>
</tr><tr>
  <td align="right">Price Per Prospect(click,letter,etc.) \$</td>
  <td><input type="text" name="clickprice" value="$clickprice" size="8" maxlength="8"></td>
  <td><input type="text" name="letterprice" value="$letterprice" size="8" maxlength="8"></td>
</tr><tr>
  <td align="right">Product Sale Price \$</td>
  <td><input type="text" name="price" value="$price" size="8" maxlength="8"></td>
  <td><input type="text" name="price2" value="$price2" size="8" maxlength="8"></td>
</tr><tr>
  <td align="right">Fulfillment Cost \$</td>
  <td><input type="text" name="prodcost" value="$prodcost" size="8" maxlength="8"></td>
  <td><input type="text" name="prod2cost" value="$prod2cost" size="8" maxlength="8"></td>
</tr><tr>
  <td align="right">Conversion (\%)</td>
  <td><input type="text" name="convpercent" value="$convpercent" size="8" maxlength="8"></td>
  <td><input type="text" name="letterconvpercent" value="$letterconvpercent" size="8" maxlength="8"></td>
</tr><tr>
  <td align="right">Refunds (\%)</td>
  <td><input type="text" name="returnpercent" value="$returnpercent" size="8" maxlength="8"></td>
  <td><input type="text" name="return2percent" value="$return2percent" size="8" maxlength="8"></td>
</tr><tr bgcolor="#$color1">
  <td><b>Results</td>
  <td align="center"><b>Front End</b></td>
  <td align="center"><b>Back End</b></td>
  <td align="center"><b>Total</b></td>
  <td align="center"><b>Total at Half<br>Conversion</b></td>
</tr><tr>
  <td align="right">Clicks/letters</td>
  <td align="right" nowrap>@{[&fmt_number($clicks)]}\&nbsp;\&nbsp;</td>
  <td align="right" nowrap>@{[&fmt_number($res->{n_orders})]}\&nbsp;\&nbsp;</td>
  <td align="right" nowrap>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap>\&nbsp;\&nbsp;</td>
</tr><tr>
  <td align="right">Cost of clicks/letters</td>
  <td align="right" nowrap>@{[&fmt_dollars($res->{clicks_cost})]}\&nbsp;\&nbsp;</td>
  <td align="right" nowrap>@{[&fmt_dollars($res->{be_mailprice})]}\&nbsp;\&nbsp;</td>
  <td align="right" nowrap>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap>\&nbsp;\&nbsp;</td>
</tr><tr>
  <td align="right">Number of orders</td>
  <td align="right" nowrap>@{[&fmt_number($res->{n_orders})]}\&nbsp;\&nbsp;</td>
  <td align="right" nowrap>@{[&fmt_number($res->{be_n_orders})]}\&nbsp;\&nbsp;</td>
  <td align="right" nowrap>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap>\&nbsp;\&nbsp;</td>
</tr><tr bgcolor="#$color2">
  <td align="right"><b>Gross Sales</b></td>
  <td align="right" nowrap><b>@{[&fmt_dollars_bold($res->{gross_sales})]}</b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>@{[&fmt_dollars_bold($res->{be_gross_sales})]}</b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>@{[&fmt_dollars_bold($res->{total_gross_sales})]}</b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>@{[&fmt_dollars_bold($res->{total_gross_sales_half})]}</b>\&nbsp;\&nbsp;</td>
</tr><tr bgcolor="#$color2">
  <td align="right"><b>Net profit</b></td>
  <td align="right" nowrap><b>@{[&fmt_dollars_bold($res->{net_profit})]}</b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>@{[&fmt_dollars_bold($res->{be_net_profit})]}</b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b><u>@{[&fmt_dollars_bold($res->{total_profit})]}</u></b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b><u>@{[&fmt_dollars_bold($res->{total_profit_half})]}</u></b>\&nbsp;\&nbsp;</td>
</tr><tr bgcolor="#$color2">
  <td align="right"><b>Prospect Value</b></td>
  <td align="right" nowrap><b>@{[&fmt_dollars_bold($res->{per_click_profit})]}</b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>@{[&fmt_dollars_bold($res->{be_visitor_value})]}</b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>@{[&fmt_dollars_bold($res->{total_visitor_value})]}</b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>@{[&fmt_dollars_bold($res->{total_visitor_value_half})]}</b>\&nbsp;\&nbsp;</td>
</tr>
<tr>
  <td align="right">Ad cost per sale</td>
  <td align="right" nowrap>@{[&fmt_dollars($res->{clicks_cost_per_sale})]}\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
</tr><tr>
  <td align="right">Profit per sale</td>
  <td align="right" nowrap>@{[&fmt_dollars($res->{net_profit_per_sale})]}\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
</tr><tr>
  <td align="right">Break Even Conversion (\%) </td>
  <td align="right" nowrap>@{[&fmt_number($res->{zero_profit_conversion})]}\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
</tr><tr>
  <td align="right">Break Even Price </td>
  <td align="right" nowrap>@{[&fmt_dollars($res->{cost_per_sale})]}\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
  <td align="right" nowrap><b>\&nbsp;\&nbsp;</td>
</tr>
</table>
</td><tr></table>
<br>
<table border="1" align="center" width="600" cellpadding="10"><tr><td>
<p>This calculator can be used with any kind of advertising as long as you know
how much you are spending to get one new prospect to read your sales message. For
example, for the Internet Pay-Per-Click advertising, this "prospect" price is just
the price you pay per click. For direct mail, the "prospect" price is a sum of 
the costs of postage + envelope printing/stuffing + mailing list cost + any 
other expenses involved in making the mailing.
</p><p>
The same way you can use this calculator for any other kind of advertising
(email, space ads, TV, etc.).
</p><p>
You can use this calculator for 1-step marketing ("Front End" offer only), or for 
2-step marketing, when you offer an additional "Back End" product(s) for all people,
who bought your "Front End" product.
</p><p>
If you are buying Pay-Per-Click advertising (Google, Overture) or exit traffic,
then set the price per visitor (click) to what you are paying. The product price may be
the actual sales price, or, if you are an affiliate selling somebody else's product - then
set the price to what you are paid for each sale.
</p><p>
On the other side, if you sell your product via an affiliate program - then you
are not paying per click (so set price per visitor to zero), but you are paying 
a percentage of sales. So to estimate how much money you will make - simply reduce
the price point (deduct what you are paying to an affiliate).
</p><p>
If you have a Joint Venture (JV) structured so that you split the profits - then you don't 
have to do anything special - just split the value of the calculated Net Profit.
</p><p>
Usually your costs are fixed, but your conversion may fluctuate. It is recommended
that you have sufficient safe margin for your conversion. That is, even if your 
conversion drops to 50% - you still should be making money.
</p>
</td></tr></table>

<input type="hidden" name="rm" value="txt">
<input type="hidden" name="selindex" value="$selindex">
</form>
$mygraphtag
<p></p>
<p></p>
<p></p>
<p align="center">\&copy; 2003 Selectorweb, Inc. (<a href="http://www.selectorweb.com">www.selectorweb.com</a>)</p>
<p align="center">Contact Lev Selector in New York: (212) 795-3979 (Lev.Selector AT gmail.com)</p>
</body>
</html>


EOT

}


# ------------------------------------------------
# with_commas()
# ------------------------------------------------
sub with_commas {
  my $ss = shift;
  $ss = reverse $ss;
  $ss =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/g;
  return scalar reverse $ss;
}

# ------------------------------------------------
# fmt_dollars()
# ------------------------------------------------
sub fmt_dollars {
  my $ss = shift;
  my $sign="";
  if ($ss<0) {$ss = -$ss; $sign="-";}
  $ss = sprintf("%.2f",$ss);
  $ss = &with_commas($ss);
  $ss = '$' . $ss;
  if ($sign) { $ss = '<font color="red">(' . $ss . ')</font>'; }
  return $ss;
}

# ------------------------------------------------
# fmt_dollars_bold()
# ------------------------------------------------
sub fmt_dollars_bold {
  my $ss = shift;
  my $sign="";
  my $color = '#330099';
  if ($ss<0) {$ss = -$ss; $sign="-";}
  $ss = sprintf("%.2f",$ss);
  $ss = &with_commas($ss);
  $ss = '$' . $ss;
  if ($sign) { $color = 'red'; $ss = '(' . $ss . ')'; }
  $ss = '<font color="' . $color . '">' . $ss . '</font>'; 
  return $ss;
}


# ------------------------------------------------
# fmt_number()
# ------------------------------------------------
sub fmt_number {
  my $ss = shift;
  $ss = sprintf("%.2f",$ss);
  return &with_commas($ss);
}


sub show_graph {}


# ------------------------------------------------
# show_graph()
# ------------------------------------------------
# sub show_graph {
#   my $res=shift;
#   use GD::Graph::linespoints;
#   my @data = (
#     [qw(-50% -25% -10% 1 +25% +50% +100%)],
#     [1.0,2.0,3.0,4.0,5.0,6.0,7.0],
#     );
# 
#   my $chart = new GD::Graph::linespoints(700,500);
#   $chart->set(
#     x_label => 'Conversion',
#     y_label => 'Visitor Value',
#     title   => 'Visitor Value As A Function Of Conversion (NOT WORKING YET !!)',
#     y_long_ticks => 1,
#     markers => [1],
#     marker_size => 8,
#     line_types => [4],
#     line_width => 3,
#     ) or die $chart->error;;
#   $chart->set_legend('Visitor Value') or die $chart->error;
# 
#   my $gd = $chart->plot(\@data) or die $chart->error;
#   my $format = $chart->export_format;
# 
#   # open(IMG, ">testfile.$format") or die "open >image.$format: $!";
#   # binmode IMG;
#   # close IMG;
# 
#   print header("image/$format");
#   binmode STDOUT;
#   print $gd->$format();
# 
# }
# 

# ------------------------------------------------
1;
