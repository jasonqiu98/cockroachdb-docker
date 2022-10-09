# CockroachDB Docker (Insecure)

This demo follows the tutorial from the [link](https://www.cockroachlabs.com/docs/stable/build-a-go-app-with-cockroachdb.html?filters=local). The package `github.com/jackc/pgx/v4` is used, which is compatiable to `github.com/cockroachdb/cockroach-go/v2/crdb/crdbpgx` up to 9 October, 2022. If later versions of `pgx` or `cockroach-go` are used, you may find some hints for compatiability, still, from the previous link.

The LICENSE of the [project](https://github.com/cockroachlabs/example-app-go-pgx/) is included in the project as the CRUD example is completely borrowed from this project.

## Run the database client on the local machine

1. Enter the `client_local` folder by `cd client_local`.
2. If the Go module doesn't exist, run the following two commands.
   - `go mod init client`
   - Either option of the following two
     - Option I: `go get`
       - `go get github.com/cockroachdb/cockroach-go/v2/crdb/crdbpgx`
       - `go get github.com/jackc/pgx/v4`
       - `go get github.com/google/uuid`
     - Option II: `go mod tidy` (only when the persisting volume `data` is not already created)
3. Run `mkdir data` to create an (accessible) volume on the local machine.
4. Run `bash start.sh` to start a docker compose cluster of three CockroachDB nodes, and initialize one of them.
5. Run the main file by `go run main.go`. You can modify `connStr` to connect to a different path or database.
   - The database path can be any of the three: `localhost:26257`, `localhost:26258` or `localhost:26259`.
   - The database is currently `"bank"`, which is created through the `init/dbinit.sql` script. You can also create other databases or connect to `defaultdb`.
6. To end the project
   - Run `docker compose down -v` to remove the docker containers.
   - When you don't need the data anymore, run `sudo rm -rf data` to remove the persisting volumes of the database.

## Run the database client in the Docker container `client`

1. Enter the `client_docker` folder by `cd client_docker`.
2. Run `bash start.sh` to start a docker compose cluster of three CockroachDB nodes, and initialize one of them.
3. Run `cd /go/src/client` to enter the folder within the container.
4. If the Go module doesn't exist, run the following two commands.
   - `go mod init client`
   - `go mod tidy`
5. Run the main file by `go run main.go`. You can modify `connStr` to connect to a different path or database.
   - The database path can be any of the three: `roach1:26257`, `roach2:26257` or `roach3:26257`.
   - The database is currently `"bank"`, which is created through the `init/dbinit.sql` script. You can also create other databases or connect to `defaultdb`.
6. To end the project
   - Run `docker compose down -v` to remove the docker containers.
   - When you don't need the data anymore, run `sudo rm -rf data` to remove the persisting volumes of the database.
