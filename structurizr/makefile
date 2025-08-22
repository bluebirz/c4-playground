start:
	docker-compose -f ./docker-compose-local.yaml up -d 
	open http://localhost:8080

stop:
	docker-compose down	

clear:
	docker-compose down --volumes --rmi all

build:
	docker-compose -f ./docker-compose-builder.yaml build --build c4
