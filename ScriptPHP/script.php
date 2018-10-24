<?php

$html = file_get_contents('https://coinmarketcap.com/');
preg_match_all("`https://s2.coinmarketcap.com/static/img/coins/16x16/(.*?).png`", $html, $icons);
preg_match_all("`<td class=\"no-wrap currency-name\" data-sort=\"(.*?)\">`", $html, $noms);

$i = 0;
for ($i = 0; $i < count($icons[1]); $i++):
    copy("https://s2.coinmarketcap.com/static/img/coins/128x128/" . $icons[1][$i] . ".png", '../coinMarketCap/' . $i . '+_+' . $noms[1][$i] . '.png');
    sleep(0.1);
endfor;