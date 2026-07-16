#!/bin/bash
find themes/hugo-brewm/layouts -type f -exec perl -i -pe'
s/site\.Language\.Locale/site.LanguageCode/g;
s/\.Language\.Locale/\.Language\.LanguageCode/g;
s/site\.Language\.Label/site.Language.LanguageName/g;
s/\.Language\.Label/\.Language\.LanguageName/g;
s/site\.Language\.Direction/"ltr"/g;
s/\.Language\.Direction/"ltr"/g;
s/site\.Language\.LanguageDirection/"ltr"/g;
' {} +
