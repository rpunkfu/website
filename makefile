# makefile for generating/deploying the MARKET Protocol static site

## settings

# name of the AWS profile for deployment of the site to dev
DEV_PROFILE_NAME=dev-website-rw
PROD_PROFILE_NAME=prod-website-rw
# target AWS bucket for dev deployment
DEV_BUCKET=s3://dev.website.marketprotocol.io
PROD_BUCKET=s3://marketprotocol.io

# default make target
default:
	pwd


## prerequisites

# node path, if not otherwise set
# NODE_PATH=/usr/local/lib/node_modules/npm/node_modules

# initial installation
install:
	npm install

# update npm, if needed
update_npm:
	npm i npm

## local deployment

# start the development server (then connect to http://localhost:3000)
start:
	npm run start

# build for deployment
build:
	npm run build

## remote deployment


# DEV - display contents of deployed site
ls_dev:
	aws s3 --profile $(DEV_PROFILE_NAME) ls $(DEV_BUCKET)

# DEV - remove deployed site from s3 bucket
rm_dev:
	aws s3 --profile $(DEV_PROFILE_NAME) rm $(DEV_BUCKET) --recursive --exclude="telegram" --exclude="discord"

# DEV - deploy site to s3 bucket
deploy_dev:
	npm run build
	cp -r ./assets ./dist/
	aws s3 --profile $(DEV_PROFILE_NAME) cp dist/ $(DEV_BUCKET) --recursive


# PROD - display contents of deployed site
ls_prod:
	aws s3 --profile $(PROD_PROFILE_NAME) ls $(PROD_BUCKET)

# PROD - remove deployed site from s3 bucket
rm_prod:
	aws s3 --profile $(PROD_PROFILE_NAME) rm $(PROD_BUCKET) --recursive --exclude="telegram" --exclude="discord"

# PROD - deploy site to s3 bucket
deploy_prod:
	npm run build
	cp -r ./assets ./dist/
	aws s3 --profile $(PROD_PROFILE_NAME) cp dist/ $(PROD_BUCKET) --recursive

# Generate sitemap for website
sitemap:
	npm run sitemap https://marketprotocol.io public/sitemap.xml

# Generate sitemap for docs
sitemap_docs:
	npm run sitemap https://docs.marketprotocol.io public/docs_sitemap.xml




