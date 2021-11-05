# Flyway

Flyway is an image that allows you to perform migrations against a MySQL server.

MySQL version is 5.7.x.

## Usage

```
docker run -v [Your migration file dir]:[Your migration file dir] chatwork/flyway:latest migrate \
    -user="[Your Database user]" \
    -password="[Your Database password]" \
    -url="jdbc:mysql://[Your Database host]/[Your Database name]" \
    -locations=filesystem:[Your migration file dir]
```
