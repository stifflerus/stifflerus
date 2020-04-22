serve: clean
	jekyll serve;

build: clean
	jekyll build;
	minify -v -r ./_site/ -o ./_site/

deploy: build
	rsync -rv ./_site/ root@stiffler.us:/var/www/stiffler.us/;

clean:
	rm -rf _site;
	rm -rf .sass-cache