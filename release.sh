# replace version
cd Long-Cloud-Web
version=$(git describe --abbrev=0 --tags)
sed -i -e "s/\"version\": \"0.0.0\"/\"version\": \"$version\"/g" package.json
cat package.json

# build
pnpm install
node ./scripts/i18n.mjs
pnpm build
cp -r dist ../
cd ..

# commit to web-dist
cd Long-Cloud-Dist
rm -rf dist
cp -r ../dist .
git add .
git config --local user.email "2190008995@qq.com"
git config --local user.name "Long"
git commit --allow-empty -m "upload $version dist files" -a
git tag -a $version -m "release $version"
cd ..

mkdir compress
tar -czvf compress/dist.tar.gz dist/*
zip -r compress/dist.zip dist/*