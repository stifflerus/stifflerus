serve: clean
	jekyll serve;

build: clean
	jekyll build;
	find ./_site -iname '*.html' -exec htmlmin {} {} \;;

deploy: build
	rsync -rv ./_site/ root@stiffler.us:/var/www/stiffler.us/;

clean:
	rm -rf _site;
	rm -rf .sass-cache