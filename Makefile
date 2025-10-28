postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=rootC -e POSTGRES_PASSWORD=admin.2789 -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=rootC --owner=rootC simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgres://rootC:admin.2789@localhost:5432/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgres://rootC:admin.2789@localhost:5432/simple_bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
# 	go test -v ./...
	go test -v -cover ./...
# cover:
# 	go test -v -cover -coverprofile=$(COVER_PROFILE) ./...
# # 	go tool cover -func=$(COVER_PROFILE)

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test
