#!/usr/bin/fish
function translate -d "Translate very easy with one command!" -a "Words"
    if contains -- -en $argv
        set target en
    else
        set target vi
    end
    set gtoken (gcloud auth application-default print-access-token)
    set Auth "Authorization: Bearer $gtoken"
    set ContentType "Content-Type: application/json; charset=utf-8"
    set Data "{'q': '$Words', 'target': '$target', 'format': 'text'}"
    set URL "https://translation.googleapis.com/language/translate/v2"

    set resp (curl -X POST -H $Auth -H $ContentType --data $Data $URL 2>/dev/null | jq '.data.translations[]["translatedText"]')
    command notify-send -u normal -t 10000 $Words $resp

    echo $resp
    if not grep $resp $VOCABULARY > /dev/null
        echo (date --iso-8601=seconds)\t$Words\t$resp >> $VOCABULARY
    end
        
end

