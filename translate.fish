function genToken -d "Created token gcloud"
    set gtoken (gcloud auth application-default print-access-token)
end

function translate -d "Translate very easy with one command!" -a "Words"
    set Auth "Authorization: Bearer $gtoken"
    set ContentType "Content-Type: application/json; charset=utf-8"
    set temp
    set URL "https://translation.googleapis.com/language/translate/v2"

    set resp (curl -X POST -H $Auth -H $ContentType --data $Data URL | jq '.data.translations[]["translatedText"]')


