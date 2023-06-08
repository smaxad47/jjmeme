#!/usr/bin/env bash

direrr() {
    echo -e "\e[41m[ERROR] You should run me under \e[1;33mthe root of this repository.\e[0m"
    exit 1
}

titleerr() {
    rm -f text/index.html
    echo -e "\e[41m[ERROR] The title of the article \e[1;33mcannot be found!\e[0m"
    exit 1
}

[[ -d "art" ]] || direrr
[[ -d "text" ]] || direrr

echo "Generating article directory..."

cat > "text/index.html" <<EOF
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="黑历史">
    <link rel="icon" href="/static/favicon.ico">
    <title>鸡盒历史 | 黑历史</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1.5.0/css/pico.min.css">
    <link rel="stylesheet" href="/static/style.css">
    <style>
        #view {
            text-align: left;
        }
    </style>
</head>

<body>
    <main class="container">
        <h1>鸡盒历史 | <a href="/">图片梗</a></h1>
        <h5 id="description"></h5>
        <article id="view">
            <github-md>
> _Text memes description._

EOF

for doc in art/*.md
do
    echo Adding "'${doc:4:-3}'" ...
    title="$(grep -E '^# ' "$doc" | head -n1)"
    [[ -z "$title" ]] && titleerr
    echo "- [${title:2}](./${doc:4:-3}.html)" >> "text/index.html"
done

cat >> "text/index.html" <<EOF
            </github-md>
        </article>

        <footer id="footer">
            <p>Bucket</p>
        </footer>
    </main>
</body>
<script src="https://cdn.jsdelivr.net/gh/MarketingPipeline/Markdown-Tag/markdown-tag.js"></script> 

</html>
EOF
