$SearchTerm = "feeling lucky punk?"

$URL = "https://www.google.com/search?q=$SearchTerm&hl=en&lr=lang_en&btnI=I'm+Feeling+Lucky"

$ToRedirectURL = (Invoke-WebRequest -Uri $URL -ContentType "text/html; charset=utf-8" -Method Get -UseBasicParsing).BaseResponse.RequestMessage.RequestUri.AbsoluteUri

$RedirectResponse = Invoke-WebRequest -Uri $ToRedirectURL -ContentType "text/html; charset=utf-8" -Method Get -UseBasicParsing

if($RedirectResponse.Links) {
    $EndURL = ($RedirectResponse.Links|? href -like "*https://*"|? href -notlike "*https://*google*").href -replace "/url\?q=",""|select -First 1
} else {
    $EndURL = $ToRedirectURL
}

Start $EndURL
