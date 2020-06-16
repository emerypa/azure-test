build:
	mkdir build
	zip -r9 build/functions functions/* -x functions/*.* functions/node_modules/\*

plan:
	cd infrastructure && terraform plan

deploy:
	cd infrastructure && terraform apply