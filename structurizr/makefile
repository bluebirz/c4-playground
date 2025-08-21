start:
	docker-compose up -d -f ./docker-compose-local.yaml
	open http://localhost:8080

stop:
	docker-compose down	

clear:
	docker-compose down --volumes --rmi all

build:
	docker-compose build -f ./docker-compose-builder.yaml --build c4
